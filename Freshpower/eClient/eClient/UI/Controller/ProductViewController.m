//
//  ProductViewController.m
//  eClient
//  产品介绍
//  Created by Start on 3/21/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "ProductViewController.h"

@interface ProductViewController ()

@end

@implementation ProductViewController

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"产品"];
        UIScrollView *frame=[[UIScrollView alloc]initWithFrame:self.view.bounds];
        [frame setContentSize:CGSizeMake1(320, 750)];
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
        bImage.tag=1;
        [bImage addTarget:self action:@selector(goDetail:) forControlEvents:UIControlEventTouchUpInside];
        [bImage setImage:[UIImage imageNamed:@"manager"] forState:UIControlStateNormal];
        [frame addSubview:bImage];
        UILabel *lblTitle=[[UILabel alloc]initWithFrame:CGRectMake1(10,80,100,100)];
        [lblTitle setText:@"白云运维服务"];
        [lblTitle setFont:[UIFont systemFontOfSize:15]];
        [lblTitle setTextColor:[UIColor blackColor]];
        [lblTitle setNumberOfLines:0];
        [lblTitle setLineBreakMode:NSLineBreakByWordWrapping];
        [frame addSubview:lblTitle];
        
        bImage=[[UIButton alloc]initWithFrame:CGRectMake1(110, 190, 100, 100)];
        bImage.tag=2;
        [bImage addTarget:self action:@selector(goDetail:) forControlEvents:UIControlEventTouchUpInside];
        [bImage setImage:[UIImage imageNamed:@"manager"] forState:UIControlStateNormal];
        [frame addSubview:bImage];
        lblTitle=[[UILabel alloc]initWithFrame:CGRectMake1(210,190,100,100)];
        [lblTitle setText:@"白云监测服务"];
        [lblTitle setFont:[UIFont systemFontOfSize:15]];
        [lblTitle setTextColor:[UIColor blackColor]];
        [lblTitle setNumberOfLines:0];
        [lblTitle setLineBreakMode:NSLineBreakByWordWrapping];
        [frame addSubview:lblTitle];
        
        bImage=[[UIButton alloc]initWithFrame:CGRectMake1(110, 300, 100, 100)];
        bImage.tag=3;
        [bImage addTarget:self action:@selector(goDetail:) forControlEvents:UIControlEventTouchUpInside];
        [bImage setImage:[UIImage imageNamed:@"manager"] forState:UIControlStateNormal];
        [frame addSubview:bImage];
        lblTitle=[[UILabel alloc]initWithFrame:CGRectMake1(10,300,100,100)];
        [lblTitle setText:@"白云报警服务"];
        [lblTitle setFont:[UIFont systemFontOfSize:15]];
        [lblTitle setTextColor:[UIColor blackColor]];
        [lblTitle setNumberOfLines:0];
        [lblTitle setLineBreakMode:NSLineBreakByWordWrapping];
        [frame addSubview:lblTitle];
        
        bImage=[[UIButton alloc]initWithFrame:CGRectMake1(110, 410, 100, 100)];
        bImage.tag=4;
        [bImage addTarget:self action:@selector(goDetail:) forControlEvents:UIControlEventTouchUpInside];
        [bImage setImage:[UIImage imageNamed:@"manager"] forState:UIControlStateNormal];
        [frame addSubview:bImage];
        lblTitle=[[UILabel alloc]initWithFrame:CGRectMake1(210,410,100,100)];
        [lblTitle setText:@"彩云监测服务"];
        [lblTitle setFont:[UIFont systemFontOfSize:15]];
        [lblTitle setTextColor:[UIColor blackColor]];
        [lblTitle setNumberOfLines:0];
        [lblTitle setLineBreakMode:NSLineBreakByWordWrapping];
        [frame addSubview:lblTitle];
        
        bImage=[[UIButton alloc]initWithFrame:CGRectMake1(110, 520, 100, 100)];
        bImage.tag=5;
        [bImage addTarget:self action:@selector(goDetail:) forControlEvents:UIControlEventTouchUpInside];
        [bImage setImage:[UIImage imageNamed:@"manager"] forState:UIControlStateNormal];
        [frame addSubview:bImage];
        lblTitle=[[UILabel alloc]initWithFrame:CGRectMake1(10,520,100,100)];
        [lblTitle setText:@"人工巡检服务"];
        [lblTitle setFont:[UIFont systemFontOfSize:15]];
        [lblTitle setTextColor:[UIColor blackColor]];
        [lblTitle setNumberOfLines:0];
        [lblTitle setLineBreakMode:NSLineBreakByWordWrapping];
        [frame addSubview:lblTitle];
        
        bImage=[[UIButton alloc]initWithFrame:CGRectMake1(110, 640, 100, 100)];
        bImage.tag=6;
        [bImage addTarget:self action:@selector(goDetail:) forControlEvents:UIControlEventTouchUpInside];
        [bImage setImage:[UIImage imageNamed:@"manager"] forState:UIControlStateNormal];
        [frame addSubview:bImage];
        lblTitle=[[UILabel alloc]initWithFrame:CGRectMake1(210,640,100,100)];
        [lblTitle setText:@"人工维保服务"];
        [lblTitle setFont:[UIFont systemFontOfSize:15]];
        [lblTitle setTextColor:[UIColor blackColor]];
        [lblTitle setNumberOfLines:0];
        [lblTitle setLineBreakMode:NSLineBreakByWordWrapping];
        [frame addSubview:lblTitle];
    }
    return self;
}

- (void)goDetail:(UIButton*)sender
{
    NSLog(@"%ld",[sender tag]);
}

@end
