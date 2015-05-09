//
//  AboutUsViewController.m
//  DLS
//
//  Created by Start on 3/13/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"关于我们"];
        UIWebView *webView=[[UIWebView alloc]initWithFrame:self.view.bounds];
        [webView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.view addSubview:webView];
        
        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"page.bundle/%@.html",@"关于我们"]];
        
        NSURL* url = [NSURL fileURLWithPath:path];
        NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
        [webView loadRequest:request];
    }
    return self;
}


@end
