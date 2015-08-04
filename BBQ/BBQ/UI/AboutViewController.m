//
//  AboutViewController.m
//  BBQ
//
//  Created by Start on 15/7/29.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (id)init{
    self=[super init];
    if(self){
        [self cTitle:LOCALIZATION(@"About")];
        UIButton *bButton = [[UIButton alloc]init];
        [bButton setFrame:CGRectMake1(0, 0, 22, 30)];
        [bButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        [bButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [bButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:bButton];
        UIWebView *webView=[[UIWebView alloc]initWithFrame:self.view.bounds];
        [webView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.view addSubview:webView];
        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"page.bundle/%@.html",@"info"]];
        NSURL* url = [NSURL fileURLWithPath:path];
        NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
        [webView loadRequest:request];
    }
    return self;
}

- (void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
