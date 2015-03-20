//
//  MyViewController.m
//  eClient
//  我的
//  Created by Start on 3/20/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "MyViewController.h"
#import "SVButton.h"

@interface MyViewController ()

@end

@implementation MyViewController

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"我的"];
        SVButton *logou=[[SVButton alloc]initWithFrame:CGRectMake1(10, 20, 300, 40) Title:@"注册" Type:2];
        [self.view addSubview:logou];logou=[[SVButton alloc]initWithFrame:CGRectMake1(10, 90, 150, 30) Title:@"获取校验码" Type:2];
        [self.view addSubview:logou];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
