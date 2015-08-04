//
//  TimerViewController.h
//  BBQ
//
//  Created by Start on 15/7/27.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "BaseViewController.h"
#import "ChartItemView.h"
#import "ChartItemLandView.h"

@interface ToolsViewController : BaseViewController<UIScrollViewDelegate>

@property (strong,nonatomic)UIScrollView *scrollFrameView;
@property (strong,nonatomic)ChartItemView *mChartItemView1;
@property (strong,nonatomic)ChartItemView *mChartItemView2;
@property (strong,nonatomic)ChartItemView *mChartItemView3;
@property (strong,nonatomic)ChartItemView *mChartItemView4;

@property (strong,nonatomic)ChartItemLandView *mChartItemLandView;

- (void)ConnectedState:(BOOL)state;
- (void)loadData:(NSArray*)array;
- (void)refreshView;

- (void)closeAll;

@end
