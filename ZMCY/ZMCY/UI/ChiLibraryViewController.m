//
//  ChiLibraryViewController.m
//  ZMCY
//
//  Created by Start on 15/7/19.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "ChiLibraryViewController.h"

@interface ChiLibraryViewController ()

@end

@implementation ChiLibraryViewController

- (id)init
{
    self=[super init];
    if(self){
        UIView *headView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 200, 44)];
        [headView setUserInteractionEnabled:YES];
        self.navigationItem.titleView=headView;
        self.button1=[[UIButton alloc]initWithFrame:CGRectMake1(0, 0, 50, 44)];
        [self.button1 setTitle:@"专家" forState:UIControlStateNormal];
        [self.button1.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [self.button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.button1 addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
        [self.button1 setTag:1];
        [headView addSubview:self.button1];
        self.button2=[[UIButton alloc]initWithFrame:CGRectMake1(50, 0, 50, 44)];
        [self.button2 setTitle:@"问答" forState:UIControlStateNormal];
        [self.button2.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [self.button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.button2 addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
        [self.button2 setTag:2];
        [headView addSubview:self.button2];
        self.button3=[[UIButton alloc]initWithFrame:CGRectMake1(100, 0, 50, 44)];
        [self.button3 setTitle:@"能人" forState:UIControlStateNormal];
        [self.button3.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [self.button3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.button3 addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
        [self.button3 setTag:3];
        [headView addSubview:self.button3];
        self.button4=[[UIButton alloc]initWithFrame:CGRectMake1(150, 0, 50, 44)];
        [self.button4 setTitle:@"自荐" forState:UIControlStateNormal];
        [self.button4.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [self.button4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.button4 addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
        [self.button4 setTag:4];
        [headView addSubview:self.button4];
        
        self.mWebView=[[UIWebView alloc]initWithFrame:self.view.bounds];
        [self.mWebView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.view addSubview:self.mWebView];
        
        [self change:self.button1];
    }
    return self;
}

- (void)change:(UIButton*)sender
{
    if(sender.tag==1){
        [self.button1 setBackgroundColor:COLOR078187];
        [self.button2 setBackgroundColor:[UIColor clearColor]];
        [self.button3 setBackgroundColor:[UIColor clearColor]];
        [self.button4 setBackgroundColor:[UIColor clearColor]];
    }else if(sender.tag==2){
        [self.button1 setBackgroundColor:[UIColor clearColor]];
        [self.button2 setBackgroundColor:COLOR078187];
        [self.button3 setBackgroundColor:[UIColor clearColor]];
        [self.button4 setBackgroundColor:[UIColor clearColor]];
    }else if(sender.tag==3){
        [self.button1 setBackgroundColor:[UIColor clearColor]];
        [self.button2 setBackgroundColor:[UIColor clearColor]];
        [self.button3 setBackgroundColor:COLOR078187];
        [self.button4 setBackgroundColor:[UIColor clearColor]];
    }else if(sender.tag==4){
        [self.button1 setBackgroundColor:[UIColor clearColor]];
        [self.button2 setBackgroundColor:[UIColor clearColor]];
        [self.button3 setBackgroundColor:[UIColor clearColor]];
        [self.button4 setBackgroundColor:COLOR078187];
    }
}

@end
