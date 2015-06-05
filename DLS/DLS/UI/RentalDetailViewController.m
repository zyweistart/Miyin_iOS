//
//  RentalDetailViewController.m
//  DLS
//  出租详情
//  Created by Start on 3/9/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "RentalDetailViewController.h"
#import "PublishRentalViewController.h"
#import "MapViewController.h"
#import "ButtonView.h"
#import "CommonData.h"

@interface RentalDetailViewController ()

@end

@implementation RentalDetailViewController{
    UIImageView *image1,*image2,*image3,*image4,*image5;
    NSArray *imagelist;
}

- (id)initWithDictionary:(NSDictionary*)data Edit:(BOOL)edit
{
    self =[self initWithDictionary:data];
    if(self){
        if(edit){
            //
            UIButton *bEdit = [UIButton buttonWithType:UIButtonTypeCustom];
            [bEdit setTitle:@"编辑" forState:UIControlStateNormal];
            [bEdit.titleLabel setFont:[UIFont systemFontOfSize:15]];
            [bEdit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [bEdit addTarget:self action:@selector(goEdit:) forControlEvents:UIControlEventTouchUpInside];
            bEdit.frame = CGRectMake(0, 0, 30, 30);
            self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:bEdit];
        }
    }
    return self;
}


- (id)initWithDictionary:(NSDictionary*)data{
    [self.tabBarController setHidesBottomBarWhenPushed:YES];
    self=[super init];
    if(self){
        self.data=data;
        NSString *name=[Common getString:[data objectForKey:@"Name"]];
        NSString *CreateDate=[Common convertTime:[data objectForKey:@"CreateDate"]];
        NSString *xlValue=[Common getString:[data objectForKey:@"xlValue"]];
        NSString *weight=[Common getString:[data objectForKey:@"weight"]];
        NSString *contact=[Common getString:[data objectForKey:@"contact"]];
        NSString *address=[Common getString:[data objectForKey:@"address"]];
        NSString *region=[Common getString:[data objectForKey:@"region"]];
        NSString *phone=[self.data objectForKey:@"contact_phone"];
        NSString *notes=[Common getString:[data objectForKey:@"notes"]];
        NSString *imageListStr=[Common getString:[data objectForKey:@"imageList"]];
        imagelist=[imageListStr componentsSeparatedByString:@"{-}1{-}#,"];
//        NSString *location=[data objectForKey:@"location"];
        
        [self setTitle:@"出租详情"];
        //收藏
        UIButton *bCollection = [UIButton buttonWithType:UIButtonTypeCustom];
        [bCollection setBackgroundImage:[UIImage imageNamed:@"collection"]forState:UIControlStateNormal];
        [bCollection addTarget:self action:@selector(gobCollection:) forControlEvents:UIControlEventTouchUpInside];
        bCollection.frame = CGRectMake(0, 0, 20, 20);
        UIBarButtonItem *negativeSpacerRight = [[UIBarButtonItem alloc]
                                                initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                target:nil action:nil];
        negativeSpacerRight.width = -5;
        if([[User Instance]isLogin]){
            self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacerRight, [[UIBarButtonItem alloc] initWithCustomView:bCollection], nil];
        }
        
        UIScrollView *scrollFrame=[[UIScrollView alloc]initWithFrame:self.view.bounds];
        [scrollFrame setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [scrollFrame setContentSize:CGSizeMake1(320, 620)];
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
        if([@""isEqualToString:region]){
            region=@"该用户未填此信息";
        }else{
            region=[CommonData getValueArray:[CommonData getRegion] Key:region];
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
        
        [scrollFrame addSubview:[self addFrameTitle1:@"设备地址" Value1:address Title12:@"使用范围" Value2:region TopX:150]];
        [scrollFrame addSubview:[self addFrameTitle1:@"联系人" Value1:contact Title12:@"联系方式" Value2:phone TopX:220]];
        //备注
        view1=[[UIView alloc]initWithFrame:CGRectMake1(0, 290, 320, 80)];
        [scrollFrame addSubview:view1];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 0, 300, 30)];
        [lbl setText:@"备     注"];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextColor:DEFAULCOLOR(100)];
        [view1 addSubview:lbl];
        UITextView *tv=[[UITextView alloc]initWithFrame:CGRectMake1(10, 30, 300, 50)];
        [tv setEditable:NO];
        [tv setText:[NSString stringWithFormat:@"%@",notes]];
        [tv setFont:[UIFont systemFontOfSize:14]];
        [tv setTextColor:DEFAULCOLOR(100)];
        [view1 addSubview:tv];
