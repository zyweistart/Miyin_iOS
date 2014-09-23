//
//  STPurchaseShowViewController.m
//  ElectricianRun
//
//  Created by Start on 3/4/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STPurchaseShowViewController.h"

@interface STPurchaseShowViewController ()

@end

@implementation STPurchaseShowViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.title=@"价格展示";
        
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]
                                               initWithTitle:@"返回"
                                               style:UIBarButtonItemStyleBordered
                                               target:self
                                               action:@selector(back:)];
        
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]
                                                initWithTitle:@"购买"
                                                style:UIBarButtonItemStyleBordered
                                                target:self
                                                action:@selector(buy:)];
        
        UIWebView *webView=[[UIWebView alloc]initWithFrame:
                            CGRectMake(0, 0,
                                       self.view.frame.size.width,
                                       self.view.frame.size.height)];
        [webView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.view addSubview:webView];
        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"page.bundle/价格介绍.html"];
        NSURL* url = [NSURL fileURLWithPath:path];
        NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
        [webView loadRequest:request];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)back:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)buy:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:PAYURL]];
}
@end
