//
//  PeripheralCell.m
//  BBQ
//
//  Created by Start on 15/7/30.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "PeripheralCell.h"

@implementation PeripheralCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBackgroundColor:DEFAULTITLECOLORA(150, 0.3)];
        self.lblTitle=[[UILabel alloc]initWithFrame:CGRectMake1(0, 0, 320, 40)];
        [self.lblTitle setTextColor:[UIColor whiteColor]];
        [self.lblTitle setFont:[UIFont systemFontOfSize:35]];
        [self.lblTitle setTextColor:[UIColor whiteColor]];
        [self.lblTitle setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.lblTitle];
        self.lblAddress=[[UILabel alloc]initWithFrame:CGRectMake1(10, 40, 300, 20)];
        [self.lblAddress setTextColor:DEFAULTITLECOLOR(187)];
        [self.lblAddress setFont:[UIFont systemFontOfSize:14]];
        [self.lblAddress setTextColor:[UIColor whiteColor]];
        [self.lblAddress setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.lblAddress];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

@end
