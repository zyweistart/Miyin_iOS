//
//  ElectricityTariffViewController.m
//  eClient
//  电量电费
//  Created by Start on 4/8/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "ElectricityTariffViewController.h"
#import "STElectricityListViewController.h"

#define BGCOLOR [UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1]

@interface ElectricityTariffViewController ()

@end

@implementation ElectricityTariffViewController{
    UILabel *lblHead1,*lblHead2;
    UILabel *lblDetailA1,*lblDetailA2,*lblDetailA3,*lblDetailA4;
    UILabel *lblDetailAK1,*lblDetailAK2,*lblDetailAK3,*lblDetailAK4;
    UILabel *lblDetailB1,*lblDetailB2,*lblDetailB3,*lblDetailB4;
    UILabel *lblDetailBK1,*lblDetailBK2,*lblDetailBK3,*lblDetailBK4;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.title=@"电量电费";
        [self.view setBackgroundColor:BGCOLOR];
        
//        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"ichartjs.bundle/ChartElectricityTariff.html"];
        
        UIScrollView *frame=[[UIScrollView alloc]initWithFrame:self.view.bounds];
        [frame setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [frame setContentSize:CGSizeMake1(320, 560)];
        [frame setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:frame];
        
        lblHead1=[self addHead:frame X:0 Title:@"昨日电量" Tag:1];
        lblDetailAK1=[[UILabel alloc]init];
        lblDetailA1=[self addDetail:frame X:40 Title:@"尖峰电量" Lbl1:lblDetailAK1];
        lblDetailAK2=[[UILabel alloc]init];
        lblDetailA2=[self addDetail:frame X:100 Title:@"高峰电量" Lbl1:lblDetailAK2];
        lblDetailAK3=[[UILabel alloc]init];
        lblDetailA3=[self addDetail:frame X:160 Title:@"低谷电量" Lbl1:lblDetailAK3];
        lblDetailAK4=[[UILabel alloc]init];
        lblDetailA4=[self addDetail:frame X:220 Title:@"累计电量" Lbl1:lblDetailAK4];
        
//        UIWebView *webView1 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 170, 320, 250)];
//        [webView1 setUserInteractionEnabled:YES];
//        [webView1 setScalesPageToFit:YES];
//        [webView1 setBackgroundColor:[UIColor clearColor]];
//        [webView1 setOpaque:NO];//使网页透明
//        [webView1 setDelegate:self];
//        [frame addSubview:webView1];
//        [webView1 loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath: path]]];
        
        lblHead2=[self addHead:frame X:280 Title:@"当月电量" Tag:2];
        lblDetailBK1=[[UILabel alloc]init];
        lblDetailB1=[self addDetail:frame X:320 Title:@"尖峰电量" Lbl1:lblDetailBK1];
        lblDetailBK2=[[UILabel alloc]init];
        lblDetailB2=[self addDetail:frame X:380 Title:@"高峰电量" Lbl1:lblDetailBK2];
        lblDetailBK3=[[UILabel alloc]init];
        lblDetailB3=[self addDetail:frame X:440 Title:@"低谷电量" Lbl1:lblDetailBK3];
        lblDetailBK4=[[UILabel alloc]init];
        lblDetailB4=[self addDetail:frame X:500 Title:@"累计电量" Lbl1:lblDetailBK4];
        
//        UIWebView *webView2 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 620, 320, 250)];
//        [webView2 setUserInteractionEnabled:YES];
//        [webView2 setScalesPageToFit:YES];
//        [webView2 setBackgroundColor:[UIColor clearColor]];
//        [webView2 setOpaque:NO];//使网页透明
//        [webView2 setDelegate:self];
//        [frame addSubview:webView2];
//        [webView2 loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath: path]]];
        
        [self get:0];
        [self get:1];
    }
    return self;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
//    [self performSelector:@selector(loadHttp) withObject:nil afterDelay:0.5];
}

