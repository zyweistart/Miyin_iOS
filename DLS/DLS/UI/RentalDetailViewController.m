//
//  RentalDetailViewController.m
//  DLS
//  出租详情
//  Created by Start on 3/9/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "RentalDetailViewController.h"
#import "ButtonView.h"
#import "CommonData.h"

@interface RentalDetailViewController ()

@end

@implementation RentalDetailViewController{
    UIImageView *image1,*image2,*image3,*image4,*image5;
    NSArray *imagelist;
}

- (id)initWithDictionary:(NSDictionary*)data{
    self=[super init];
    if(self){
        self.data=data;
        
        NSString *name=[Common getString:[data objectForKey:@"Name"]];
        NSString *CreateDate=[Common convertTime:[data objectForKey:@"CreateDate"]];
        NSString *weight=[Common getString:[data objectForKey:@"weight"]];
        NSString *contact=[Common getString:[data objectForKey:@"contact"]];
        NSString *address=[Common getString:[data objectForKey:@"address"]];
        NSString *region=[Common getString:[data objectForKey:@"region"]];
        NSString *notes=[Common getString:[data objectForKey:@"notes"]];
        NSString *imageListStr=[Common getString:[data objectForKey:@"imageList"]];
        imagelist=[imageListStr componentsSeparatedByString:@"{-}1{-}#,"];
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
        [lbl setNumberOfLines:0];
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
        [lbl setNumberOfLines:0];
        [mainView addSubview:lbl];
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake1(280, 150, 40, 60)];
        [button setImage:[UIImage imageNamed:@"求租点"] forState:UIControlStateNormal];
        [button setHidden:YES];
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
            region=[CommonData getValueArray:[CommonData getRegion] Key:region];
            [lbl setText:[NSString stringWithFormat:@"%@",region]];
        }
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setTextAlignment:NSTextAlignmentLeft];
        [lbl setNumberOfLines:0];
        [mainView addSubview:lbl];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 270, 100, 60)];
        [lbl setText:@"设备照片"];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextColor:DEFAUL1COLOR];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [mainView addSubview:lbl];
        UIView *imagelistFrame=[[UILabel alloc]initWithFrame:CGRectMake1(120, 270, 200, 60)];
        [mainView addSubview:imagelistFrame];
        for(int i=0;i<[imagelist count];i++){
            if(i==0){
                image1=[[UIImageView alloc]initWithFrame:CGRectMake1(0, 12.5, 35, 35)];
                [image1 setImage:[UIImage imageNamed:@"imageloading"]];
                [imagelistFrame addSubview:image1];
            }else if(i==1){
                image2=[[UIImageView alloc]initWithFrame:CGRectMake1(40, 12.5, 35, 35)];
                [image2 setImage:[UIImage imageNamed:@"imageloading"]];
                [imagelistFrame addSubview:image2];
            }else if(i==2){
                image3=[[UIImageView alloc]initWithFrame:CGRectMake1(80, 12.5, 35, 35)];
                [image3 setImage:[UIImage imageNamed:@"imageloading"]];
                [imagelistFrame addSubview:image3];
            }else if(i==3){
                image4=[[UIImageView alloc]initWithFrame:CGRectMake1(120, 12.5, 35, 35)];
                [image4 setImage:[UIImage imageNamed:@"imageloading"]];
                [imagelistFrame addSubview:image4];
            }else if(i==4){
                image5=[[UIImageView alloc]initWithFrame:CGRectMake1(160, 12.5, 35, 35)];
                [image5 setImage:[UIImage imageNamed:@"imageloading"]];
                [imagelistFrame addSubview:image5];
            }
        }
        
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
        [lbl setNumberOfLines:0];
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
        
        NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
        NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImage) object:nil];
        [operationQueue addOperation:op];
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

- (void)downloadImage
{
    for(int i=0;i<[imagelist count];i++){
        NSString *URL=[NSString stringWithFormat:@"%@%@",HTTP_URL,[imagelist objectAtIndex:i]];
        UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:URL]]];
        if(i==0){
            [image1 setImage:image];
        }else if(i==1){
            [image2 setImage:image];
        }else if(i==2){
            [image3 setImage:image];
        }else if(i==3){
            [image4 setImage:image];
        }else if(i==4){
            [image5 setImage:image];
        }
    }
}

@end
