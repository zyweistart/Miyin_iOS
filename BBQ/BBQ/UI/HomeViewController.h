//
//  HomeViewController.h
//  BBQ
//
//  Created by Start on 15/7/27.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "BaseViewController.h"
#import "MenuItemView.h"
#import "SetTempView.h"
#import "DatePickerView.h"

@interface HomeViewController : BaseViewController<PickerViewDelegate>

@property (strong,nonatomic)UIView *bgFrame;
@property (strong,nonatomic)DatePickerView *pv1;
@property (strong,nonatomic)SetTempView *mSetTempView;

@property (strong,nonatomic)UIScrollView *scrollFrameView;
@property (strong,nonatomic)MenuItemView *mMenuItemView1;
@property (strong,nonatomic)MenuItemView *mMenuItemView2;
@property (strong,nonatomic)MenuItemView *mMenuItemView3;
@property (strong,nonatomic)MenuItemView *mMenuItemView4;

@property (strong,nonatomic)NSMutableArray *dataItemArray;

- (void)loadData:(NSArray*)array;
- (void)refreshDataView;

@end
