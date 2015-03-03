//
//  HomeBannerCellTableViewCell.m
//  DLS
//
//  Created by Start on 3/3/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "HomeBannerCell.h"
#import "UIButton+ImageWithLable.h"

@implementation HomeBannerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *banner=[[UIImageView alloc]initWithFrame:CGRectMake1(0, 0, 320, 90)];
        [banner setImage:[UIImage imageNamed:@"banner"]];
        [self addSubview:banner];
        
        //主体
        UIView *mainFrame=[[UIView alloc]initWithFrame:CGRectMake1(0, 100, 320, 180)];
        [self addSubview:mainFrame];
        //汽车吊求租
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake1(0, 0, 80, 90)];
        button.tag=1;
        [button setImage:[UIImage imageNamed:@"autocrane_i"] withTitle:@"汽车吊求租" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(goToMain:) forControlEvents:UIControlEventTouchDown];
        [mainFrame addSubview:button];
        //履带吊求租
        button=[[UIButton alloc]initWithFrame:CGRectMake1(80, 0, 80, 90)];
        button.tag=2;
        [button setImage:[UIImage imageNamed:@"crawlercrane_i"] withTitle:@"履带吊求租" forState:UIControlStateNormal];
        [mainFrame addSubview:button];
        //VIP独家项目
        button=[[UIButton alloc]initWithFrame:CGRectMake1(160, 0, 80, 90)];
        button.tag=3;
        [button setImage:[UIImage imageNamed:@"vip"] withTitle:@"VIP独家项目" forState:UIControlStateNormal];
        [mainFrame addSubview:button];
        //工程信息
        button=[[UIButton alloc]initWithFrame:CGRectMake1(240, 0, 80, 90)];
        button.tag=4;
        [button setImage:[UIImage imageNamed:@"engineering_i"] withTitle:@"工程信息" forState:UIControlStateNormal];
        [mainFrame addSubview:button];
        //汽车吊出租
        button=[[UIButton alloc]initWithFrame:CGRectMake1(0, 90, 80, 90)];
        button.tag=5;
        [button setImage:[UIImage imageNamed:@"autocrane_o"] withTitle:@"汽车吊出租" forState:UIControlStateNormal];
        [mainFrame addSubview:button];
        //履带吊出租
        button=[[UIButton alloc]initWithFrame:CGRectMake1(80, 90, 80, 90)];
        button.tag=6;
        [button setImage:[UIImage imageNamed:@"crawlercrane_o"] withTitle:@"履带吊出租" forState:UIControlStateNormal];
        [mainFrame addSubview:button];
        //招标公告
        button=[[UIButton alloc]initWithFrame:CGRectMake1(160, 90, 80, 90)];
        button.tag=7;
        [button setImage:[UIImage imageNamed:@"tender"] withTitle:@"招标公告" forState:UIControlStateNormal];
        [mainFrame addSubview:button];
        //招聘信息
        button=[[UIButton alloc]initWithFrame:CGRectMake1(240, 90, 80, 90)];
        button.tag=8;
        [button setImage:[UIImage imageNamed:@"recruitment"] withTitle:@"招聘信息" forState:UIControlStateNormal];
        [mainFrame addSubview:button];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)goToMain:(UIButton*)sender {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"信息"
                          message:@"这是消息"
                          delegate:nil
                          cancelButtonTitle:@"取消"
                          otherButtonTitles:nil, nil];
    [alert show];
}

@end
