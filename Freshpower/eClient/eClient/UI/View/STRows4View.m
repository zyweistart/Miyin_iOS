//
//  STRows4View.m
//  ElectricianClient
//
//  Created by Start on 3/27/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STRows4View.h"

@implementation STRows4View

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.lbl1=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
        [self.lbl1 setFont:[UIFont systemFontOfSize:12]];
        [self.lbl1 setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [self.lbl1 setTextAlignment:NSTextAlignmentCenter];
        [self.lbl1 setText:@""];
        [self addSubview:self.lbl1];
        
        self.lbl2=[[UILabel alloc]initWithFrame:CGRectMake(60, 0, 100, 20)];
        [self.lbl2 setFont:[UIFont systemFontOfSize:12]];
        [self.lbl2 setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [self.lbl2 setTextAlignment:NSTextAlignmentCenter];
        [self.lbl2 setText:@""];
        [self addSubview:self.lbl2];
        
        self.lbl3=[[UILabel alloc]initWithFrame:CGRectMake(160, 0, 100, 20)];
        [self.lbl3 setFont:[UIFont systemFontOfSize:12]];
        [self.lbl3 setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [self.lbl3 setTextAlignment:NSTextAlignmentCenter];
        [self.lbl3 setText:@""];
        [self addSubview:self.lbl3];
        
        self.lbl4=[[UILabel alloc]initWithFrame:CGRectMake(260, 0, 60, 20)];
        [self.lbl4 setFont:[UIFont systemFontOfSize:12]];
        [self.lbl4 setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [self.lbl4 setTextAlignment:NSTextAlignmentCenter];
        [self.lbl4 setText:@""];
        [self addSubview:self.lbl4];
    }
    return self;
}

@end
