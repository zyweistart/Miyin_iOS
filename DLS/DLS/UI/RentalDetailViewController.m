//
//  RentalDetailViewController.m
//  DLS
//  出租详情
//  Created by Start on 3/9/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "RentalDetailViewController.h"
#import "ButtonView.h"

@interface RentalDetailViewController ()

@end

@implementation RentalDetailViewController

- (id)initWithDictionary:(NSDictionary*)data{
    self=[super init];
    if(self){
        self.data=data;
        
        NSString *name=[Common getString:[data objectForKey:@"Name"]];
        NSString *CreateDate=[Common getString:[data objectForKey:@"CreateDate"]];
        NSString *weight=[Common getString:[data objectForKey:@"weight"]];
        NSString *contact=[Common getString:[data objectForKey:@"contact"]];
        NSString *address=[Common getString:[data objectForKey:@"address"]];
        NSString *region=[Common getString:[data objectForKey:@"region"]];
        NSString *notes=[Common getString:[data objectForKey:@"notes"]];
//        NSString *location=[data objectForKey:@"location"];
        
        [self setTitle:@"出租详情"];
        
        UIScrollView *scrollFrame=[[UIScrollView alloc]initWithFrame:self.view.bounds];
        [scrollFrame setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [scrollFrame setContentSize:CGSizeMake1(320, 480)];
        [self.view addSubview:scrollFrame];
        
        UIView *topView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 80)];
        [topView setBackgroundColor:DEFAUL3COLOR];
        [scrollFrame addSubview:topView];
        UILabel *lblMainTitle=[[UILabel alloc]initWithFrame:CGRectMake1(10, 10, 300, 40)];
        [lblMainTitle setText:name];
        [lblMainTitle setFont:[UIFont systemFontOfSize:18]];
        [lblMainTitle setTextColor:[UIColor blackColor]];
        [topView addSubview:lblMainTitle];
        UILabel *lblTime=[[UILabel alloc]initWithFrame:CGRectMake1(10, 50, 300, 20)];
        [lblTime setText:[NSString stringWithFormat:@"发布时间:%@",CreateDate]];
        [lblTime setFont:[UIFont systemFontOfSize:14]];
        [lblTime setTextColor:DEFAUL1COLOR];
        [topView addSubview:lblTime];
        
        UIView *mainView=[[UIView alloc]initWithFrame:CGRectMake1(0, 80, 320, 400)];
        [mainView setBackgroundColor:[UIColor whiteColor]];
        [scrollFrame addSubview:mainView];
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 10, 300, 20)];
        [lbl setText:[NSString stringWithFormat:@"联系人:%@",contact]];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextColor:DEFAUL1COLOR];
        [mainView addSubview:lbl];
        ButtonView *buttonView1=[[ButtonView alloc]initWithFrame:CGRectMake1(10, 40, 145, 40) Name:@"电话联系" Type:1];
        [buttonView1 addTarget:self action:@selector(goTell:) forControlEvents:UIControlEventTouchUpInside];
        [mainView addSubview:buttonView1];
        ButtonView *buttonView2=[[ButtonView alloc]initWithFrame:CGRectMake1(165, 40, 145, 40) Name:@"发送短信" Type:2];
        [buttonView2 addTarget:self action:@selector(goSendMessage:) forControlEvents:UIControlEventTouchUpInside];
        [mainView addSubview:buttonView2];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 90, 100, 60)];
        [lbl setText:@"拥有设备类型"];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextColor:DEFAUL1COLOR];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [mainView addSubview:lbl];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(120, 90, 150, 60)];
        if([@""isEqualToString:weight]){
            [lbl setText:@"该用户未填此信息"];
        }else{
            NSMutableString *ms=[[NSMutableString alloc]init];
            NSArray *array=[weight componentsSeparatedByString:@","];
            for(int i=0;i<[array count];i++){
                NSString *wei=[array objectAtIndex:i];
                if(![@"" isEqualToString:wei]){
                    [ms appendFormat:@"%@吨 ",wei];
                }
            }
            [lbl setText:ms];
        }
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setTextAlignment:NSTextAlignmentLeft];
        [mainView addSubview:lbl];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 150, 100, 60)];
        [lbl setText:@"设备所在地"];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextColor:DEFAUL1COLOR];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [mainView addSubview:lbl];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(120, 150, 150, 60)];
        if([@""isEqualToString:address]){
            [lbl setText:@"该用户未填此信息"];
        }else{
            [lbl setText:address];
        }
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setTextAlignment:NSTextAlignmentLeft];
        [mainView addSubview:lbl];
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake1(280, 150, 40, 60)];
        [button setImage:[UIImage imageNamed:@"求租点"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(goLocation:) forControlEvents:UIControlEventTouchUpInside];
        [mainView addSubview:button];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 210, 100, 60)];
        [lbl setText:@"使用范围"];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextColor:DEFAUL1COLOR];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [mainView addSubview:lbl];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(120, 210, 150, 60)];
        if([@""isEqualToString:region]){
            [lbl setText:@"该用户未填此信息"];
        }else{
            [lbl setText:[NSString stringWithFormat:@"%@",region]];
        }
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setTextAlignment:NSTextAlignmentLeft];
        [mainView addSubview:lbl];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 270, 100, 60)];
        [lbl setText:@"设备照片"];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextColor:DEFAUL1COLOR];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [mainView addSubview:lbl];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(120, 270, 150, 60)];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setTextAlignment:NSTextAlignmentLeft];
        [mainView addSubview:lbl];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 330, 100, 60)];
        [lbl setText:@"其他描述"];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextColor:DEFAUL1COLOR];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [mainView addSubview:lbl];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(120, 330, 150, 60)];
        if([@""isEqualToString:notes]){
            [lbl setText:@"该用户未填此信息"];
        }else{
            [lbl setText:notes];
        }
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setTextAlignment:NSTextAlignmentLeft];
        [mainView addSubview:lbl];
        
        UIView *vline=[[UIView alloc]initWithFrame:CGRectMake1(110, 90, 1, 300)];
        [vline setBackgroundColor:DEFAUL2COLOR];
        [mainView addSubview:vline];
        vline=[[UIView alloc]initWithFrame:CGRectMake1(0, 90, 320, 1)];
        [vline setBackgroundColor:DEFAUL2COLOR];
        [mainView addSubview:vline];
        vline=[[UIView alloc]initWithFrame:CGRectMake1(0, 150, 320, 1)];
        [vline setBackgroundColor:DEFAUL2COLOR];
        [mainView addSubview:vline];
        vline=[[UIView alloc]initWithFrame:CGRectMake1(0, 210, 320, 1)];
        [vline setBackgroundColor:DEFAUL2COLOR];
        [mainView addSubview:vline];
        vline=[[UIView alloc]initWithFrame:CGRectMake1(0, 270, 320, 1)];
        [vline setBackgroundColor:DEFAUL2COLOR];
        [mainView addSubview:vline];
        vline=[[UIView alloc]initWithFrame:CGRectMake1(0, 330, 320, 1)];
        [vline setBackgroundColor:DEFAUL2COLOR];
        [mainView addSubview:vline];
        vline=[[UIView alloc]initWithFrame:CGRectMake1(0, 390, 320, 1)];
        [vline setBackgroundColor:DEFAUL2COLOR];
        [mainView addSubview:vline];
        
    }
    return self;
}

- (void)goTell:(id)sender
{
    NSString *phone=[self.data objectForKey:@"contact_phone"];
    if(![@"" isEqualToString:phone]){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[NSString alloc] initWithFormat:@"tel://%@",phone]]];
    }
}

- (void)goSendMessage:(id)sender
{
    NSString *phone=[self.data objectForKey:@"contact_phone"];
    if(![@"" isEqualToString:phone]){
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"sms://%@",phone]]];
    }
}

- (void)goLocation:(id)sender
{
    NSLog(@"location");
}

@end
