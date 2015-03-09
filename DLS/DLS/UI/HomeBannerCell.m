//
//  HomeBannerCellTableViewCell.m
//  DLS
//
//  Created by Start on 3/3/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "HomeBannerCell.h"
#import "UIButton+TitleImage.h"
#import "ListViewController.h"

#define TITLECOLOR  [UIColor colorWithRed:(124/255.0) green:(124/255.0) blue:(124/255.0) alpha:1]

@implementation HomeBannerCell{
    NSDictionary *data;
}

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
        
        data=[[NSDictionary alloc]initWithObjectsAndKeys:
              @"汽车吊求租",@"1",
              @"履带吊求租",@"2",
              @"VIP独家项目",@"3",
              @"工程信息",@"4",
              @"汽车吊出租",@"5",
              @"履带吊出租",@"6",
              @"招标公告",@"7",
              @"招聘信息",@"8", nil];
        
    }
    return self;
}

- (void)addModel:(NSString*)image Title:(NSString*)title Frame:(UIView*)frame Tag:(NSUInteger)tag X:(CGFloat)x Y:(CGFloat)y
{
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake1(x, y, 80, 90)];
    [button setTitle:title forImage:[UIImage imageNamed:image]];
    [button setTitleColor:TITLECOLOR forState:UIControlStateNormal];
    [button addTarget:self action:@selector(goToMain:) forControlEvents:UIControlEventTouchUpInside];
    button.tag=tag;
    [frame addSubview:button];
}

- (void)goToMain:(UIButton*)sender {
    [self.controller.navigationController pushViewController:[[ListViewController alloc]initWithTitle:[data objectForKey:[NSString stringWithFormat:@"%d",sender.tag]] Type:sender.tag] animated:YES];
}

@end
