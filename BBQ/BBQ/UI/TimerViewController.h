//
//  TimerViewController.h
//  BBQ
//
//  Created by Start on 15/7/27.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "BaseViewController.h"
#import "ChartItemView.h"

@interface TimerViewController : BaseViewController

@property (strong,nonatomic)UIScrollView *scrollFrameView;
@property (strong,nonatomic)ChartItemView *mChartItemView1;
@property (strong,nonatomic)ChartItemView *mChartItemView2;
@property (strong,nonatomic)ChartItemView *mChartItemView3;
@property (strong,nonatomic)ChartItemView *mChartItemView4;

@property (strong,nonatomic)NSMutableArray *dataItemArray;

- (void)loadData:(NSArray*)array;

@end
