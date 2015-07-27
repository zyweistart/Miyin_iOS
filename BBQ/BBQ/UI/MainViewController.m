//
//  MainViewController.m
//  BBQ
//
//  Created by Start on 15/7/27.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)init{
    self=[super init];
    if(self){
        CGFloat topHeight=400;
        CButton *bDemo=[[CButton alloc]initWithFrame:CGRectMake1(20, topHeight, 120, 40) Name:@"Demo" Type:2];
        [bDemo addTarget:self action:@selector(goDemo:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:bDemo];
        CButton *bScan=[[CButton alloc]initWithFrame:CGRectMake1(180, topHeight, 120, 40) Name:@"Scan" Type:2];
        [bScan addTarget:self action:@selector(goScan:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:bScan];
    }
    return self;
}

- (void)goDemo:(id)sender
{
    NSLog(@"DEMO");
}

- (void)goScan:(id)sender
{
    NSLog(@"SCAN");
}

@end