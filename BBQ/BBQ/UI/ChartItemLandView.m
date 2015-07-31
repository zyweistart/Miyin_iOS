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
        [self.lblSetTemp setHidden:YES];
        [self.lblCurrentTemp setHidden:YES];
        [self.lblTitle setFrame:CGRectMake(0,0,CGHeight(80),CGWidth(310))];
        [self.lblTitle setFont:[UIFont systemFontOfSize:20]];
        [self.lineChartView setFrame:CGRectMake(CGHeight(80), 0,self.frame.size.width-CGHeight(80), CGWidth(310))];
    }
    return self;
}

@end