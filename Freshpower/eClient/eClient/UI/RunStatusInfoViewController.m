//
//  RunStatusInfoViewController.m
//  eClient
//
//  Created by Start on 4/14/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "RunStatusInfoViewController.h"
#import "WebDetailViewController.h"
#define TITLE1COLOR [UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1]

@interface RunStatusInfoViewController ()

@end

@implementation RunStatusInfoViewController

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"运行状态"];
        
        UIScrollView *scrollFrame=[[UIScrollView alloc]initWithFrame:self.view.bounds];
        [scrollFrame setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [scrollFrame setContentSize:CGSizeMake1(320, 700)];
        [self.view addSubview:scrollFrame];
        
        UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake1(80, 40, 160, 160)];
        [image setImage:[UIImage imageNamed:@"sj"]];
        [scrollFrame addSubview:image];
        
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 220, 300, 20)];
        [lbl setText:@"变电站运行监测服务"];
        [lbl setFont:[UIFont systemFontOfSize:15]];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [scrollFrame addSubview:lbl];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 240, 300, 20)];
        [lbl setText:@"变电站运行状态实时掌握"];
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
    [self.navigationController pushViewController:[[WebDetailViewController alloc]initWithType:1 Url:self.currentUrl] animated:YES];
}

@end
