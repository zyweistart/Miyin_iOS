//
//  SetTempView.m
//  BBQ
//
//  Created by Start on 15/7/29.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "SetTempView.h"

@implementation SetTempView

- (id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self){
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setUserInteractionEnabled:YES];
        self.lblTitle=[[UILabel alloc]initWithFrame:CGRectMake1(0, 0, 300,40)];
        [self.lblTitle setFont:[UIFont systemFontOfSize:18]];
        [self.lblTitle setTextColor:[UIColor whiteColor]];
        [self.lblTitle setTextAlignment:NSTextAlignmentCenter];
        [self.lblTitle setBackgroundColor:DEFAULTITLECOLOR(131)];
        [self addSubview:self.lblTitle];
        self.lblValue=[[UILabel alloc]initWithFrame:CGRectMake1(0, 40, 300,50)];
        [self.lblValue setFont:[UIFont systemFontOfSize:35]];
        [self.lblValue setTextColor:DEFAULTITLECOLORRGB(242, 125, 0)];
        [self.lblValue setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.lblValue];
        self.mSlider = [[UISlider alloc] initWithFrame:CGRectMake1(50,120,200,20)];
        [self.mSlider setMinimumValue:0];
        [self.mSlider setMaximumValue:200];
        [self.mSlider addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:self.mSlider];
        self.cancelButton=[[UIButton alloc]initWithFrame:CGRectMake1(0, 160, 150, 40)];
        [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        [self.cancelButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
        [self.cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.cancelButton setBackgroundColor:DEFAULTITLECOLOR(74)];
        [self addSubview:self.cancelButton];
        
        self.okButton=[[UIButton alloc]initWithFrame:CGRectMake1(151, 160, 149, 40)];
        [self.okButton setTitle:@"OK" forState:UIControlStateNormal];
        [self.okButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
        [self.okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.okButton setBackgroundColor:DEFAULTITLECOLORRGB(255, 121, 74)];
        [self addSubview:self.okButton];
        
        [self.lblValue setText:[Data getTemperatureValue:self.mSlider.value]];
    }
    return self;
}

- (void)setValue:(int)value
{
    [self.mSlider setValue:value];
    [self.lblValue setText:[Data getTemperatureValue:self.mSlider.value]];
}

- (void)changeValue:(id)sender
{
    [self.lblValue setText:[Data getTemperatureValue:self.mSlider.value]];
}

@end