//
//  JTDGGLViewController.m
//  eClient
//  集团电工管理
//  Created by Start on 3/21/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "JTDGGLViewController.h"

@interface JTDGGLViewController ()

@end

@implementation JTDGGLViewController

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"集团电工管理"];
        UIScrollView *frame=[[UIScrollView alloc]initWithFrame:self.view.bounds];
        [frame setContentSize:CGSizeMake1(320, 250)];
        [frame setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.view addSubview:frame];
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(0, 20, 320, 30)];
        [lbl setText:@"服务类型"];
        [lbl setFont:[UIFont systemFontOfSize:20]];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [frame addSubview:lbl];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(0, 50, 320, 20)];
        [lbl setText:@"这里还有更丰富，更贴心的服务"];
        [lbl setFont:[UIFont systemFontOfSize:13]];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [frame addSubview:lbl];
        
        UIButton *bImage=[[UIButton alloc]initWithFrame:CGRectMake1(110, 80, 100, 100)];
        [bImage setImage:[UIImage imageNamed:@"manager"] forState:UIControlStateNormal];
        [frame addSubview:bImage];
        UILabel *lblTitle=[[UILabel alloc]initWithFrame:CGRectMake1(10,80,100,100)];
        [lblTitle setText:@"彩云运维服务"];
        [lblTitle setFont:[UIFont systemFontOfSize:15]];
        [lblTitle setTextColor:[UIColor blackColor]];
        [lblTitle setNumberOfLines:0];
        [lblTitle setLineBreakMode:NSLineBreakByWordWrapping];
        [frame addSubview:lblTitle];
        
        bImage=[[UIButton alloc]initWithFrame:CGRectMake1(110, 190, 100, 100)];
        [bImage setImage:[UIImage imageNamed:@"manager"] forState:UIControlStateNormal];
        [frame addSubview:bImage];
        lblTitle=[[UILabel alloc]initWithFrame:CGRectMake1(210,190,100,100)];
        [lblTitle setText:@"彩云集团服务"];
        [lblTitle setFont:[UIFont systemFontOfSize:15]];
        [lblTitle setTextColor:[UIColor blackColor]];
        [lblTitle setNumberOfLines:0];
        [lblTitle setLineBreakMode:NSLineBreakByWordWrapping];
        [frame addSubview:lblTitle];
        
    }
    return self;
}

@end
