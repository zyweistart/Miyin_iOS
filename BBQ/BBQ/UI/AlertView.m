//
//  WarningView.m
//  BBQ
//
//  Created by Start on 15/7/29.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "AlertView.h"

@implementation AlertView

- (id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self){
        [self setBackgroundColor:[UIColor whiteColor]];
        self.lblTitle=[[UILabel alloc]initWithFrame:CGRectMake1(0, 0, 300,40)];
        [self.lblTitle setFont:[UIFont systemFontOfSize:18]];
        [self.lblTitle setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.lblTitle];
        self.lblMessage=[[UILabel alloc]initWithFrame:CGRectMake1(0, 40, 300,100)];
        [self.lblMessage setFont:[UIFont systemFontOfSize:18]];
        [self.lblMessage setTextColor:[UIColor blackColor]];
        [self.lblMessage setTextAlignment:NSTextAlignmentCenter];
        [self.lblMessage setBackgroundColor:DEFAULTITLECOLOR(203)];
        [self.lblMessage setNumberOfLines:0];
        [self addSubview:self.lblMessage];
        self.button=[[UIButton alloc]initWithFrame:CGRectMake1(0, 140, 300, 40)];
        [self.button.titleLabel setFont:[UIFont systemFontOfSize:20]];
        [self addSubview:self.button];
        [self setType:1];
        [self setLanguage];
    }
    return self;
}

- (void)setLanguage
{
    [self.button setTitle:LOCALIZATION(@"OK") forState:UIControlStateNormal];
}

- (void)setType:(int)type
{
    if(type==1){
        [self.lblTitle setTextColor:[UIColor whiteColor]];
        [self.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.lblTitle setBackgroundColor:DEFAULTITLECOLOR(131)];
        [self.button setBackgroundColor:DEFAULTITLECOLORRGB(255, 121, 74)];
    }else{
        [self.lblTitle setTextColor:[UIColor whiteColor]];
        [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.lblTitle setBackgroundColor:DEFAULTITLECOLORRGB(255, 50, 3)];
        [self.button setBackgroundColor:DEFAULTITLECOLORRGB(255, 50, 3)];
    }
}

@end
