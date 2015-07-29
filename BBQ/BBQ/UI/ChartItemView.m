//
//  ChartItemView.m
//  BBQ
//
//  Created by Start on 15/7/30.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "ChartItemView.h"

@implementation ChartItemView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:DEFAULTITLECOLORRGB(65, 51, 42)];
        UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(0, 5, 315, 180)];
        frame.layer.masksToBounds=YES;
        frame.layer.cornerRadius=CGWidth(5);
        frame.layer.borderWidth=1;
        frame.layer.borderColor=DEFAULTITLECOLOR(200).CGColor;
        [frame setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:frame];
        
        self.lblTitle=[[UILabel alloc]initWithFrame:CGRectMake1(0, 0, 40, 180)];
        [self.lblTitle setTextColor:[UIColor whiteColor]];
        [self.lblTitle setFont:[UIFont systemFontOfSize:18]];
        [self.lblTitle setBackgroundColor:DEFAULTITLECOLORRGB(242, 125, 0)];
        [self.lblTitle setTextAlignment:NSTextAlignmentCenter];
        [frame addSubview:self.lblTitle];
        
        UIView *chartView=[[UIView alloc]initWithFrame:CGRectMake1(40,0, 275, 180)];
        [chartView setBackgroundColor:[UIColor greenColor]];
        [frame addSubview:chartView];
        
    }
    return self;
}

- (void)loadData:(NSDictionary*)data
{
    [self setCurrentData:data];
}

@end
