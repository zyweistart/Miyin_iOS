//
//  HomeBannerCellTableViewCell.m
//  DLS
//
//  Created by Start on 3/3/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "HomeBannerCell.h"
#import "ListViewController.h"

#define TITLECOLOR  [UIColor colorWithRed:(124/255.0) green:(124/255.0) blue:(124/255.0) alpha:1]

@implementation HomeBannerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *banner=[[UIImageView alloc]initWithFrame:CGRectMake1(0, 0, 320, 90)];
        [banner setImage:[UIImage imageNamed:@"banner"]];
        [self addSubview:banner];
        UIView *mainFrame=[[UIView alloc]initWithFrame:CGRectMake1(0, 100, 320, 180)];
        [self addSubview:mainFrame];
        [self addModel:@"autocrane_i" Title:@"汽车吊求租" Frame:mainFrame Tag:1 X:0 Y:0];
        [self addModel:@"crawlercrane_i" Title:@"履带吊求租" Frame:mainFrame Tag:2 X:80 Y:0];
        [self addModel:@"vip" Title:@"VIP独家项目" Frame:mainFrame Tag:3 X:160 Y:0];
        [self addModel:@"engineering_i" Title:@"工程信息" Frame:mainFrame Tag:4 X:240 Y:0];
        [self addModel:@"autocrane_o" Title:@"汽车吊出租" Frame:mainFrame Tag:5 X:0 Y:90];
        [self addModel:@"crawlercrane_o" Title:@"履带吊出租" Frame:mainFrame Tag:6 X:80 Y:90];
        [self addModel:@"tender" Title:@"招标公告" Frame:mainFrame Tag:7 X:160 Y:90];
        [self addModel:@"recruitment" Title:@"招聘信息" Frame:mainFrame Tag:8 X:240 Y:90];
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)addModel:(NSString*)image Title:(NSString*)title Frame:(UIView*)frame Tag:(NSUInteger)tag X:(CGFloat)x Y:(CGFloat)y
{
    UIView *model=[[UIView alloc]initWithFrame:CGRectMake1(x, y, 80, 90)];
    model.tag=tag;
    [model addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goToMain:)]];
    UIImageView *imgBG=[[UIImageView alloc]initWithFrame:CGRectMake1(13, 6, 54, 54)];
    [model addSubview:imgBG];
    UILabel *txtTitle=[[UILabel alloc]initWithFrame:CGRectMake1(0, 60, 80, 30)];
    [model addSubview:txtTitle];
    [txtTitle setTextColor:TITLECOLOR];
    [txtTitle setFont:[UIFont systemFontOfSize:13]];
    [txtTitle setTextAlignment:NSTextAlignmentCenter];
    
    [imgBG setImage:[UIImage imageNamed:image]];
    [txtTitle setText:title];
    [frame addSubview:model];
}

- (void)goToMain:(UITapGestureRecognizer*)sender {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"信息"
                          message:@"这是消息"
                          delegate:nil
                          cancelButtonTitle:@"取消"
                          otherButtonTitles:nil, nil];
    [alert show];
}

@end
