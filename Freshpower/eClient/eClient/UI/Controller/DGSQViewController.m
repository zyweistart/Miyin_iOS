//
//  DGSQViewController.m
//  eClient
//  电工神器
//  Created by Start on 3/21/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "DGSQViewController.h"
#import "SVButton.h"
#import "RegisterViewController.h"
#define BGCOLOR [UIColor colorWithRed:(28/255.0) green:(143/255.0) blue:(213/255.0) alpha:1]
#define TITLECOLOR [UIColor colorWithRed:(200/255.0) green:(200/255.0) blue:(200/255.0) alpha:1]

@interface DGSQViewController ()

@end

@implementation DGSQViewController

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"电工神器"];
        UIScrollView *scrollFrame=[[UIScrollView alloc]initWithFrame:self.view.bounds];
        [scrollFrame setContentSize:CGSizeMake1(320, 420)];
        [self.view addSubview:scrollFrame];
        UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake1(0, 0, 414, 229)];
        [image setImage:[UIImage imageNamed:@"注册提示页面"]];
        [scrollFrame addSubview:image];
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(0, 229, 320, 50)];
        [lbl setText:@"马上下载e电工操作版，获取更佳体验！"];
        [lbl setFont:[UIFont systemFontOfSize:15]];
        [lbl setTextColor:[UIColor whiteColor]];
        [lbl setBackgroundColor:BGCOLOR];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [scrollFrame addSubview:lbl];
        UIImageView *image1=[[UIImageView alloc]initWithFrame:CGRectMake1(240, 260, 50, 50)];
        [image1 setImage:[UIImage imageNamed:@"心"]];
        [scrollFrame addSubview:image1];
        SVButton *bRegister=[[SVButton alloc]initWithFrame:CGRectMake1(10, 320, 300, 40) Title:@"马上注册为e电工" Type:2];
        [bRegister addTarget:self action:@selector(goRegister:) forControlEvents:UIControlEventTouchUpInside];
        [scrollFrame addSubview:bRegister];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(20, 380, 250, 30)];
        [lbl setText:@"e电工操作版，更适用于您的管电神器。"];
        [lbl setTextColor:TITLECOLOR];
        [lbl setFont:[UIFont systemFontOfSize:15]];
        [scrollFrame addSubview:lbl];
        
//        UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake1(20, 380, 40, 40)];
//        [image2 setImage:[UIImage imageNamed:@"app"]];
//        [scrollFrame addSubview:image2];
//        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(70, 380, 230, 40)];
//        [lbl setText:@"点击获取e电工操作版"];
//        [lbl setFont:[UIFont systemFontOfSize:15]];
//        [lbl setTextColor:[UIColor redColor]];
//        [lbl setTextAlignment:NSTextAlignmentLeft];
//        [scrollFrame addSubview:lbl];
    }
    return self;
}

- (void)goRegister:(id)sender
{
    [self.navigationController pushViewController:[[RegisterViewController alloc]init] animated:YES];
}

@end
