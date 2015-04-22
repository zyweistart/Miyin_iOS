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
    NSMutableDictionary *currentData;
    UIView *bottomFrame;
    UIButton *svch1,*svch2,*svch3,*svch4,*svch5;
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
        
        int count=5;
        for(int i=0;i<count;i++){
            if(i==0){
                svch1=[self createView:5+i*30+i*5 Title:@"变电站运行记录表" Tag:i];
            }else if(i==1){
                svch2=[self createView:5+i*30+i*5 Title:@"变电站电气设备日常巡检" Tag:i];
            }else if(i==2){
                svch3=[self createView:5+i*30+i*5 Title:@"高温季节巡视记录表" Tag:i];
            }else if(i==3){
                svch4=[self createView:5+i*30+i*5 Title:@"梅雨季节巡视记录表" Tag:i];
            }else if(i==4){
                svch5=[self createView:5+i*30+i*5 Title:@"特殊巡视记录表" Tag:i];
            }
        }
        CGFloat height=5+(count-1)*30+(count-1)*5+35;
        [bottomFrame setFrame:CGRectMake1(0, height, 320, 39)];
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (UIButton*)createView:(CGFloat)y Title:(NSString*)title Tag:(NSInteger)tag
{
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, y, 200, 30)];
    [lbl setText:title];
    [lbl setTextColor:TITLECOLOR1NORMALCOLOR];
    [lbl setFont:[UIFont systemFontOfSize:14]];
    [lbl setTextAlignment:NSTextAlignmentLeft];
    [self addSubview:lbl];
    UIButton *onOff=[[UIButton alloc]initWithFrame:CGRectMake1(280, y, 30, 30)];
    [onOff setImage:[UIImage imageNamed:@"未勾"] forState:UIControlStateNormal];
    [onOff setImage:[UIImage imageNamed:@"勾"] forState:UIControlStateSelected];
    [onOff setTag:tag];
    [onOff addTarget:self action:@selector(checkboxClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:onOff];
    return onOff;
}

- (void)setData:(NSMutableDictionary*)data
{
    currentData=data;
    NSString *SET_TYPE=[currentData objectForKey:@"SET_TYPE"];
    if([@"1" isEqualToString:SET_TYPE]){
        [self.pSend setEnabled:NO];
    }else{
        [self.pSend setEnabled:YES];
    }
    [self.lblName setText:[NSString stringWithFormat:@"巡检人:%@",[data objectForKey:@"TASK_USER_NAME"]]];
    NSArray *MODEL_LIST=[data objectForKey:@"MODEL_LIST"];
    NSUInteger count=MODEL_LIST.count;
    for(int i=0;i<count;i++){
        NSDictionary *d=[MODEL_LIST objectAtIndex:i];
        if(i==0){
//            svch1=[self createView:5+i*30+i*5 Title:[d objectForKey:@"MODEL_NAME"] Tag:i];
            [svch1 setSelected:![@"0" isEqualToString:[d objectForKey:@"MODEL_SET_ID"]]];
        }else if(i==1){
//            svch2=[self createView:5+i*30+i*5 Title:[d objectForKey:@"MODEL_NAME"] Tag:i];
            [svch2 setSelected:![@"0" isEqualToString:[d objectForKey:@"MODEL_SET_ID"]]];
        }else if(i==2){
//            svch3=[self createView:5+i*30+i*5 Title:[d objectForKey:@"MODEL_NAME"] Tag:i];
            [svch3 setSelected:![@"0" isEqualToString:[d objectForKey:@"MODEL_SET_ID"]]];
        }else if(i==3){
//            svch4=[self createView:5+i*30+i*5 Title:[d objectForKey:@"MODEL_NAME"] Tag:i];
            [svch4 setSelected:![@"0" isEqualToString:[d objectForKey:@"MODEL_SET_ID"]]];
        }else if(i==4){
//            svch5=[self createView:5+i*30+i*5 Title:[d objectForKey:@"MODEL_NAME"] Tag:i];
            [svch5 setSelected:![@"0" isEqualToString:[d objectForKey:@"MODEL_SET_ID"]]];
        }
    }
//    CGFloat height=5+(count-1)*30+(count-1)*5+35;
//    [bottomFrame setFrame:CGRectMake1(0, height, 320, 39)];
}

-(void)checkboxClick:(UIButton *)sender
{
    NSInteger tag=[sender tag];
    NSMutableArray *MODEL_LIST=[currentData objectForKey:@"MODEL_LIST"];
    NSMutableDictionary *d=[MODEL_LIST objectAtIndex:tag];
    if(sender.selected){
        [d setObject:@"0" forKey:@"MODEL_SET_ID"];
    }else{
        [d setObject:@"1" forKey:@"MODEL_SET_ID"];
    }
    sender.selected = !sender.selected;
}

- (void)downSend:(id)sender
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[[User Instance]getUserName] forKey:@"imei"];
    [params setObject:[[User Instance]getPassword] forKey:@"authentication"];
    [params setObject:@"TS007" forKey:@"GNID"];
    [params setObject:[currentData objectForKey:@"CP_ID"] forKey:@"QTCP"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self.controller];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest handle:URL_appTaskingFps requestParams:params];
}
    
- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if([response successFlag]){
        [self.pSend setEnabled:NO];
    }
}

- (void)setting:(id)sender
{
    InspectionSettingViewController *inspectionSettingViewController=[[InspectionSettingViewController alloc]initWithData:currentData];
    [inspectionSettingViewController setDelegate:self];
    [[self.controller navigationController]pushViewController:inspectionSettingViewController animated:YES];
}

- (void)onControllerResult:(NSInteger)resultCode data:(NSMutableDictionary*)result
{
//    NSString *dSET_TYPE=[result objectForKey:@"dSET_TYPE"];
//    [currentData setObject:dSET_TYPE forKey:@"IS_CREATE"];
//    if([@"1" isEqualToString:dSET_TYPE]){
//        [self.pSend setEnabled:NO];
//    }else{
//        [self.pSend setEnabled:YES];
//    }
}

@end