//
//  NewsDetailViewController.m
//  ZMCY
//
//  Created by Start on 15/7/19.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "NewsDetailViewController.h"

@interface NewsDetailViewController ()

@end

@implementation NewsDetailViewController

- (id)initWithData:(NSDictionary*)data
{
    self=[super initWithData:data];
    if(self){
        self.bScreening = [[UIButton alloc]init];
        [self.bScreening setFrame:CGRectMake1(0, 0, 70, 30)];
        [self.bScreening setTitle:@"0评论" forState:UIControlStateNormal];
        [self.bScreening.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self.bScreening setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.bScreening.titleLabel setTextAlignment:NSTextAlignmentLeft];
        UIBarButtonItem *negativeSpacerRight = [[UIBarButtonItem alloc]
                                                initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                target:nil action:nil];
        negativeSpacerRight.width = -10;
        self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacerRight, [[UIBarButtonItem alloc] initWithCustomView:self.bScreening], nil];
        
        self.mWebView=[[UIWebView alloc]initWithFrame:self.view.bounds];
        [self.mWebView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.view addSubview:self.mWebView];
        
        self.Id=[self.data objectForKey:@"Id"];
        self.ClassId=[self.data objectForKey:@"ClassId"];
        
        NSString *Id=[self.data objectForKey:@"Id"];
        NSString *ClassId=[self.data objectForKey:@"ClassId"];
        NSString *url=[NSString stringWithFormat:@"%@/%@/%@/ios_news_ct.html",HTTP_URL,ClassId,Id];
        [self.mWebView loadRequest:[NSURLRequest requestWithURL:[Common getUrl:url]]];
        
        [self loadHttp];
    }
    return self;
}

- (void)loadHttp
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:self.Id forKey:@"Id"];
    [params setObject:self.ClassId forKey:@"classId"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setRequestCode:500];
    [self.hRequest handle:@"GetInfo" requestParams:params];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if([response successFlag]){
        if(reqCode==500){
            NSDictionary *d=[[response resultJSON]objectForKey:@"Data"];
            NSString *PLNum=[d objectForKey:@"PLNum"];
            [self.bScreening setTitle:[NSString stringWithFormat:@"%@评论",PLNum] forState:UIControlStateNormal];
        }
    }
}

@end
