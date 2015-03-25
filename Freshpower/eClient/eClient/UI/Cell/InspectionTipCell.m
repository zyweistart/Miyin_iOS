//
//  InspectionTipCell.m
//  eClient
//  提醒设置
//  Created by Start on 3/25/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "InspectionTipCell.h"
#import "SVCheckbox.h"
#import "SVTextField.h"

#define TITLECOLOR [UIColor colorWithRed:(200/255.0) green:(200/255.0) blue:(200/255.0) alpha:1]

@implementation InspectionTipCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.lblTitle=[[UILabel alloc]initWithFrame:CGRectMake1(10, 5, 300, 20)];
        [self.lblTitle setText:@"变电站电气设备日常巡检"];
        [self.lblTitle setFont:[UIFont systemFontOfSize:14]];
        [self.lblTitle setNumberOfLines:0];
        [self.lblTitle setTextColor:TITLECOLOR];
        [self addSubview:self.lblTitle];
        SVCheckbox *cb1=[[SVCheckbox alloc]initWithFrame:CGRectMake1(10, 30, 100, 30)];
        [cb1 setSelected:YES];
        [[cb1 titleLabel]setFont:[UIFont systemFontOfSize:14]];
        [cb1 setTitle:@"按天提醒" forState:UIControlStateNormal];
        [cb1 setTitleColor:TITLECOLOR forState:UIControlStateNormal];
        [cb1 setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [self addSubview:cb1];
        self.timeDate=[[SVTextField alloc]initWithFrame:CGRectMake1(110, 30, 100, 30) Title:nil];
        [self addSubview:self.timeDate];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}
@end
