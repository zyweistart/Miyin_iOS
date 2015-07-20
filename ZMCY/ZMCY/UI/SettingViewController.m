//
//  SettingViewController.m
//  ZMCY
//
//  Created by Start on 15/7/20.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (id)init
{
    self=[super init];
    if(self){
        [self cTitle:@"设置"];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
@end
