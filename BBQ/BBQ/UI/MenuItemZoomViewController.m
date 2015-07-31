//
//  MenuItemZoomViewController.m
//  BBQ
//
//  Created by Start on 15/8/1.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "MenuItemZoomViewController.h"

@interface MenuItemZoomViewController ()

@end

@implementation MenuItemZoomViewController

- (id)init
{
    self =[super init];
    if(self){
        UILabel *LBL=[[UILabel alloc]initWithFrame:CGRectMake1(20, 50, 100, 40)];
        [LBL setText:@"这是手机 "];
        [self.view addSubview:LBL];
    }
    return self;
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationPortrait;
}

@end
