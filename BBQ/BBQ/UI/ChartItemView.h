//
//  ChartItemView.h
//  BBQ
//
//  Created by Start on 15/7/30.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UUChart.h"

@interface ChartItemView : UIView<UUChartDataSource>

@property (strong,nonatomic)UIView *frameView;
@property (strong,nonatomic)UILabel *lblTitle;
@property (strong,nonatomic)UUChart *chartView;
@property (strong,nonatomic)NSTimer *mTimer;
@property (strong,nonatomic)NSString *currentKey;

@property NSInteger currentArrayIndex;

- (void)loadData:(NSDictionary*)data;


@end
