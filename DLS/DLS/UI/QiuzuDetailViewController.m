//
//  QiuzuDetailViewController.m
//  DLS
//  求租详情
//  Created by Start on 3/9/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "QiuzuDetailViewController.h"
#import "ButtonView.h"
#import "CommonData.h"

@interface QiuzuDetailViewController ()

@end

@implementation QiuzuDetailViewController

- (id)initWithDictionary:(NSDictionary*)data{
    self=[super init];
    if(self){
        self.data=data;
        
        NSString *name=[Common getString:[data objectForKey:@"Name"]];
        NSString *CreateDate=[Common convertTime:[data objectForKey:@"CreateDate"]];
        NSString *startTime=[Common convertTime:[data objectForKey:@"startTime"]];
        NSString *xlValue=[Common convertTime:[data objectForKey:@"xlValue"]];
        NSString *weight=[Common getString:[data objectForKey:@"weight"]];
        NSString *contact=[Common getString:[data objectForKey:@"contact"]];
        NSString *address=[Common getString:[data objectForKey:@"address"]];
        NSString *notes=[Common getString:[data objectForKey:@"notes"]];
        NSString *phone=[Common getString:[data objectForKey:@"contact_phone"]];
//        NSString *location=[data objectForKey:@"location"];
        
        [self setTitle:@"求租详情"];
        
        UIScrollView *scrollFrame=[[UIScrollView alloc]initWithFrame:self.view.bounds];
        [scrollFrame setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [scrollFrame setContentSize:CGSizeMake1(320, 520)];
        [self.view addSubview:scrollFrame];
        
        UIView *view1=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 80)];
        [scrollFrame addSubview:view1];
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 10, 300, 40)];
        [lbl setText:name];
        [lbl setFont:[UIFont systemFontOfSize:18]];
        [lbl setTextColor:[UIColor blackColor]];
        [view1 addSubview:lbl];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 50, 300, 20)];
        [lbl setText:[NSString stringWithFormat:@"发布时间:%@",CreateDate]];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextColor:DEFAUL1COLOR];
        [view1 addSubview:lbl];
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake1(0, 79, 320, 1)];
        [line setBackgroundColor:DEFAUL3COLOR];
        [view1 addSubview:line];
        
        xlValue=[CommonData getValueArray:[CommonData getType2] Key:xlValue];
        NSMutableString *ms=[[NSMutableString alloc]init];
        if([@""isEqualToString:weight]){
            [ms appendString:@"该用户未填此信息"];
        }else{
            NSArray *array=[weight componentsSeparatedByString:@","];
            for(int i=0;i<[array count];i++){
                NSString *wei=[array objectAtIndex:i];
                if(![@"" isEqualToString:wei]){
                    [ms appendFormat:@"%@吨 ",wei];
                }
            }
        }
        if([@""isEqualToString:address]){
            address=@"该用户未填此信息";
        }
        if([@""isEqualToString:contact]){
            contact=@"该用户未填此信息";
        }
        if([@""isEqualToString:phone]){
            phone=@"该用户未填此信息";
        }
        if([@""isEqualToString:notes]){
            notes=@"该用户未填此信息";
        }
        [scrollFrame addSubview:[self addFrameTitle1:@"设备类型" Value1:xlValue Title12:@"吨位" Value2:ms TopX:80]];
        
        [scrollFrame addSubview:[self addFrameTitle1:@"工作地点" Value1:address Title12:@"使用时间" Value2:startTime TopX:150]];
        [scrollFrame addSubview:[self addFrameTitle1:@"联系人" Value1:contact Title12:@"联系方式" Value2:phone TopX:220]];
        //备注
        view1=[[UIView alloc]initWithFrame:CGRectMake1(0, 290, 320, 80)];
        [scrollFrame addSubview:view1];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 0, 300, 30)];
        [lbl setText:@"备     注"];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextColor:DEFAULCOLOR(100)];
        [view1 addSubview:lbl];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 30, 300, 50)];
        [lbl setText:[NSString stringWithFormat:@"%@",notes]];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextColor:DEFAULCOLOR(100)];
        [lbl setNumberOfLines:0];
        [view1 addSubview:lbl];
        line=[[UIView alloc]initWithFrame:CGRectMake1(0, 79, 320, 1)];
        [line setBackgroundColor:DEFAUL3COLOR];
        [view1 addSubview:line];
        //温馨提示
        view1=[[UIView alloc]initWithFrame:CGRectMake1(0, 370, 320, 90)];
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
        
        view1=[[UIView alloc]initWithFrame:CGRectMake1(0, 470, 320, 50)];
        [scrollFrame addSubview:view1];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(0, 0, 120, 50)];
        [lbl setText:[NSString stringWithFormat:@"联系人:%@\n%@",contact,phone]];
        [lbl setTextAlignment:NSTextAlignmentLeft];
        [lbl setTextColor:[UIColor whiteColor]];
        [lbl setBackgroundColor:DEFAULCOLOR(20)];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setNumberOfLines:0];
        [view1 addSubview:lbl];
        UIButton *button2=[[UIButton alloc]initWithFrame:CGRectMake1(120, 0, 99, 50)];
        [button2 setTitle:@"短信" forState:UIControlStateNormal];
        [button2 setImage:[UIImage imageNamed:@"message"] forState:UIControlStateNormal];
        [button2 setBackgroundColor:NAVBG];
        [button2 addTarget:self action:@selector(goSendMessage:) forControlEvents:UIControlEventTouchUpInside];
        [view1 addSubview:button2];
        line=[[UIView alloc]initWithFrame:CGRectMake1(219, 0, 1, 50)];
        [line setBackgroundColor:[UIColor whiteColor]];
        [view1 addSubview:line];
        UIButton *button3=[[UIButton alloc]initWithFrame:CGRectMake1(220, 0, 100, 50)];
        [button3 setTitle:@"电话" forState:UIControlStateNormal];
        [button3 setImage:[UIImage imageNamed:@"call"] forState:UIControlStateNormal];
        [button3 setBackgroundColor:NAVBG];
        [button3 addTarget:self action:@selector(goTell:) forControlEvents:UIControlEventTouchUpInside];
        [view1 addSubview:button3];
    }
    return self;
}

- (UIView*)addFrameTitle1:(NSString*)title1 Value1:(NSString*)value1 Title12:(NSString*)title2 Value2:(NSString*)value2 TopX:(CGFloat)x
{
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake1(0, x, 320, 70)];
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 10, 300, 20)];
    [lbl setText:[NSString stringWithFormat:@"%@: %@",title1,value1]];
    [lbl setFont:[UIFont systemFontOfSize:14]];
    [lbl setTextColor:DEFAULCOLOR(100)];
    [view1 addSubview:lbl];
    lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 40, 300, 20)];
    [lbl setText:[NSString stringWithFormat:@"%@: %@",title2,value2]];
    [lbl setFont:[UIFont systemFontOfSize:14]];
    [lbl setTextColor:DEFAULCOLOR(100)];
    [view1 addSubview:lbl];
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake1(0, 69, 320, 1)];
    [line setBackgroundColor:DEFAUL3COLOR];
    [view1 addSubview:line];
    return view1;
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
