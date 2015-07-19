//
//  AppViewController.m
//  ZMCY
//
//  Created by Start on 15/7/19.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "AppViewController.h"

@interface AppViewController ()

@end

@implementation AppViewController

- (id)init
{
    self=[super init];
    if(self){
        [self cTitle:@"应用"];
        self.mWebView=[[UIWebView alloc]initWithFrame:self.view.bounds];
        [self.mWebView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.view addSubview:self.mWebView];
        
        NSString *url=[NSString stringWithFormat:@"%@/66/ios_yingyong.html",HTTP_URL];
        [self.mWebView loadRequest:[NSURLRequest requestWithURL:[Common getUrl:url]]];
    }
    return self;
}

@end