//        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 30, 300, 50)];
//        [lbl setText:[NSString stringWithFormat:@"%@",notes]];
//        [lbl setFont:[UIFont systemFontOfSize:14]];
//        [lbl setTextColor:DEFAULCOLOR(100)];
//        [lbl setNumberOfLines:0];
//        [view1 addSubview:lbl];
        line=[[UIView alloc]initWithFrame:CGRectMake1(0, 79, 320, 1)];
        [line setBackgroundColor:DEFAUL3COLOR];
        [view1 addSubview:line];
        //照片
        view1=[[UIView alloc]initWithFrame:CGRectMake1(0, 370, 320, 100)];
        [scrollFrame addSubview:view1];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 0, 300, 30)];
        [lbl setText:@"照     片"];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextColor:DEFAULCOLOR(100)];
        [view1 addSubview:lbl];
        UIView *imagelistFrame=[[UILabel alloc]initWithFrame:CGRectMake1(0, 30, 320, 60)];
        [view1 addSubview:imagelistFrame];
        for(int i=0;i<[imagelist count];i++){
            if(i==0){
                image1=[[UIImageView alloc]initWithFrame:CGRectMake1(2, 0, 60, 60)];
                [image1 setImage:[UIImage imageNamed:@"imageloading"]];
                [imagelistFrame addSubview:image1];
            }else if(i==1){
                image2=[[UIImageView alloc]initWithFrame:CGRectMake1(64, 0, 60, 60)];
                [image2 setImage:[UIImage imageNamed:@"imageloading"]];
                [imagelistFrame addSubview:image2];
            }else if(i==2){
                image3=[[UIImageView alloc]initWithFrame:CGRectMake1(126, 0, 60, 60)];
                [image3 setImage:[UIImage imageNamed:@"imageloading"]];
                [imagelistFrame addSubview:image3];
            }else if(i==3){
                image4=[[UIImageView alloc]initWithFrame:CGRectMake1(188, 0, 60, 60)];
                [image4 setImage:[UIImage imageNamed:@"imageloading"]];
                [imagelistFrame addSubview:image4];
            }else if(i==4){
                image5=[[UIImageView alloc]initWithFrame:CGRectMake1(250, 0, 60, 60)];
                [image5 setImage:[UIImage imageNamed:@"imageloading"]];
                [imagelistFrame addSubview:image5];
            }
        }
        line=[[UIView alloc]initWithFrame:CGRectMake1(0, 99, 320, 1)];
        [line setBackgroundColor:DEFAUL3COLOR];
        [view1 addSubview:line];
        //温馨提示
        view1=[[UIView alloc]initWithFrame:CGRectMake1(0, 470, 320, 90)];
        [scrollFrame addSubview:view1];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(5, 0, 310, 30)];
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
        
        view1=[[UIView alloc]initWithFrame:CGRectMake1(0, 570, 320, 50)];
        [scrollFrame addSubview:view1];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(0, 0, 120, 50)];
        [lbl setText:[NSString stringWithFormat:@"联系人:%@\n%@",contact,phone]];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [lbl setTextColor:[UIColor whiteColor]];
        [lbl setBackgroundColor:DEFAULCOLOR(20)];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setNumberOfLines:0];
        [view1 addSubview:lbl];
        UIButton *button2=[[UIButton alloc]initWithFrame:CGRectMake1(120, 0, 99, 50)];
        [button2 setTitle:@"短信" forState:UIControlStateNormal];
        [button2 setImage:[UIImage imageNamed:@"message"] forState:UIControlStateNormal];
        [button2 setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
        [button2 setBackgroundColor:NAVBG];
        [button2 addTarget:self action:@selector(goSendMessage:) forControlEvents:UIControlEventTouchUpInside];
        [view1 addSubview:button2];
        line=[[UIView alloc]initWithFrame:CGRectMake1(219, 0, 1, 50)];
        [line setBackgroundColor:[UIColor whiteColor]];
        [view1 addSubview:line];
        UIButton *button3=[[UIButton alloc]initWithFrame:CGRectMake1(220, 0, 100, 50)];
        [button3 setTitle:@"电话" forState:UIControlStateNormal];
        [button3 setImage:[UIImage imageNamed:@"call"] forState:UIControlStateNormal];
        [button3 setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
        [button3 setBackgroundColor:NAVBG];
        [button3 addTarget:self action:@selector(goTell:) forControlEvents:UIControlEventTouchUpInside];
        [view1 addSubview:button3];
        
        NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
        NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImage) object:nil];
        [operationQueue addOperation:op];
    }
    return self;
}

