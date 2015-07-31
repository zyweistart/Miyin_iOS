//
//  ChartItemView.h
//  BBQ
//
//  Created by Start on 15/7/30.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNLineChartView.h"
#import "PNPlot.h"

@interface ChartItemView : UIView

@property (strong,nonatomic)NSDictionary *currentData;
@property (strong,nonatomic)UIView *frameView;
@property (strong,nonatomic)UILabel *lblTitle;
@property (strong,nonatomic)UILabel *lblCurrentTemp;
@property (strong,nonatomic)UILabel *lblSetTemp;
@property (strong,nonatomic)NSTimer *mTimer;
@property (strong,nonatomic)NSString *currentKey;
@property (strong,nonatomic)PNLineChartView *lineChartView;

- (void)loadData:(NSDictionary*)data;

- (void)loadChartData;
- (void)refreshView;

@end
