//
//  DemoMainViewController.m
//  DemoBouncePagination
//
//  Created by noahlu on 14-9-5.
//  Copyright (c) 2014年 noahlu<codedancerhua@gmail.com>. All rights reserved.
//

#import "DemoMainViewController.h"
#import "HomeBannerView.h"
#import "HomeCategoryView.h"
#import "DemoSubViewController.h"
#import "HomeNewsListViewController.h"

@interface DemoMainViewController ()

@end

@implementation DemoMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scrollView.contentSize = CGSizeMake(320, 524);
    self.subViewController = [[DemoSubViewController alloc] init];
    self.subViewController.mainViewController = self;
    
    HomeBannerView *banner=[[HomeBannerView alloc]initWithFrame:CGRectMake(0, 0, 320, 290)];
    [self.scrollView addSubview:banner];
    HomeCategoryView *category=[[HomeCategoryView alloc]initWithFrame:CGRectMake(0, 290, 320, 234)];
    [self.scrollView addSubview:category];
}

@end
