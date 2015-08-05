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
    self.scale=frame.size.height/CGHeight(190.0);
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)updateTimer
{
    if(self.currentKey==nil){
        return;
    }
    for(NSDictionary *da in [[Data Instance]currentTValue]){
        NSString *value=[da objectForKey:self.currentKey];
        if(value!=nil){
            [self loadChartData];
            break;
        }
    }
}

@end