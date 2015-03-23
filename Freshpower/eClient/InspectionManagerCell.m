//
//  InspectionManagerCell.m
//  eClient
//  巡检任务管理
//  Created by weizhenyao on 15/3/23.
//  Copyright (c) 2015年 freshpower. All rights reserved.
//

#import "InspectionManagerCell.h"
#import "SVButton.h"

#define LINECOLOR [UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1]
#define TITLECOLOR1NORMALCOLOR [UIColor colorWithRed:(170/255.0) green:(170/255.0) blue:(170/255.0) alpha:1]
#define TITLECOLOR2NORMALCOLOR [UIColor colorWithRed:(254/255.0) green:(148/255.0) blue:(0/255.0) alpha:1]

@implementation InspectionManagerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView:5 Title:@"变电站运行记录表"];
        [self createView:40 Title:@"变电站电气设备日常巡检"];
        [self createView:75 Title:@"高温季节配电房测温表"];
        [self createView:110 Title:@"梅雨季节巡视记录表"];
        [self createView:145 Title:@"特殊巡视记录表"];
        
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake1(10, 180, 300, 1)];
        [line setBackgroundColor:LINECOLOR];
        [self addSubview:line];
        
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 187, 200, 25)];
        [lbl setText:@"巡检人："];
        [lbl setTextColor:TITLECOLOR2NORMALCOLOR];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:lbl];
        
        SVButton *pSend=[[SVButton alloc]initWithFrame:CGRectMake1(200, 187, 50, 25) Title:@"下发" Type:2];
        [self addSubview:pSend];
        SVButton *pSetting=[[SVButton alloc]initWithFrame:CGRectMake1(255, 187, 50, 25) Title:@"设置" Type:2];
        [self addSubview:pSetting];
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (UISwitch*)createView:(CGFloat)y Title:(NSString*)title
{
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, y, 200, 30)];
    [lbl setText:title];
    [lbl setTextColor:TITLECOLOR1NORMALCOLOR];
    [lbl setFont:[UIFont systemFontOfSize:14]];
    [lbl setTextAlignment:NSTextAlignmentLeft];
    [self addSubview:lbl];
    UISwitch *switch1=[[UISwitch alloc]initWithFrame:CGRectMake1(260, y, 40, 20)];
    [self addSubview:switch1];
    return switch1;
}

@end
