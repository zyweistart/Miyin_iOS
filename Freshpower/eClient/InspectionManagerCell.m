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

@implementation InspectionManagerCell{
    NSDictionary *currentData;
    UIView *bottomFrame;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        bottomFrame=[[UIView alloc]initWithFrame:CGRectZero];
        [self addSubview:bottomFrame];
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake1(10, 0, 300, 1)];
        [line setBackgroundColor:LINECOLOR];
        [bottomFrame addSubview:line];
        
        self.lblName=[[UILabel alloc]initWithFrame:CGRectMake1(10, 7, 200, 25)];
        [self.lblName setTextColor:TITLECOLOR2NORMALCOLOR];
        [self.lblName setFont:[UIFont systemFontOfSize:14]];
        [self.lblName setTextAlignment:NSTextAlignmentLeft];
        [bottomFrame addSubview:self.lblName];
        
        self.pSend=[[SVButton alloc]initWithFrame:CGRectMake1(200, 7, 50, 25) Title:@"下发" Type:3];
        [self.pSend.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [self.pSend addTarget:self action:@selector(downSend:) forControlEvents:UIControlEventTouchUpInside];
        [bottomFrame addSubview:self.pSend];
        self.pSetting=[[SVButton alloc]initWithFrame:CGRectMake1(255, 7, 50, 25) Title:@"设置" Type:3];
        [self.pSetting.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [self.pSetting addTarget:self action:@selector(setting:) forControlEvents:UIControlEventTouchUpInside];
        [bottomFrame addSubview:self.pSetting];
        
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
    SVCheckbox *onOff=[[SVCheckbox alloc]initWithFrame:CGRectMake1(280, y, 30, 30)];
    [self addSubview:onOff];
    return onOff;
}

- (void)setData:(NSDictionary*)data
{
    currentData=data;
    [self.lblName setText:[NSString stringWithFormat:@"巡检人:%@",[data objectForKey:@"TASK_USER_NAME"]]];
    NSArray *MODEL_LIST=[data objectForKey:@"MODEL_LIST"];
    int count=MODEL_LIST.count;
    for(int i=0;i<count;i++){
        NSDictionary *d=[MODEL_LIST objectAtIndex:i];
        [self createView:5+i*30+i*5 Title:[d objectForKey:@"MODEL_NAME"]];
    }
    CGFloat height=5+(count-1)*30+(count-1)*5+35;
    [bottomFrame setFrame:CGRectMake1(0, height, 320, 39)];
}

- (void)downSend:(id)sender
{
    NSLog(@"下发");
    [self.pSend setEnabled:NO];
}

- (void)setting:(id)sender
{
    InspectionSettingViewController *inspectionSettingViewController=[[InspectionSettingViewController alloc]initWithData:currentData];
    [[self.controller navigationController]pushViewController:inspectionSettingViewController animated:YES];
}

@end