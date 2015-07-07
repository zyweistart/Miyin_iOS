//
//  MyHelpCenterViewController.m
//  DLS
//  帮助中心
//  Created by Start on 3/5/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "MyHelpCenterViewController.h"

@interface MyHelpCenterViewController ()

@end

@implementation MyHelpCenterViewController

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"帮助中心"];
        //返回
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]
                                               initWithTitle:@"返回"
                                               style:UIBarButtonItemStyleBordered
                                               target:self
                                               action:@selector(goBack:)];
        self.webView1 = [[UIWebView alloc] initWithFrame:self.view.bounds];
        [self.webView1 setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.webView1 setUserInteractionEnabled:YES];
        [self.webView1 setScalesPageToFit:YES];
        [self.webView1 setBackgroundColor:[UIColor clearColor]];
        [self.webView1 setOpaque:NO];//使网页透明
        [self.webView1 setDelegate:self];
        [self.view addSubview:self.webView1];
        
        [self.webView1 loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: @"http://www.delishou.com/98/m_ThelpC.html"]]];
    }
    return self;
}


@end
