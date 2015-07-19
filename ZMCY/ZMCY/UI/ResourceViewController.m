//
//  ResourceViewController.m
//  ZMCY
//
//  Created by Start on 15/7/19.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "ResourceViewController.h"

@interface ResourceViewController ()

@end

@implementation ResourceViewController

- (id)init
{
    self=[super init];
    if(self){
        UIView *headView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 150, 44)];
        [headView setUserInteractionEnabled:YES];
        self.navigationItem.titleView=headView;
        self.button1=[[UIButton alloc]initWithFrame:CGRectMake1(0, 0, 75, 44)];
        [self.button1 setTitle:@"传统照明" forState:UIControlStateNormal];
        [self.button1.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [self.button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.button1 addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
        [self.button1 setTag:1];
        [headView addSubview:self.button1];
        self.button2=[[UIButton alloc]initWithFrame:CGRectMake1(75, 0, 75, 44)];
        [self.button2 setTitle:@"LED照明" forState:UIControlStateNormal];
        [self.button2.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [self.button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.button2 addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
        [self.button2 setTag:2];
        [headView addSubview:self.button2];
        
        self.mWebView=[[UIWebView alloc]initWithFrame:self.view.bounds];
        [self.mWebView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.view addSubview:self.mWebView];
        
        [self change:self.button1];
    }
    return self;
}

- (void)change:(UIButton*)sender
{
    NSString *url;
    if(sender.tag==1){
        [self.button1 setBackgroundColor:COLOR078187];
        [self.button2 setBackgroundColor:[UIColor clearColor]];
        url=[NSString stringWithFormat:@"%@/59/ios_qiye_list.html",HTTP_URL];
    }else if(sender.tag==2){
        [self.button1 setBackgroundColor:[UIColor clearColor]];
        [self.button2 setBackgroundColor:COLOR078187];
        url=[NSString stringWithFormat:@"%@/75/ios_qiye_list.html",HTTP_URL];
    }
    [self.mWebView loadRequest:[NSURLRequest requestWithURL:[Common getUrl:url]]];
}

@end
