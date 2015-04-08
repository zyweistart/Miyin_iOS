//
//  RunOverviewViewController.m
//  eClient
//
//  Created by Start on 4/8/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "RunOverviewViewController.h"

@interface RunOverviewViewController ()

@end

@implementation RunOverviewViewController{
    NSTimer *runOverViewTime;
    UIWebView *runOverviewwebView;
}

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"运行状态"];
        runOverviewwebView=[[UIWebView alloc]initWithFrame:self.view.bounds];
        [runOverviewwebView setScalesPageToFit:YES];
        //使网页透明
        [runOverviewwebView setOpaque:NO];
        [runOverviewwebView setBackgroundColor:[UIColor clearColor]];
        [runOverviewwebView setDelegate:self];
        NSString *path2 = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"ichartjs.bundle/ChartIndexRunOverview.html"];
        [runOverviewwebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path2]]];
        [self.view addSubview:runOverviewwebView];
        
        [self loadRunOverViewData];
    }
    return self;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self performSelector:@selector(loadRunOverViewData) withObject:nil afterDelay:0.5];
    if(runOverViewTime==nil){
        //5秒更新一次
        runOverViewTime = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(loadRunOverViewData) userInfo:nil repeats:YES];
    }
}

- (void)loadRunOverViewData
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[[User Instance]getCPNameId] forKey:@"CP_ID"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest handle:URL_AppIndexRunStatus requestParams:params];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    
    NSMutableArray *jsondata=[[NSMutableArray alloc]init];
    //运行总缆
    NSDictionary *data=[response resultJSON];
    if(data!=nil){
        NSDictionary *rows=[data objectForKey:@"Rows"];
        int result=[[rows objectForKey:@"result"] intValue];
        if(result==1){
            NSMutableArray *tmpData=[data objectForKey:@"IndexRunStatus"];
            if(tmpData){
                for(NSDictionary *d in tmpData){
                    NSMutableDictionary *d2=[[NSMutableDictionary alloc]init];
                    [d2 setValue:[Common NSNullConvertEmptyString:[d objectForKey:@"METER_NAME"]] forKey:@"name"];
                    [d2 setValue:[[NSNumber alloc]initWithFloat:[[Common NSNullConvertEmptyString:[d objectForKey:@"I_VALUE"]]floatValue]] forKey:@"value"];
                    [d2 setValue:[Common NSNullConvertEmptyString:[d objectForKey:@"COLOR"]] forKey:@"color"];
                    [jsondata addObject:d2];
                }
            }
        }
    }
    if([jsondata count]==0){
        //在没有数据的情况下
        NSMutableDictionary *d1=[[NSMutableDictionary alloc]init];
        [d1 setValue:@"空" forKey:@"name"];
        [d1 setValue:[[NSNumber alloc]initWithInt:0] forKey:@"value"];
        [d1 setValue:@"#ff0000" forKey:@"color"];
        [jsondata addObject:d1];
    }
    NSString *jsonString = [[NSString alloc] initWithData:[Common toJSONData:jsondata] encoding:NSUTF8StringEncoding];
    [runOverviewwebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"refresh(%@);",jsonString]];
}

@end