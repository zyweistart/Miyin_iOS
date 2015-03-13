//
//  NewsDetailViewController.m
//  DLS
//  新闻详情
//  Created by Start on 3/9/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "NewsDetailViewController.h"

@interface NewsDetailViewController ()

@end

@implementation NewsDetailViewController

- (id)initWithDictionary:(NSDictionary*)data{
    self=[super init];
    if(self){
        self.data=data;
        [self setTitle:@"新闻详情"];
        //右切换按钮
        UIButton *btnCollection = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnCollection setBackgroundImage:[UIImage imageNamed:@"collection"]forState:UIControlStateNormal];
//        [btnCollection addTarget:self action:@selector(goMapOrList:) forControlEvents:UIControlEventTouchUpInside];
        btnCollection.frame = CGRectMake(0, 0, 24, 20);
        UIBarButtonItem *negativeSpacerRight = [[UIBarButtonItem alloc]
                                                initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                target:nil action:nil];
        negativeSpacerRight.width = -5;
        self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacerRight, [[UIBarButtonItem alloc] initWithCustomView:btnCollection], nil];
    }
    return self;
}

@end
