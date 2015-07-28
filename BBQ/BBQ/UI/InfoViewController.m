//
//  InfoViewController.m
//  BBQ
//
//  Created by Start on 15/7/27.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

- (id)init{
    self=[super init];
    if(self){
        [self cTitle:@"Information"];
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"背景3"]]];
//        UIWebView *webView=[[UIWebView alloc]initWithFrame:self.view.bounds];
//        [webView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
//        [self.view addSubview:webView];
//        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"page.bundle/%@.html",@"info"]];
//        NSURL* url = [NSURL fileURLWithPath:path];
//        NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
//        [webView loadRequest:request];
        
        
        
    }
    return self;
}

@end
