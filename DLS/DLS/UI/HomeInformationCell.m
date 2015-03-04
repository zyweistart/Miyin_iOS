//
//  HomeInformationCell.m
//  DLS
//
//  Created by Start on 3/4/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "HomeInformationCell.h"

#define BGCOLOR [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1]
#define LINEBGCOLOR [UIColor colorWithRed:(214/255.0) green:(214/255.0) blue:(214/255.0) alpha:1]
#define CATEGORYBGCOLOR [UIColor colorWithRed:(173/255.0) green:(176/255.0) blue:(181/255.0) alpha:1]

#define MAINTITLECOLOR [UIColor colorWithRed:(110/255.0) green:(139/255.0) blue:(205/255.0) alpha:1]
#define CHILDTITLECOLOR [UIColor colorWithRed:(158/255.0) green:(158/255.0) blue:(158/255.0) alpha:1]
#define TITLECOLOR [UIColor colorWithRed:(54/255.0) green:(54/255.0) blue:(54/255.0) alpha:1]

@implementation HomeInformationCell{
    int currentButtonIndex;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBackgroundColor:BGCOLOR];
        //主体
        UIView *mainFrame=[[UIView alloc]initWithFrame:CGRectMake1(0, 10, 320, 450)];
        [self addSubview:mainFrame];
        //分类
        UIView *categoryFrame =[[UIView alloc] initWithFrame:CGRectMake1(10, 0, 300, 40)] ;
        [mainFrame addSubview:categoryFrame];
        //资讯主体
        UIView *informationFrame =[[UIView alloc] initWithFrame:CGRectMake1(10, 50, 300, 400)] ;
        [mainFrame addSubview:informationFrame];
        
        self.button1=[[UIButton alloc]initWithFrame:CGRectMake1(0, 0, 75, 40)];
        [[self.button1 titleLabel]setFont:[UIFont systemFontOfSize:14]];
        [self.button1 setTitle:@"最新出租" forState:UIControlStateNormal];
        self.button1.tag=1;
        [self.button1 addTarget:self action:@selector(switchCategory:) forControlEvents:UIControlEventTouchDown];
        [categoryFrame addSubview:self.button1];
        self.button2=[[UIButton alloc]initWithFrame:CGRectMake1(75, 0, 75, 40)];
        [[self.button2 titleLabel]setFont:[UIFont systemFontOfSize:14]];
        [self.button2 setTitle:@"最新求租" forState:UIControlStateNormal];
        self.button2.tag=2;
        [self.button2 addTarget:self action:@selector(switchCategory:) forControlEvents:UIControlEventTouchDown];
        [categoryFrame addSubview:self.button2];
        self.button3=[[UIButton alloc]initWithFrame:CGRectMake1(150, 0, 75, 40)];
        [[self.button3 titleLabel]setFont:[UIFont systemFontOfSize:14]];
        [self.button3 setTitle:@"中标结果" forState:UIControlStateNormal];
        self.button3.tag=3;
        [self.button3 addTarget:self action:@selector(switchCategory:) forControlEvents:UIControlEventTouchDown];
        [categoryFrame addSubview:self.button3];
        self.button4=[[UIButton alloc]initWithFrame:CGRectMake1(225, 0, 75, 40)];
        [[self.button4 titleLabel]setFont:[UIFont systemFontOfSize:14]];
        [self.button4 setTitle:@"行业资讯" forState:UIControlStateNormal];
        self.button4.tag=4;
        [self.button4 addTarget:self action:@selector(switchCategory:) forControlEvents:UIControlEventTouchDown];
        [categoryFrame addSubview:self.button4];
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        currentButtonIndex=1;
        [self showButtonStyle];
    }
    return self;
}

- (void)switchCategory:(UIButton*)sender {
    currentButtonIndex=sender.tag;
    [self showButtonStyle];
    //切换页面刷新数据
}

- (void)showButtonStyle{
    [self.button1 setTitleColor:currentButtonIndex==1?[UIColor whiteColor]:TITLECOLOR forState:UIControlStateNormal];
    [self.button1 setBackgroundColor:currentButtonIndex==1?CATEGORYBGCOLOR:[UIColor whiteColor]];
    [self.button2 setTitleColor:currentButtonIndex==2?[UIColor whiteColor]:TITLECOLOR forState:UIControlStateNormal];
    [self.button2 setBackgroundColor:currentButtonIndex==2?CATEGORYBGCOLOR:[UIColor whiteColor]];
    [self.button3 setTitleColor:currentButtonIndex==3?[UIColor whiteColor]:TITLECOLOR forState:UIControlStateNormal];
    [self.button3 setBackgroundColor:currentButtonIndex==3?CATEGORYBGCOLOR:[UIColor whiteColor]];
    [self.button4 setTitleColor:currentButtonIndex==4?[UIColor whiteColor]:TITLECOLOR forState:UIControlStateNormal];
    [self.button4 setBackgroundColor:currentButtonIndex==4?CATEGORYBGCOLOR:[UIColor whiteColor]];
}

@end
