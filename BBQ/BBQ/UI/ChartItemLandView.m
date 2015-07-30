//
//  ChartItemLandView.m
//  BBQ
//
//  Created by Start on 15/7/30.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "ChartItemLandView.h"

@implementation ChartItemLandView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self.frameView setFrame:CGRectMake(0, CGWidth(5), frame.size.width, frame.size.height-CGWidth(10))];
        [self.lblTitle setFrame:CGRectMake(0,0,CGHeight(80),CGWidth(310))];
        [self createChartView];
    }
    return self;
}

- (void)createChartView
{
    if (self.chartView) {
        [self.chartView removeFromSuperview];
        self.chartView = nil;
    }
    self.chartView = [[UUChart alloc]initwithUUChartDataFrame:CGRectMake(CGHeight(80), 0,self.frame.size.height-CGHeight(80), CGWidth(310)) withSource:self withStyle:UUChartLineStyle];
    [self.chartView showInView:self.frameView];
}

@end
