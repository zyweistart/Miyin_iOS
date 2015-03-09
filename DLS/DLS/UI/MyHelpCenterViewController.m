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
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
}


@end
