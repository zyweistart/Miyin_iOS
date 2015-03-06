//
//  SearchView.m
//  DLS
//
//  Created by Start on 3/6/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "SearchView.h"
#import "ListViewController.h"

#define SEARCHTIPCOLOR [UIColor colorWithRed:(88/255.0) green:(130/255.0) blue:(216/255.0) alpha:1]

@implementation SearchView

- (id)initWithFrame:(CGRect)rect{
    self=[super initWithFrame:rect];
    if(self){
        //CGRectMake1(0, 25, 250, 30)
        UIView *vSearchFramework=[[UIView alloc]initWithFrame:rect];
        [self addSubview:vSearchFramework];
        vSearchFramework.userInteractionEnabled=YES;
        vSearchFramework.layer.cornerRadius = 5;
        vSearchFramework.layer.masksToBounds = YES;
        [vSearchFramework setBackgroundColor:[UIColor whiteColor]];
        [vSearchFramework addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goSearch:)]];
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
    }
    return self;
}
//搜索
- (void)goSearch:(id)sender
{
    [[self.controller navigationController]pushViewController:[[ListViewController alloc]initWithTitle:@"出租列表" Type:2] animated:YES];
}

@end
