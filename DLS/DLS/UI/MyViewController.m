//
//  MyViewController.m
//  DLS
//
//  Created by Start on 3/2/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController

- (id)init{
    self=[super init];
    if(self){
        //顶部头视图
        UIView *topView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 100)];
//        [topView setBackgroundColor:TOPNAVBGCOLOR];
//        [self.view addSubview:topView];
        //定位文案
        UILabel *txtLocation=[[UILabel alloc]initWithFrame:CGRectMake1(5, 25, 50, 30)];
        [txtLocation setTextColor:[UIColor whiteColor]];
        [txtLocation setText:@"杭州"];
        [txtLocation setFont:[UIFont systemFontOfSize:15]];
        [txtLocation setTextAlignment:NSTextAlignmentCenter];
        [topView addSubview:txtLocation];
        //搜索框架
        UIView *vSearchFramework=[[UIView alloc]initWithFrame:CGRectMake1(60, 25, 200, 30)];
        vSearchFramework.layer.cornerRadius = 15;
        vSearchFramework.layer.masksToBounds = YES;
        [vSearchFramework setBackgroundColor:[UIColor colorWithRed:(33/255.0) green:(67/255.0) blue:(131/255.0) alpha:1]];
        [topView addSubview:vSearchFramework];
        //搜索图标
        UIImageView *iconSearch=[[UIImageView alloc]initWithFrame:CGRectMake1(10, 6, 18, 18)];
        [iconSearch setImage:[UIImage imageNamed:@"search"]];
        [vSearchFramework addSubview:iconSearch];
        //搜索框
        UITextField *tfSearch=[[UITextField alloc]initWithFrame:CGRectMake1(38, 0, 152, 30)];
        [tfSearch setPlaceholder:@"输入搜索信息"];
        [tfSearch setTextColor:[UIColor whiteColor]];
        [vSearchFramework addSubview:tfSearch];
        //右消息按钮
        UIImageView *imgMessage=[[UIImageView alloc]initWithFrame:CGRectMake1(278, 30, 24, 20)];
        [imgMessage setImage:[UIImage imageNamed:@"message"]];
        imgMessage.userInteractionEnabled = YES;
//        [imgMessage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goMessage:)]];
        [topView addSubview:imgMessage];
        [self navigationItem].titleView=topView;
    }
    return self;
}
@end
