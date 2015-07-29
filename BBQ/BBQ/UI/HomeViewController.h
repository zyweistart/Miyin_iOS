//
//  HomeViewController.h
//  BBQ
//
//  Created by Start on 15/7/27.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "BaseTableViewController.h"
#import "SetTempView.h"

@interface HomeViewController : BaseTableViewController

- (void)loadData:(NSArray*)array;

@property (strong,nonatomic)UIView *bgFrame;
@property (strong,nonatomic)SetTempView *mSetTempView;

@end
