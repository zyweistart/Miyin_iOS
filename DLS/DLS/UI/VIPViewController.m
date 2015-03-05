//
//  VIPViewController.m
//  DLS
//
//  Created by Start on 3/2/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "VIPViewController.h"

#define SEARCHTIPCOLOR [UIColor colorWithRed:(88/255.0) green:(130/255.0) blue:(216/255.0) alpha:1]

@interface VIPViewController ()

@end

@implementation VIPViewController

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"VIP"];
        //搜索框架
        UIView *vSearchFramework=[[UIView alloc]initWithFrame:CGRectMake1(0, 25, 250, 30)];
        vSearchFramework.userInteractionEnabled=YES;
        vSearchFramework.layer.cornerRadius = 5;
        vSearchFramework.layer.masksToBounds = YES;
        [vSearchFramework setBackgroundColor:[UIColor whiteColor]];
        [vSearchFramework addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goSearch:)]];
        [self navigationItem].titleView=vSearchFramework;
        //搜索图标
        UIImageView *iconSearch=[[UIImageView alloc]initWithFrame:CGRectMake1(10, 6, 18, 18)];
        [iconSearch setImage:[UIImage imageNamed:@"search"]];
        [vSearchFramework addSubview:iconSearch];
        //搜索框
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(38, 0, 152, 30)];
        [lbl setText:@"输入搜索信息"];
        [lbl setTextColor:SEARCHTIPCOLOR];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [vSearchFramework addSubview:lbl];
        
        //右消息按钮
        UIButton *btnMap = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnMap setBackgroundImage:[UIImage imageNamed:@"list"]forState:UIControlStateNormal];
        [btnMap addTarget:self action:@selector(goMap:) forControlEvents:UIControlEventTouchUpInside];
        btnMap.frame = CGRectMake(0, 0, 24, 20);
        UIBarButtonItem *negativeSpacerRight = [[UIBarButtonItem alloc]
                                                initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                target:nil action:nil];
        negativeSpacerRight.width = -5;
        self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacerRight, [[UIBarButtonItem alloc] initWithCustomView:btnMap], nil];
    }
    return self;
}
//搜索
- (void)goSearch:(id)sender
{
}
//地图
- (void)goMap:(UIButton*)sender
{
}

@end
