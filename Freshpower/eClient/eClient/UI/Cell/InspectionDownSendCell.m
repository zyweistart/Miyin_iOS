//
//  InspectionDownSendCell.m
//  eClient
//  下发设置
//  Created by Start on 3/25/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "InspectionDownSendCell.h"
#import "SVCheckbox.h"


#define TITLECOLOR [UIColor colorWithRed:(200/255.0) green:(200/255.0) blue:(200/255.0) alpha:1]

@implementation InspectionDownSendCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        SVCheckbox *cb1=[[SVCheckbox alloc]initWithFrame:CGRectMake1(0, 5, 100, 30)];
        [cb1 setSelected:YES];
        [[cb1 titleLabel]setFont:[UIFont systemFontOfSize:14]];
        [cb1 setTitle:@"自动下发" forState:UIControlStateNormal];
        [cb1 setTitleColor:TITLECOLOR forState:UIControlStateNormal];
        [cb1 setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [self addSubview:cb1];
        SVCheckbox *cb2=[[SVCheckbox alloc]initWithFrame:CGRectMake1(110, 5, 100, 30)];
        [[cb2 titleLabel]setFont:[UIFont systemFontOfSize:14]];
        [cb2 setTitle:@"手动下发" forState:UIControlStateNormal];
        [cb2 setTitleColor:TITLECOLOR forState:UIControlStateNormal];
        [cb2 setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [self addSubview:cb2];
        UILabel *lblDescription=[[UILabel alloc]initWithFrame:CGRectMake1(10, 40, 300, 70)];
        [lblDescription setText:@"您可以选择适合您的下发方式：1、自动下发：巡检比较频繁且有规律时选择。如每天需要下发巡检任务。2、手动下发：巡检不频繁且无规律时选择。如每周巡检一次或每月巡检几次。"];
        [lblDescription setFont:[UIFont systemFontOfSize:13]];
        [lblDescription setNumberOfLines:0];
        [lblDescription setTextColor:TITLECOLOR];
        [self addSubview:lblDescription];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

@end
