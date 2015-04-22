//
//  WebDetailViewController.m
//  eClient
//
//  Created by Start on 4/16/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "WebDetailViewController.h"
#import "FeedbackViewController.h"

@interface WebDetailViewController ()

@end

@implementation WebDetailViewController

- (id)initWithType:(int)type Url:(NSString*)url {
    self = [super init];
    if (self) {
        [self setTitle:@"产品介绍"];
        self.webView1 = [[UIWebView alloc] init];
        [self.webView1 setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.webView1 setUserInteractionEnabled:YES];
        [self.webView1 setScalesPageToFit:YES];
        [self.webView1 setBackgroundColor:[UIColor clearColor]];
        [self.webView1 setOpaque:NO];//使网页透明
        [self.webView1 setDelegate:self];
        [self.view addSubview:self.webView1];
        if(url==nil){
            [self.webView1 setFrame:self.view.bounds];
            NSString *urlName;
            if(type==1){
                urlName=@"www.bundle/process.html";
            }else if(type==2){
                urlName=@"www.bundle/process.html";
            }else if(type==3){
                urlName=@"www.bundle/process.html";
            }else if(type==4){
                urlName=@"www.bundle/process.html";
            }else if(type==5){
                urlName=@"www.bundle/process.html";
            }else if(type==6){
                urlName=@"www.bundle/registerAgreement.html";
            }
            NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:urlName];
            [self.webView1 loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath: path]]];
        }else{
            UIImageView *headView=[[UIImageView alloc]initWithFrame:CGRectMake1(0, 0, 320, 40)];
            [headView setImage:[UIImage imageNamed:@"buy"]];
            [headView setUserInteractionEnabled:YES];
            [headView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goFeedBack:)]];
            [self.view addSubview:headView];
            [self.webView1 setFrame:CGRectMake1(0, 40, 320, self.view.bounds.size.height-40)];
            [self.webView1 loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
        }
    }
    return self;
}

- (void)goFeedBack:(id)sender
{
    [self.navigationController pushViewController:[[FeedbackViewController alloc]init] animated:YES];
}

@end
