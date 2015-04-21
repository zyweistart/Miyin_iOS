//
//  DetailIntroductionViewController.m
//  eClient
//
//  Created by Start on 4/14/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "DetailIntroductionViewController.h"
#import "FeedbackViewController.h"
#import "UIButton+TitleImage.h"
#define TOPBGCOLOR [UIColor colorWithRed:(49/255.0) green:(154/255.0) blue:(16/255.0) alpha:1]
#define MIDDLEBGCOLOR [UIColor colorWithRed:(20/255.0) green:(25/255.0) blue:(95/255.0) alpha:1]

@interface DetailIntroductionViewController ()

@end

@implementation DetailIntroductionViewController{
    int currentType;
}

- (id)initWithTitle:(NSString*)title WithImage:(NSString*)image WithType:(int)type{
    self=[super init];
    if(self){
        currentType=type;
        [self setTitle:@"产品详情介绍"];
        
        UIScrollView *scrollFrame=[[UIScrollView alloc]initWithFrame:self.view.bounds];
        [scrollFrame setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [scrollFrame setContentSize:CGSizeMake1(320, 650)];
        [self.view addSubview:scrollFrame];
        UIView *topView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 100)];
        [topView setBackgroundColor:TOPBGCOLOR];
        [scrollFrame addSubview:topView];
        UIImageView *head=[[UIImageView alloc]initWithFrame:CGRectMake1(130, 10, 60, 60)];
        [head setImage:[UIImage imageNamed:image]];
        [topView addSubview:head];
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(60, 70, 200, 30)];
        [lbl setText:title];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [lbl setFont:[UIFont systemFontOfSize:17]];
        [lbl setTextColor:[UIColor whiteColor]];
        [topView addSubview:lbl];
        UIView *middleView=[[UIView alloc]initWithFrame:CGRectMake1(0, 100, 320, 550)];
        [scrollFrame addSubview:middleView];
        topView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 40)];
        [topView setBackgroundColor:MIDDLEBGCOLOR];
        [middleView addSubview:topView];
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake1(110, 10, 100, 100)];
        [button addTarget:self action:@selector(feedBack:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:@"h"] forState:UIControlStateNormal];
        [middleView addSubview:button];
        
        UIWebView *webView=[[UIWebView alloc]initWithFrame:CGRectMake1(0, 110, 320, 440)];
        [middleView addSubview:webView];
        
        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"product.bundle/%@.html",title]];
        
        NSURL* url = [NSURL fileURLWithPath:path];
        NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
        [webView loadRequest:request];
    }
    return self;
}

- (void)feedBack:(id)sender
{
    [self.navigationController pushViewController:[[FeedbackViewController alloc]init] animated:YES];
}

@end
