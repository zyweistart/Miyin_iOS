//
//  ProjectECell.m
//  DLS
//
//  Created by Start on 3/10/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "ProjectECell.h"
#import <QuartzCore/QuartzCore.h>

#define TITLECOLOR [UIColor colorWithRed:(70/255.0) green:(70/255.0) blue:(70/255.0) alpha:1]
#define ADDRESSCOLOR [UIColor colorWithRed:(142/255.0) green:(142/255.0) blue:(142/255.0) alpha:1]
#define MONEYCOLOR [UIColor colorWithRed:(255/255.0) green:(138/255.0) blue:(59/255.0) alpha:1]
#define STATUS1COLOR [UIColor colorWithRed:(232/255.0) green:(53/255.0) blue:(56/255.0) alpha:1]
#define STATUS2COLOR [UIColor colorWithRed:(37/255.0) green:(169/255.0) blue:(50/255.0) alpha:1]
#define STATUS3COLOR [UIColor colorWithRed:(157/255.0) green:(165/255.0) blue:(176/255.0) alpha:1]

@implementation ProjectECell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        UIView *mainView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 80)];
        [self addSubview:mainView];
        self.image=[[UIImageView alloc]initWithFrame:CGRectMake1(10, 10, 60, 60)];
        [mainView addSubview:self.image];
        self.title=[[UILabel alloc]initWithFrame:CGRectMake1(80, 10, 230, 25)];
        [self.title setFont:[UIFont systemFontOfSize:17]];
        [self.title setTextColor:TITLECOLOR];
        [self.title setTextAlignment:NSTextAlignmentLeft];
        [mainView addSubview:self.title];
        self.address=[[UILabel alloc]initWithFrame:CGRectMake1(80, 35, 230, 20)];
        [self.address setFont:[UIFont systemFontOfSize:13]];
        [self.address setTextColor:ADDRESSCOLOR];
        [self.address setNumberOfLines:2];
        [self.address setTextAlignment:NSTextAlignmentLeft];
        [mainView addSubview:self.address];
        self.money=[[UILabel alloc]initWithFrame:CGRectMake1(80, 55, 230, 20)];
        [self.money setFont:[UIFont systemFontOfSize:17]];
        [self.money setTextColor:MONEYCOLOR];
        [self.money setNumberOfLines:2];
        [self.money setTextAlignment:NSTextAlignmentLeft];
        [mainView addSubview:self.money];
        self.status=[[UILabel alloc]initWithFrame:CGRectMake1(205, 40, 55, 25)];
        self.status.layer.cornerRadius = 2;
        self.status.layer.masksToBounds = YES;
        [self.status setFont:[UIFont systemFontOfSize:15]];
        [self.status setTextColor:[UIColor whiteColor]];
        [self.status setNumberOfLines:2];
        [self.status setTextAlignment:NSTextAlignmentCenter];
        [mainView addSubview:self.status];
        self.detail=[[UILabel alloc]initWithFrame:CGRectMake1(255, 40, 55, 25)];
        self.detail.layer.cornerRadius = 2;
        self.detail.layer.masksToBounds = YES;
        [self.detail setFont:[UIFont systemFontOfSize:15]];
        [self.detail setTextColor:[UIColor whiteColor]];
        [self.detail setNumberOfLines:2];
        [self.detail setTextAlignment:NSTextAlignmentCenter];
        [mainView addSubview:self.detail];
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
}

@end
