//
//  ElecLoadDetailChartViewController.m
//  eClient
//
//  Created by Start on 4/16/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "ElecLoadDetailChartViewController.h"

@interface ElecLoadDetailChartViewController ()

@end

@implementation ElecLoadDetailChartViewController{
    NSDictionary *currentData;
}

- (id)initWithData:(NSDictionary*)data
{
    self=[super init];
    if(self){
        currentData=data;
        [self setTitle:@"详细负荷"];
        self.webView1 = [[UIWebView alloc] initWithFrame:self.view.bounds];
        [self.webView1 setUserInteractionEnabled:YES];
        [self.webView1 setScalesPageToFit:YES];
        [self.webView1 setBackgroundColor:[UIColor clearColor]];
        [self.webView1 setOpaque:NO];//使网页透明
        [self.webView1 setDelegate:self];
        [self.view addSubview:self.webView1];
        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"ichartjs.bundle/ChartIndexBurdenLine.html"];
        [self.webView1 loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath: path]]];
    }
    return self;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self performSelector:@selector(loadHttp) withObject:nil afterDelay:0.5];
}

- (void)loadHttp
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[[User Instance]getUserName] forKey:@"imei"];
    [params setObject:[[User Instance]getPassword] forKey:@"authentication"];
    [params setObject:[[[User Instance]getResultData]objectForKey:@"CP_ID"] forKey:@"QTCP"];
    [params setObject:@"010403" forKey:@"GNID"];
    [params setObject:[currentData objectForKey:@"EQ_NO"] forKey:@"QTKEY"];
    [params setObject:[currentData objectForKey:@"EQ_SORTNO"] forKey:@"QTKEY1"];
    [params setObject:[currentData objectForKey:@"EQ_TYPE"] forKey:@"QTVAL"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest handle:URL_appTaskingPower requestParams:params];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if([response successFlag]){
        NSArray *table2=[[response resultJSON]objectForKey:@"table2"];
        if(table2){
            NSMutableArray *v=[[NSMutableArray alloc]init];
            for(int i=0;i<[table2 count];i++){
                NSDictionary *d=[table2 objectAtIndex:i];
                float value=[[Common NSNullConvertEmptyString:[d objectForKey:@"AVG_LOAD"]]floatValue];
                if([table2 count]-1==i&&value<=0){
                    break;
                }
                [v addObject:[[NSNumber alloc]initWithFloat:value]];
            }
            NSMutableDictionary *d1=[[NSMutableDictionary alloc]init];
            [d1 setValue:v forKey:@"value"];
            [d1 setValue:@"当前负荷" forKey:@"name"];
            [d1 setValue:@"#1f7e92" forKey:@"color"];
            [d1 setValue:[[NSNumber alloc]initWithFloat:3] forKey:@"line_width"];
            NSMutableArray *jsondata=[[NSMutableArray alloc]init];
            [jsondata addObject:d1];
            NSString *jsonString = [[NSString alloc] initWithData:[Common toJSONData:jsondata] encoding:NSUTF8StringEncoding];
            [self.webView1 stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"refresh(%@);",jsonString]];
        }
    }
}

@end
