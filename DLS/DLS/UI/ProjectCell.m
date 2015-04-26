//
//  ProjectCell.m
//  DLS
//
//  Created by Start on 3/5/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "ProjectCell.h"
#import <QuartzCore/QuartzCore.h>
#define TITLECOLOR [UIColor colorWithRed:(70/255.0) green:(70/255.0) blue:(70/255.0) alpha:1]
#define ADDRESSCOLOR [UIColor colorWithRed:(142/255.0) green:(142/255.0) blue:(142/255.0) alpha:1]
#define MONEYCOLOR [UIColor colorWithRed:(255/255.0) green:(138/255.0) blue:(59/255.0) alpha:1]
#define STATUS1COLOR [UIColor colorWithRed:(232/255.0) green:(53/255.0) blue:(56/255.0) alpha:1]
#define STATUS2COLOR [UIColor colorWithRed:(37/255.0) green:(169/255.0) blue:(50/255.0) alpha:1]
#define STATUS3COLOR [UIColor colorWithRed:(157/255.0) green:(165/255.0) blue:(176/255.0) alpha:1]

@implementation ProjectCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        UIView *mainView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 85)];
        [self addSubview:mainView];
        self.image=[[UIImageView alloc]initWithFrame:CGRectMake1(10, 10, 60, 60)];
        //        [mainView addSubview:self.image];
        self.title=[[UILabel alloc]initWithFrame:CGRectMake1(10, 10, 300, 25)];
        [self.title setFont:[UIFont systemFontOfSize:17]];
        [self.title setTextColor:TITLECOLOR];
        [self.title setTextAlignment:NSTextAlignmentLeft];
        [mainView addSubview:self.title];
        self.address=[[UILabel alloc]initWithFrame:CGRectMake1(10, 35, 240, 25)];
        [self.address setFont:[UIFont systemFontOfSize:13]];
        [self.address setTextColor:ADDRESSCOLOR];
        [self.address setNumberOfLines:2];
        [self.address setTextAlignment:NSTextAlignmentLeft];
        [mainView addSubview:self.address];
        self.money=[[UILabel alloc]initWithFrame:CGRectMake1(10, 60, 210, 25)];
        [self.money setFont:[UIFont systemFontOfSize:13]];
        [self.money setTextColor:ADDRESSCOLOR];
        [self.money setNumberOfLines:2];
        [self.money setTextAlignment:NSTextAlignmentLeft];
        [mainView addSubview:self.money];
        self.status=[[UILabel alloc]initWithFrame:CGRectMake1(255, 35, 55, 25)];
        self.status.layer.cornerRadius = 2;
        self.status.layer.masksToBounds = YES;
        [self.status setFont:[UIFont systemFontOfSize:15]];
        [self.status setTextColor:[UIColor whiteColor]];
        [self.status setNumberOfLines:2];
        [self.status setTextAlignment:NSTextAlignmentCenter];
        [mainView addSubview:self.status];
        self.date=[[UILabel alloc]initWithFrame:CGRectMake1(225, 60, 85, 25)];
        [self.date setFont:[UIFont systemFontOfSize:13]];
        [self.date setTextColor:ADDRESSCOLOR];
        [self.date setNumberOfLines:2];
        [self.date setTextAlignment:NSTextAlignmentRight];
        [mainView addSubview:self.date];
    }
    return self;
}

- (void)setStatus:(NSString*)title Type:(int)type
{
    [self.status setText:title];
    if(type==1){
        [self.status setBackgroundColor:STATUS1COLOR];
    }else if(type==2){
        [self.status setBackgroundColor:STATUS2COLOR];
    }else{
        [self.status setBackgroundColor:STATUS3COLOR];
    }
}

- (void)setData:(NSDictionary *)data
{
    self.title.text=[data objectForKey:@"Name"];
    self.address.text=[NSString stringWithFormat:@"设备地址:%@",[data objectForKey:@"address"]];
    self.money.text=[NSString stringWithFormat:@"备注:%@",[data objectForKey:@"notes"]];
    [self.date setText:[data objectForKey:@"startTime"]];
    NSString *status=[data objectForKey:@"status"];
    if([@"2" isEqualToString:status]){
        [self setStatus:@"已成交" Type:3];
    }else if([@"1" isEqualToString:status]){
        [self setStatus:@"洽谈中" Type:1];
    }else{
        [self setStatus:@"新发布" Type:2];
    }
}

@end
