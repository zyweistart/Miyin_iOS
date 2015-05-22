//
//  ProjectDCell.m
//  DLS
//
//  Created by Start on 3/8/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "ProjectDCell.h"
#define TITLECOLOR [UIColor colorWithRed:(93/255.0) green:(93/255.0) blue:(93/255.0) alpha:1]
#define CHILDTITLECOLOR [UIColor colorWithRed:(194/255.0) green:(194/255.0) blue:(194/255.0) alpha:1]
#define MONEYCOLOR [UIColor colorWithRed:(236/255.0) green:(129/255.0) blue:(59/255.0) alpha:1]
#define DATECOLOR [UIColor colorWithRed:(176/255.0) green:(176/255.0) blue:(176/255.0) alpha:1]
#define STATUSTEXTCOLOR [UIColor colorWithRed:(77/255.0) green:(77/255.0) blue:(77/255.0) alpha:1]
#define STATUSBGCOLOR [UIColor colorWithRed:(47/255.0) green:(95/255.0) blue:(177/255.0) alpha:1]

@implementation ProjectDCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        UIView *mainView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 70)];
        [self addSubview:mainView];
        self.title=[[UILabel alloc]initWithFrame:CGRectMake1(10, 10, 270, 20)];
        [self.title setFont:[UIFont systemFontOfSize:15]];
        [self.title setTextColor:TITLECOLOR];
        [self.title setTextAlignment:NSTextAlignmentLeft];
        [mainView addSubview:self.title];
        self.content=[[UILabel alloc]initWithFrame:CGRectMake1(10, 30, 270, 20)];
        [self.content setFont:[UIFont systemFontOfSize:13]];
        [self.content setTextColor:CHILDTITLECOLOR];
        [self.content setTextAlignment:NSTextAlignmentLeft];
        [mainView addSubview:self.content];
        self.money=[[UILabel alloc]initWithFrame:CGRectMake1(10, 50, 100, 20)];
        [self.money setFont:[UIFont systemFontOfSize:13]];
        [self.money setTextColor:MONEYCOLOR];
        [self.money setTextAlignment:NSTextAlignmentLeft];
        [mainView addSubview:self.money];
        self.date=[[UILabel alloc]initWithFrame:CGRectMake1(110, 50, 100, 20)];
        [self.date setFont:[UIFont systemFontOfSize:13]];
        [self.date setTextColor:DATECOLOR];
        [self.date setTextAlignment:NSTextAlignmentLeft];
        [mainView addSubview:self.date];
        self.status=[[UILabel alloc]initWithFrame:CGRectMake1(280, 10, 30, 20)];
        self.status.layer.cornerRadius = 2;
        self.status.layer.masksToBounds = YES;
        [self.status setFont:[UIFont systemFontOfSize:13]];
        [self.status setTextColor:[UIColor whiteColor]];
        [self.status setTextAlignment:NSTextAlignmentCenter];
        [self.status setBackgroundColor:STATUSBGCOLOR];
        [mainView addSubview:self.status];
    }
    return self;
}

- (void)setData:(NSDictionary *)data
{
    [self.title setText:@"得力手起重机招聘专业吊车驾驶聘专业吊车驾驶员聘专业吊车驾驶员聘专业吊车驾驶员聘专业吊车驾驶员员"];
    [self.content setText:@"老司低运老司低哪里有啡啡罪罪恩啊jdlkjdlkjdlk晨lkjd回国"];
    [self.money setText:@"2000-5000/月"];
    [self.date setText:@"2015-20-21"];
    [self.status setText:@"验"];
}

@end
