//
//  WarnComapnyInfoViewController.m
//  eClient
//
//  Created by Start on 4/15/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "WarnComapnyInfoViewController.h"
#import "WebDetailViewController.h"

#define TITLE1COLOR [UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1]

@interface WarnComapnyInfoViewController ()

@end

@implementation WarnComapnyInfoViewController

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"报警信息"];
        
        UIScrollView *scrollFrame=[[UIScrollView alloc]initWithFrame:self.view.bounds];
        [scrollFrame setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [scrollFrame setContentSize:CGSizeMake1(320, 700)];
        [self.view addSubview:scrollFrame];
        
        UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake1(80, 40, 160, 160)];
        [image setImage:[UIImage imageNamed:@"js"]];
        [scrollFrame addSubview:image];
        
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 220, 300, 20)];
        [lbl setText:@"变电站运行监服务"];
        [lbl setFont:[UIFont systemFontOfSize:15]];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [scrollFrame addSubview:lbl];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 240, 300, 20)];
        [lbl setText:@"故障报警、异常预警实时响应"];
        [lbl setFont:[UIFont systemFontOfSize:13]];
        [lbl setTextColor:TITLE1COLOR];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [scrollFrame addSubview:lbl];
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake1(10, 260, 300, 20)];
        [btn setTitle:@"了解详情>>" forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [btn addTarget:self action:@selector(goOpen:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [scrollFrame addSubview:btn];
    }
    return self;
}

- (void)goOpen:(id)sender
{
    [self.navigationController pushViewController:[[WebDetailViewController alloc]initWithType:1 Url:@""] animated:YES];
//    NSLog(@"url%@",self.currentUrl);
}

@end