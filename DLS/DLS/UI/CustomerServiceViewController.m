//
//  CustomerServiceViewController.m
//  DLS
//
//  Created by Start on 5/18/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "CustomerServiceViewController.h"

@interface CustomerServiceViewController ()

@end

@implementation CustomerServiceViewController

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"客服中心"];
        //返回
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]
                                               initWithTitle:@"返回"
                                               style:UIBarButtonItemStyleBordered
                                               target:self
                                               action:@selector(goBack:)];
        
        UIView *viewFrame=[[UIView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:viewFrame];
        
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(20, 10, 300, 20)];
        [lbl setText:@"客服帮助"];
        [lbl setFont:[UIFont systemFontOfSize:15]];
        [lbl setTextColor:[UIColor orangeColor]];
        [viewFrame addSubview:lbl];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(20, 30, 300, 20)];
        [lbl setText:@"Service"];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextColor:DEFAUL1COLOR];
        [viewFrame addSubview:lbl];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(20, 50, 300, 20)];
        [lbl setText:@"联系电话:0571-57573330"];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextColor:DEFAUL1COLOR];
        [viewFrame addSubview:lbl];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(20, 90, 300, 20)];
        [lbl setText:@"品牌公关合作"];
        [lbl setFont:[UIFont systemFontOfSize:15]];
        [lbl setTextColor:[UIColor orangeColor]];
        [viewFrame addSubview:lbl];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(20, 110, 300, 20)];
        [lbl setText:@"Brand pr"];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextColor:DEFAUL1COLOR];
        [viewFrame addSubview:lbl];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(20, 130, 300, 20)];
        [lbl setText:@"联系人:徐小姐"];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextColor:DEFAUL1COLOR];
        [viewFrame addSubview:lbl];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(20, 150, 300, 20)];
        [lbl setText:@"联系电话:18072932005"];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextColor:DEFAUL1COLOR];
        [viewFrame addSubview:lbl];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(20, 190, 300, 20)];
        [lbl setText:@"市场合作"];
        [lbl setFont:[UIFont systemFontOfSize:15]];
        [lbl setTextColor:[UIColor orangeColor]];
        [viewFrame addSubview:lbl];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(20, 210, 300, 20)];
        [lbl setText:@"Market"];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextColor:DEFAUL1COLOR];
        [viewFrame addSubview:lbl];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(20, 230, 300, 20)];
        [lbl setText:@"联系人:李小姐"];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextColor:DEFAUL1COLOR];
        [viewFrame addSubview:lbl];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(20, 250, 300, 20)];
        [lbl setText:@"联系电话:18072932007"];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextColor:DEFAUL1COLOR];
        [viewFrame addSubview:lbl];
        
    }
    return self;
}

@end
