//
//  WBBPDZViewController.m
//  eClient
//  外包变配电站
//  Created by Start on 3/21/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "WBBPDZViewController.h"

@interface WBBPDZViewController ()

@end

@implementation WBBPDZViewController

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"外包变配电站"];
        UIView *frame=[[UIView alloc]initWithFrame:self.view.bounds];
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
        UILabel *lblTitle=[[UILabel alloc]initWithFrame:CGRectMake1(210,80,100,100)];
        [lblTitle setText:@"变电站24小时值守服务"];
        [lblTitle setFont:[UIFont systemFontOfSize:15]];
        [lblTitle setTextColor:[UIColor blackColor]];
        [lblTitle setNumberOfLines:0];
        [lblTitle setLineBreakMode:NSLineBreakByWordWrapping];
        [frame addSubview:lblTitle];
        
        bImage=[[UIButton alloc]initWithFrame:CGRectMake1(110, 190, 100, 100)];
        [bImage setImage:[UIImage imageNamed:@"manager"] forState:UIControlStateNormal];
        [frame addSubview:bImage];
        lblTitle=[[UILabel alloc]initWithFrame:CGRectMake1(10,190,100,100)];
        [lblTitle setText:@"变电站巡检服务"];
        [lblTitle setFont:[UIFont systemFontOfSize:15]];
        [lblTitle setTextColor:[UIColor blackColor]];
        [lblTitle setNumberOfLines:0];
        [lblTitle setLineBreakMode:NSLineBreakByWordWrapping];
        [frame addSubview:lblTitle];
        
        bImage=[[UIButton alloc]initWithFrame:CGRectMake1(110, 300, 100, 100)];
        [bImage setImage:[UIImage imageNamed:@"manager"] forState:UIControlStateNormal];
        [frame addSubview:bImage];
        lblTitle=[[UILabel alloc]initWithFrame:CGRectMake1(210,300,100,100)];
        [lblTitle setText:@"变电站维保服务"];
        [lblTitle setFont:[UIFont systemFontOfSize:15]];
        [lblTitle setTextColor:[UIColor blackColor]];
        [lblTitle setNumberOfLines:0];
        [lblTitle setLineBreakMode:NSLineBreakByWordWrapping];
        [frame addSubview:lblTitle];
        
    }
    return self;
}

@end
