//
//  RecruitmentDetailViewController.m
//  DLS
//  招聘详情
//  Created by Start on 3/9/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "RecruitmentDetailViewController.h"
#import "ButtonView.h"
#import "CommonData.h"

@interface RecruitmentDetailViewController ()

@end

@implementation RecruitmentDetailViewController

- (id)initWithDictionary:(NSDictionary*)data{
    self=[super init];
    if(self){
        self.data=data;
        NSString *job_title=[Common getString:[data objectForKey:@"job_title"]];
        NSString *job_category=[Common getString:[data objectForKey:@"job_category"]];
        NSString *CreateDate=[Common convertTime:[data objectForKey:@"CreateDate"]];
        
        NSString *phone=[Common getString:[data objectForKey:@"phone"]];
        NSString *month_salary=[Common getString:[data objectForKey:@"month_salary"]];
        NSString *address=[Common getString:[data objectForKey:@"address"]];
        NSString *cName=[Common getString:[data objectForKey:@"cName"]];
        NSString *degree_required=[Common getString:[data objectForKey:@"degree_required"]];
        NSString *job_specification=[Common getString:[data objectForKey:@"job_specification"]];

        [self setTitle:@"招聘详情"];
        
        UIScrollView *scrollFrame=[[UIScrollView alloc]initWithFrame:self.view.bounds];
        [scrollFrame setContentSize:CGSizeMake1(320, 550)];
        [scrollFrame setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.view addSubview:scrollFrame];

        UIView *view1=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 90)];
        [scrollFrame addSubview:view1];
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 5, 300, 30)];
        [lbl setText:job_title];
        [lbl setFont:[UIFont systemFontOfSize:18]];
        [lbl setTextColor:[UIColor blackColor]];
        [view1 addSubview:lbl];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 35, 300, 30)];
        job_category=[CommonData getValueArray:[CommonData getJob] Key:job_category];
        [lbl setText:[NSString stringWithFormat:@"%@",job_category]];
        [lbl setFont:[UIFont systemFontOfSize:16]];
        [lbl setTextColor:[UIColor blackColor]];
        [view1 addSubview:lbl];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 65, 300, 20)];
        [lbl setText:[NSString stringWithFormat:@"%@",CreateDate]];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextColor:DEFAUL1COLOR];
        [view1 addSubview:lbl];
        
        UIView *vline=[[UIView alloc]initWithFrame:CGRectMake1(0, 89, 320, 1)];
        [vline setBackgroundColor:DEFAUL3COLOR];
        [view1 addSubview:vline];
        
        UIView *view2=[[UIView alloc]initWithFrame:CGRectMake1(0, 90, 320, 110)];
        [scrollFrame addSubview:view2];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 5, 300, 30)];
        month_salary=[CommonData getValueArray:[CommonData getSalary] Key:month_salary];
        [lbl setText:[NSString stringWithFormat:@"%@",month_salary]];
        [lbl setFont:[UIFont systemFontOfSize:18]];
        [lbl setTextColor:[UIColor orangeColor]];
        [view2 addSubview:lbl];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 35, 300, 20)];
        [lbl setText:[NSString stringWithFormat:@"公司名称:%@",cName]];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextColor:[UIColor blackColor]];
        [view2 addSubview:lbl];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 60, 300, 20)];
        [lbl setText:[NSString stringWithFormat:@"工作地点:%@",address]];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextColor:[UIColor blackColor]];
        [view2 addSubview:lbl];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 85, 300, 20)];
        degree_required=[CommonData getValueArray:[CommonData getEducation] Key:degree_required];
        [lbl setText:[NSString stringWithFormat:@"招聘条件:%@",degree_required]];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextColor:[UIColor blackColor]];
        [view2 addSubview:lbl];
        
        vline=[[UIView alloc]initWithFrame:CGRectMake1(0, 109, 320, 1)];
        [vline setBackgroundColor:DEFAUL3COLOR];
        [view2 addSubview:vline];
        
        UIView *view3=[[UIView alloc]initWithFrame:CGRectMake1(0, 200, 320, 250)];
        [scrollFrame addSubview:view3];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 5, 300, 150)];
        [lbl setText:[NSString stringWithFormat:@"职位描述:%@",job_specification]];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setNumberOfLines:9];
        [lbl sizeToFit];
        [view3 addSubview:lbl];
        
        vline=[[UIView alloc]initWithFrame:CGRectMake1(0, 249, 320, 1)];
        [vline setBackgroundColor:DEFAUL3COLOR];
        [view3 addSubview:vline];
        
        UIView *bottomView=[[UIView alloc]initWithFrame:CGRectMake1(0, 450, 320, 100)];
        [bottomView setBackgroundColor:DEFAUL2COLOR];
        [scrollFrame addSubview:bottomView];
        
        ButtonView *button=[[ButtonView alloc]initWithFrame:CGRectMake1(10, 10, 100, 30) Name:@"申请职位"];
        [button setHidden:YES];
        [button addTarget:self action:@selector(apply:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:button];
        
        if(![@"" isEqualToString:phone]){
            UIButton *call=[[UIButton alloc]initWithFrame:CGRectMake1(270, 10, 40, 30)];
            [call setImage:[UIImage imageNamed:@"call"] forState:UIControlStateNormal];
            [call addTarget:self action:@selector(call:) forControlEvents:UIControlEventTouchUpInside];
            [bottomView addSubview:call];
        }
    }
    return self;
}

- (void)apply:(id)sender
{
    NSLog(@"申请");
}

- (void)call:(id)sender
{
    NSString *phone=[self.data objectForKey:@"phone"];
    if(![@"" isEqualToString:phone]){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[NSString alloc] initWithFormat:@"tel://%@",phone]]];
    }
}

@end