- (UILabel *)addHead:(UIView *)frame X:(CGFloat)x Title:(NSString*)title Tag:(int)tag
{
    UIView *head=[[UIView alloc]initWithFrame:CGRectMake1(0, x, 320, 40)];
    [head setBackgroundColor:BGCOLOR];
    [frame addSubview:head];
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 0, 100, 40)];
    [lbl setFont:[UIFont systemFontOfSize:15]];
    [lbl setText:title];
    [lbl setTextAlignment:NSTextAlignmentLeft];
    [lbl setTextColor:[UIColor blackColor]];
    [head addSubview:lbl];
    UILabel *lblTotal=[[UILabel alloc]initWithFrame:CGRectMake1(130, 0, 90, 40)];
    [lblTotal setFont:[UIFont systemFontOfSize:14]];
    [lblTotal setText:@"0"];
    [lblTotal setTextAlignment:NSTextAlignmentCenter];
    [lblTotal setTextColor:[UIColor orangeColor]];
    [head addSubview:lblTotal];
    UIButton *bStatus=[[UIButton alloc]initWithFrame:CGRectMake1(240, 0, 70, 40)];
    bStatus.tag=tag;
    [bStatus addTarget:self action:@selector(detail:) forControlEvents:UIControlEventTouchUpInside];
    [bStatus.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [bStatus setTitle:@"详细电费>" forState:UIControlStateNormal];
    [bStatus setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [head addSubview:bStatus];
    return lblTotal;
}

- (UILabel *)addDetail:(UIView *)frame X:(CGFloat)x Title:(NSString*)title Lbl1:(UILabel*)lbl1
{
    UIView *head=[[UIView alloc]initWithFrame:CGRectMake1(0, x, 320, 60)];
    [frame addSubview:head];
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 0, 100, 60)];
    [lbl setFont:[UIFont systemFontOfSize:15]];
    [lbl setText:title];
    [lbl setTextAlignment:NSTextAlignmentLeft];
    [lbl setTextColor:[UIColor blackColor]];
    [head addSubview:lbl];
    UILabel *lblMoney=[[UILabel alloc]initWithFrame:CGRectMake1(210, 0, 100, 30)];
    [lblMoney setFont:[UIFont systemFontOfSize:15]];
    [lblMoney setText:@"0.00元"];
    [lblMoney setTextAlignment:NSTextAlignmentRight];
    [lblMoney setTextColor:[UIColor blackColor]];
    [head addSubview:lblMoney];
//    lbl1=[[UILabel alloc]initWithFrame:];
    [lbl1 setFrame:CGRectMake1(210, 30, 100, 30)];
    [lbl1 setFont:[UIFont systemFontOfSize:15]];
    [lbl1 setText:@"0.00元"];
    [lbl1 setTextAlignment:NSTextAlignmentRight];
    [lbl1 setTextColor:[UIColor blackColor]];
    [head addSubview:lbl1];
    return lblMoney;
}

- (void)detail:(UIButton*)sender
{
    if(sender.tag==1){
        [self.navigationController pushViewController:[[STElectricityListViewController alloc]initWithSelectType:0] animated:YES];
    }else if(sender.tag==2){
        [self.navigationController pushViewController:[[STElectricityListViewController alloc]initWithSelectType:1] animated:YES];
    }
}

- (void)get:(int)type
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[[User Instance] getCPNameId] forKey:@"CP_ID"];
    [params setObject:type==0?@"Day":@"Month" forKey:@"SelectType"];
    self.hRequest=[[HttpRequest alloc]init];
    if(type==0){
        [self.hRequest setRequestCode:500];
    }else{
        [self.hRequest setRequestCode:501];
    }
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest handle:URL_AppComElec requestParams:params];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if(reqCode==500){
        NSArray *ComElec=[[response resultJSON]objectForKey:@"ComElec"];
        if([ComElec count]>0){
            NSDictionary *data=[ComElec objectAtIndex:0];
            [lblHead1 setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"AvgPrice"]]];
            [lblDetailA1 setText:[data objectForKey:@"TipFee"]];
            [lblDetailAK1 setText:[data objectForKey:@"TipPower"]];
            [lblDetailA2 setText:[data objectForKey:@"PeakFee"]];
            [lblDetailAK2 setText:[data objectForKey:@"PeakPower"]];
            [lblDetailA3 setText:[data objectForKey:@"ValleyFee"]];
            [lblDetailAK3 setText:[data objectForKey:@"ValleyPower"]];
            [lblDetailA4 setText:[data objectForKey:@"TotalFee"]];
            [lblDetailAK4 setText:[data objectForKey:@"TotalPower"]];
        }
    }else if(reqCode==501){
        NSArray *ComElec=[[response resultJSON]objectForKey:@"ComElec"];
        if([ComElec count]>0){
            NSDictionary *data=[ComElec objectAtIndex:0];
            [lblHead2 setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"AvgPrice"]]];
            [lblDetailB1 setText:[data objectForKey:@"TipFee"]];
            [lblDetailBK1 setText:[data objectForKey:@"TipPower"]];
            [lblDetailB2 setText:[data objectForKey:@"PeakFee"]];
            [lblDetailBK2 setText:[data objectForKey:@"PeakPower"]];
            [lblDetailB3 setText:[data objectForKey:@"ValleyFee"]];
            [lblDetailBK3 setText:[data objectForKey:@"ValleyPower"]];
            [lblDetailB4 setText:[data objectForKey:@"TotalFee"]];
            [lblDetailBK4 setText:[data objectForKey:@"TotalPower"]];
        }
    }
}

@end
