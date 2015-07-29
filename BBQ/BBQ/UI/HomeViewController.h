//
//  HomeViewController.h
//  BBQ
//
//  Created by Start on 15/7/27.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "BaseTableViewController.h"
#import "SetTempView.h"
#import "DatePickerView.h"

@interface HomeViewController : BaseTableViewController<PickerViewDelegate>

@property (strong,nonatomic)DatePickerView *pv1;

- (void)loadData:(NSArray*)array;

@property (strong,nonatomic)UIView *bgFrame;
@property (strong,nonatomic)SetTempView *mSetTempView;

@end
