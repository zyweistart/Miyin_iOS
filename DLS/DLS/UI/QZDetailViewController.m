//
//  QZDetailViewController.m
//  DLS
//
//  Created by Start on 5/19/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "QZDetailViewController.h"
#import "CommonData.h"
#import "ButtonView.h"

@interface QZDetailViewController ()

@end

@implementation QZDetailViewController

- (id)initWithDictionary:(NSDictionary*)data{
    self=[super init];
    if(self){
        self.data=data;
        NSString *job_title=[Common getString:[data objectForKey:@"title"]];
        NSString *job_category=[Common getString:[data objectForKey:@"job_category"]];
        NSString *CreateDate=[Common convertTime:[data objectForKey:@"CreateDate"]];
        //联系人
        NSString *contact=[Common getString:[data objectForKey:@"contact"]];
        //联系方式
        NSString *phone=[Common getString:[data objectForKey:@"phone"]];
        //性别
        NSString *sex=[Common getString:[data objectForKey:@"sex"]];
        //年龄
        NSString *age=[Common getString:[data objectForKey:@"age"]];
        //工作地点
        NSString *address=[Common getString:[data objectForKey:@"address"]];
        //工作经验
        NSString *experience=[Common getString:[data objectForKey:@"experience"]];
        //自我描述
        NSString *content=[Common getString:[data objectForKey:@"content"]];
        
        [self setTitle:@"求职信息"];
        //收藏
        UIButton *bCollection = [UIButton buttonWithType:UIButtonTypeCustom];
        [bCollection setBackgroundImage:[UIImage imageNamed:@"collection"]forState:UIControlStateNormal];
        [bCollection addTarget:self action:@selector(gobCollection:) forControlEvents:UIControlEventTouchUpInside];
        bCollection.frame = CGRectMake(0, 0, 20, 20);
        UIBarButtonItem *negativeSpacerRight = [[UIBarButtonItem alloc]
                                                initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                target:nil action:nil];
        negativeSpacerRight.width = -5;
        self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacerRight, [[UIBarButtonItem alloc] initWithCustomView:bCollection], nil];
        
        UIScrollView *scrollFrame=[[UIScrollView alloc]initWithFrame:self.view.bounds];
        [scrollFrame setContentSize:CGSizeMake1(320, 600)];
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
        
        UIView *view2=[[UIView alloc]initWithFrame:CGRectMake1(0, 90, 320, 160)];
        [scrollFrame addSubview:view2];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 5, 300, 30)];
        [lbl setText:[NSString stringWithFormat:@"联系人:%@",contact]];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextColor:[UIColor blackColor]];
        [view2 addSubview:lbl];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 35, 300, 20)];
        [lbl setText:[NSString stringWithFormat:@"联系方式:%@",phone]];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextColor:[UIColor blackColor]];
        [view2 addSubview:lbl];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 60, 300, 20)];
        sex=[CommonData getValueArray:[CommonData getSex] Key:sex];
        [lbl setText:[NSString stringWithFormat:@"性别:%@",sex]];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextColor:[UIColor blackColor]];
        [view2 addSubview:lbl];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 85, 300, 20)];
        [lbl setText:[NSString stringWithFormat:@"年龄:%@",age]];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextColor:[UIColor blackColor]];
        [view2 addSubview:lbl];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 110, 300, 20)];
        [lbl setText:[NSString stringWithFormat:@"工作地点:%@",address]];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextColor:[UIColor blackColor]];
        [view2 addSubview:lbl];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 135, 300, 20)];
        [lbl setText:[NSString stringWithFormat:@"工作经验:%@",experience]];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextColor:[UIColor blackColor]];
        [view2 addSubview:lbl];
        
        vline=[[UIView alloc]initWithFrame:CGRectMake1(0, 159, 320, 1)];
        [vline setBackgroundColor:DEFAUL3COLOR];
        [view2 addSubview:vline];
        
        UIView *view3=[[UIView alloc]initWithFrame:CGRectMake1(0, 250, 320, 200)];
        [scrollFrame addSubview:view3];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 5, 300, 150)];
        [lbl setText:[NSString stringWithFormat:@"自我描述:%@",content]];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setNumberOfLines:0];
        [lbl sizeToFit];
        [view3 addSubview:lbl];
        
        vline=[[UIView alloc]initWithFrame:CGRectMake1(0, 199, 320, 1)];
        [vline setBackgroundColor:DEFAUL3COLOR];
        [view3 addSubview:vline];
        
        //温馨提示
        view1=[[UIView alloc]initWithFrame:CGRectMake1(0, 450, 320, 90)];
        [scrollFrame addSubview:view1];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 0, 300, 30)];
        [lbl setText:@"温馨提示"];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [lbl setTextColor:NAVBG];
        [view1 addSubview:lbl];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(5, 30, 310, 60)];
        [lbl setText:@"1、此信息由客户自行发布，得力手仅提供信息展示功能。\n2、信息内容由发布者负责，如有疑问请及时与得力手后台联系。"];
        [lbl setFont:[UIFont systemFontOfSize:12]];
        [lbl setTextColor:DEFAULCOLOR(100)];
        [lbl setNumberOfLines:0];
        [lbl setTextAlignment:NSTextAlignmentLeft];
        [view1 addSubview:lbl];
        
        
        UIView *bottomView=[[UIView alloc]initWithFrame:CGRectMake1(0, 550, 320, 50)];
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

- (void)gobCollection:(id)sender
{
    NSString *title=[self.data objectForKey:@"title"];
    NSString *url=[NSString stringWithFormat:@"%@%@",HTTP_URL,[self.data objectForKey:@"url"]];
    NSString *notes=[self.data objectForKey:@"content"];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[[User Instance]accessToken] forKey:@"access_token"];
    [params setObject:url forKey:@"links"];
    [params setObject:title forKey:@"title"];
    [params setObject:notes forKey:@"Introduction"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:501];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest handle:@"FocusOrCollection" requestParams:params];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if([response successFlag]){
        if(reqCode==501){
            [Common alert:@"收藏成功"];
        }
    }
}

@end
