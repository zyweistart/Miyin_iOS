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
        [self.lblTitle setFont:[UIFont systemFontOfSize:20]];
        [self.lblTitle setHidden:YES];
        [self.lineChartView setFrame:CGRectMake(0, CGWidth(20),self.frame.size.height, CGWidth(290))];
        [self.lineChartView setInitValue];
    }
    return self;
}

@end