- (UIView*)addFrameTitle1:(NSString*)title1 Value1:(NSString*)value1 Title12:(NSString*)title2 Value2:(NSString*)value2 TopX:(CGFloat)x
{
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake1(0, x, 320, 70)];
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 10, 300, 20)];
    [lbl setText:[NSString stringWithFormat:@"%@:%@",title1,value1]];
    [lbl setFont:[UIFont systemFontOfSize:14]];
    [lbl setTextColor:DEFAULCOLOR(100)];
    [view1 addSubview:lbl];
    if([@"设备地址" isEqualToString:title1]){
        NSString *location=[Common getString:[self.data objectForKey:@"location"]];
        if(![@"" isEqualToString:location]){
            UIButton *location=[[UIButton alloc]initWithFrame:CGRectMake1(280, 10, 40, 20)];
            [location setTitle:@"地图" forState:UIControlStateNormal];
            [location.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [location setTitleColor:NAVBG forState:UIControlStateNormal];
            [location addTarget:self action:@selector(goLocation:) forControlEvents:UIControlEventTouchUpInside];
            [view1 addSubview:location];
        }
    }
    lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 40, 300, 20)];
    [lbl setText:[NSString stringWithFormat:@"%@:%@",title2,value2]];
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
    [self.navigationController pushViewController:[[MapViewController alloc]initWithDictionary:self.data] animated:YES];
}

- (void)downloadImage
{
    for(int i=0;i<[imagelist count];i++){
        NSString *URL=[NSString stringWithFormat:@"%@%@",HTTP_URL,[imagelist objectAtIndex:i]];
        if(i==0){
            [Common AsynchronousDownloadImageWithUrl:URL ShowImageView:image1];
        }else if(i==1){
            [Common AsynchronousDownloadImageWithUrl:URL ShowImageView:image2];
        }else if(i==2){
            [Common AsynchronousDownloadImageWithUrl:URL ShowImageView:image3];
        }else if(i==3){
            [Common AsynchronousDownloadImageWithUrl:URL ShowImageView:image4];
        }else if(i==4){
            [Common AsynchronousDownloadImageWithUrl:URL ShowImageView:image5];
        }
    }
}

- (void)goEdit:(id)sender
{
    [self.navigationController pushViewController:[[PublishRentalViewController alloc]initWithData:self.data] animated:YES];
}

- (void)gobCollection:(id)sender
{NSString *title=[self.data objectForKey:@"Name"];
    NSString *url=[NSString stringWithFormat:@"%@%@",HTTP_URL,[self.data objectForKey:@"url"]];
    NSString *notes=[self.data objectForKey:@"notes"];
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
