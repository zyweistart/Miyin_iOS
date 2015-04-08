//
//  STElectricityView.m
//  ElectricianClient
//
//  Created by Start on 3/27/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STElectricityView.h"

@implementation STElectricityView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.rv1=[[STRows4View alloc]initWithFrame:CGRectMake(0, 5, frame.size.width,20)];
        [self addSubview: self.rv1];
        [[self.rv1 lbl1] setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
        [[self.rv1 lbl2]setText:@"电量"];
        [[self.rv1 lbl2] setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
        [[self.rv1 lbl3]setText:@"电费"];
        [[self.rv1 lbl3] setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
        [self.rv1 setBackgroundColor:[UIColor colorWithRed:(170/255.0) green:(170/255.0) blue:(170/255.0) alpha:1]];
        self.rv2=[[STRows4View alloc]initWithFrame:CGRectMake(0, 25, frame.size.width,20)];
        [self addSubview: self.rv2];
        [[self.rv2 lbl1]setText:@"累计"];
        self.rv3=[[STRows4View alloc]initWithFrame:CGRectMake(0, 45, frame.size.width,20)];
        [self addSubview: self.rv3];
        [[self.rv3 lbl1]setText:@"尖峰"];
        [self.rv3 setBackgroundColor:[UIColor colorWithRed:(170/255.0) green:(170/255.0) blue:(170/255.0) alpha:1]];
        self.rv4=[[STRows4View alloc]initWithFrame:CGRectMake(0, 65, frame.size.width,20)];
        [self addSubview: self.rv4];
        [[self.rv4 lbl1]setText:@"高峰"];
        self.rv5=[[STRows4View alloc]initWithFrame:CGRectMake(0, 85, frame.size.width,20)];
        [self addSubview: self.rv5];
        [[self.rv5 lbl1]setText:@"低谷"];
        [self.rv5 setBackgroundColor:[UIColor colorWithRed:(170/255.0) green:(170/255.0) blue:(170/255.0) alpha:1]];
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 105, 120, 20)];
        [lbl setFont:[UIFont systemFontOfSize:12]];
        [lbl setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [lbl setText:@"平均电价"];
        [self addSubview:lbl];
        self.lblAvgPrice=[[UILabel alloc]initWithFrame:CGRectMake(100, 105, 180, 20)];
        [self.lblAvgPrice setFont:[UIFont systemFontOfSize:12]];
        [self.lblAvgPrice setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [self.lblAvgPrice setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.lblAvgPrice];
    }
    return self;
}

@end
