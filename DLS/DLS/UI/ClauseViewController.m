//
//  ClauseViewController.m
//  DLS
//  服务条款
//  Created by Start on 3/13/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "ClauseViewController.h"

@interface ClauseViewController ()

@end

@implementation ClauseViewController

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"服务条款"];
        UIWebView *webView=[[UIWebView alloc]initWithFrame:self.view.bounds];
        [webView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.view addSubview:webView];
        
        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"page.bundle/%@.html",@"服务条款"]];
        
        NSURL* url = [NSURL fileURLWithPath:path];
        NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
        [webView loadRequest:request];
    }
    return self;
}

@end
