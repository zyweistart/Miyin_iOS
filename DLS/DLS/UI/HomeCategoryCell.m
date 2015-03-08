//
//  HomeCategoryCell.m
//  DLS
//
//  Created by Start on 3/4/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "HomeCategoryCell.h"

#define HEADERBGCOLOR [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1]
#define MAINTITLECOLOR [UIColor colorWithRed:(110/255.0) green:(139/255.0) blue:(205/255.0) alpha:1]
#define CHILDTITLECOLOR [UIColor colorWithRed:(158/255.0) green:(158/255.0) blue:(158/255.0) alpha:1]
#define TITLECOLOR [UIColor colorWithRed:(59/255.0) green:(59/255.0) blue:(59/255.0) alpha:1]
#define LINEBGCOLOR [UIColor colorWithRed:(214/255.0) green:(214/255.0) blue:(214/255.0) alpha:1]

@implementation HomeCategoryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //主体
        UIView *headerFrame=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 10)];
        [headerFrame setBackgroundColor:HEADERBGCOLOR];
        [self addSubview:headerFrame];
        UIView *mainFrame=[[UIView alloc]initWithFrame:CGRectMake1(0, 11, 320, 223)];
        [self addSubview:mainFrame];
        
        UIView *category1=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 159.5, 90)];
        [mainFrame addSubview:category1];
        [self addCategorySubView:category1 MainTitle:@"大件运输" ChildTitle:@"大型重物运输供应需求" ImageName:@"category1" Tag:1];
        UIView *category2=[[UIView alloc]initWithFrame:CGRectMake1(160.5, 0, 159.5, 90)];
        [mainFrame addSubview:category2];
        [self addCategorySubView:category2 MainTitle:@"吊车配件" ChildTitle:@"吊车配件供应中心" ImageName:@"category2" Tag:2];
        UIView *category3=[[UIView alloc]initWithFrame:CGRectMake1(0, 91, 159.5, 90)];
        [mainFrame addSubview:category3];
        [self addCategorySubView:category3 MainTitle:@"维修企业" ChildTitle:@"快速寻找最近维修单位" ImageName:@"category3" Tag:3];
        UIView *category4=[[UIView alloc]initWithFrame:CGRectMake1(160.5, 91, 159.5, 90)];
        [mainFrame addSubview:category4];
        [self addCategorySubView:category4 MainTitle:@"二手吊车" ChildTitle:@"闲置二手吊车交易" ImageName:@"category4" Tag:4];
        UIView *category5=[[UIView alloc]initWithFrame:CGRectMake1(0, 182, 320, 40)];
        [mainFrame addSubview:category5];
        UIButton *button1=[[UIButton alloc]initWithFrame:CGRectMake1(0, 10, 80, 20)];
        [[button1 titleLabel]setFont:[UIFont systemFontOfSize:13]];
        [button1 setTitle:@"其他设备" forState:UIControlStateNormal];
        [button1 setTitleColor:TITLECOLOR forState:UIControlStateNormal];
        [button1 addTarget:self action:@selector(goToMain1:) forControlEvents:UIControlEventTouchUpInside];
        button1.tag=5;
        [category5 addSubview:button1];
        UIButton *button2=[[UIButton alloc]initWithFrame:CGRectMake1(80, 10, 80, 20)];
        [[button2 titleLabel]setFont:[UIFont systemFontOfSize:13]];
        [button2 setTitle:@"项目预告" forState:UIControlStateNormal];
        [button2 setTitleColor:TITLECOLOR forState:UIControlStateNormal];
        [button2 setTitleColor:TITLECOLOR forState:UIControlStateNormal];
        [button2 addTarget:self action:@selector(goToMain1:) forControlEvents:UIControlEventTouchUpInside];
        button2.tag=6;
        [category5 addSubview:button2];
        UIButton *button3=[[UIButton alloc]initWithFrame:CGRectMake1(160, 10, 80, 20)];
        [[button3 titleLabel]setFont:[UIFont systemFontOfSize:13]];
        [button3 setTitle:@"起重机制造商" forState:UIControlStateNormal];
        [button3 setTitleColor:TITLECOLOR forState:UIControlStateNormal];
        [button3 setTitleColor:TITLECOLOR forState:UIControlStateNormal];
        [button3 addTarget:self action:@selector(goToMain1:) forControlEvents:UIControlEventTouchUpInside];
        button3.tag=7;
        [category5 addSubview:button3];
        UIButton *button4=[[UIButton alloc]initWithFrame:CGRectMake1(240, 10, 80, 20)];
        [[button4 titleLabel]setFont:[UIFont systemFontOfSize:13]];
        [button4 setTitle:@"企业大全" forState:UIControlStateNormal];
        [button4 setTitleColor:TITLECOLOR forState:UIControlStateNormal];
        [button4 setTitleColor:TITLECOLOR forState:UIControlStateNormal];
        [button4 addTarget:self action:@selector(goToMain1:) forControlEvents:UIControlEventTouchUpInside];
        button4.tag=8;
        [category5 addSubview:button4];
        //底线2
        UIView *line0=[[UIView alloc]initWithFrame:CGRectMake1(0, 10, 320, 1)];
        [line0 setBackgroundColor:LINEBGCOLOR];
        [headerFrame addSubview:line0];
        //竖线
        UIView *line1=[[UIView alloc]initWithFrame:CGRectMake1(159.5, 10, 1, 161)];
        [line1 setBackgroundColor:LINEBGCOLOR];
        [mainFrame addSubview:line1];
        //横线
        UIView *line2=[[UIView alloc]initWithFrame:CGRectMake1(10, 90, 300, 1)];
        [line2 setBackgroundColor:LINEBGCOLOR];
        [mainFrame addSubview:line2];
        //底线1
        UIView *line3=[[UIView alloc]initWithFrame:CGRectMake1(0, 181, 320, 1)];
        [line3 setBackgroundColor:LINEBGCOLOR];
        [mainFrame addSubview:line3];
        //底线2
        UIView *line4=[[UIView alloc]initWithFrame:CGRectMake1(0, 222, 320, 1)];
        [line4 setBackgroundColor:LINEBGCOLOR];
        [mainFrame addSubview:line4];
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)addCategorySubView:(UIView*)frame MainTitle:(NSString*)mainTitle ChildTitle:(NSString*)childTitle ImageName:(NSString*)imageName Tag:(int)tag{
    //主标题
    UILabel *mainTxt=[[UILabel alloc]initWithFrame:CGRectMake1(5, 40, 100, 25)];
    [mainTxt setFont:[UIFont systemFontOfSize:18]];
    [mainTxt setText:mainTitle];
    [mainTxt setTextColor:MAINTITLECOLOR];
    [frame addSubview:mainTxt];
    //子标题
    UILabel *childTxt=[[UILabel alloc]initWithFrame:CGRectMake1(5, 65, 120, 20)];
    [childTxt setFont:[UIFont systemFontOfSize:12]];
    [childTxt setText:childTitle];
    [childTxt setTextColor:CHILDTITLECOLOR];
    [frame addSubview:childTxt];
    //图标
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake1(100, 15, 50, 50)];
    [image setImage:[UIImage imageNamed:imageName]];
    [frame addSubview:image];
    frame.tag=tag;
    [frame addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goToMain:)]];
}

- (void)goToMain:(UITapGestureRecognizer*)sender {
    NSLog(@"%d",[sender.view tag]);
}

- (void)goToMain1:(UIButton*)sender {
    NSLog(@"%d",sender.tag);
}

@end
