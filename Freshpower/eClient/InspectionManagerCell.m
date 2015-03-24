//
//  InspectionManagerCell.m
//  eClient
//  巡检任务管理
//  Created by weizhenyao on 15/3/23.
//  Copyright (c) 2015年 freshpower. All rights reserved.
//

#import "InspectionManagerCell.h"
#import "InspectionSettingViewController.h"

#define LINECOLOR [UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1]
#define TITLECOLOR1NORMALCOLOR [UIColor colorWithRed:(170/255.0) green:(170/255.0) blue:(170/255.0) alpha:1]
#define TITLECOLOR2NORMALCOLOR [UIColor colorWithRed:(254/255.0) green:(148/255.0) blue:(0/255.0) alpha:1]

@implementation InspectionManagerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.checkbox1=[self createView:5 Title:@"变电站运行记录表"];
        self.checkbox2=[self createView:40 Title:@"变电站电气设备日常巡检"];
        self.checkbox3=[self createView:75 Title:@"高温季节配电房测温表"];
        self.checkbox4=[self createView:110 Title:@"梅雨季节巡视记录表"];
        self.checkbox5=[self createView:145 Title:@"特殊巡视记录表"];
        
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake1(10, 180, 300, 1)];
        [line setBackgroundColor:LINECOLOR];
        [self addSubview:line];
        
        self.lblName=[[UILabel alloc]initWithFrame:CGRectMake1(10, 187, 200, 25)];
        [self.lblName setText:@"巡检人："];
        [self.lblName setTextColor:TITLECOLOR2NORMALCOLOR];
        [self.lblName setFont:[UIFont systemFontOfSize:14]];
        [self.lblName setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:self.lblName];
        
        self.pSend=[[SVButton alloc]initWithFrame:CGRectMake1(200, 187, 50, 25) Title:@"下发" Type:3];
        [self.pSend addTarget:self action:@selector(downSend:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.pSend];
        self.pSetting=[[SVButton alloc]initWithFrame:CGRectMake1(255, 187, 50, 25) Title:@"设置" Type:3];
        [self.pSetting addTarget:self action:@selector(setting:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.pSetting];
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (SVCheckbox*)createView:(CGFloat)y Title:(NSString*)title
{
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, y, 200, 30)];
    [lbl setText:title];
    [lbl setTextColor:TITLECOLOR1NORMALCOLOR];
    [lbl setFont:[UIFont systemFontOfSize:14]];
    [lbl setTextAlignment:NSTextAlignmentLeft];
    [self addSubview:lbl];
    SVCheckbox *onOff=[[SVCheckbox alloc]initWithFrame:CGRectMake1(280, y, 20, 15)];
    [self addSubview:onOff];
    return onOff;
}

- (void)downSend:(id)sender
{
    NSLog(@"下发");
}

- (void)setting:(id)sender
{
    [[self.controller navigationController]pushViewController:[[InspectionSettingViewController alloc]init] animated:YES];
}

@end
