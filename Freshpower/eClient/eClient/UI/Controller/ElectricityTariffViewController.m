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
    UILabel *lblDetailB1,*lblDetailB2,*lblDetailB3,*lblDetailB4;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.title=@"电量电费";
        [self.view setBackgroundColor:BGCOLOR];
        
        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"ichartjs.bundle/ChartElectricityTariff.html"];
        
        UIScrollView *frame=[[UIScrollView alloc]initWithFrame:self.view.bounds];
        [frame setContentSize:CGSizeMake1(320, 870)];
        [frame setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:frame];
        
        lblHead1=[self addHead:frame X:0 Title:@"昨日电量" Tag:1];
        lblDetailA1=[self addDetail:frame X:40 Title:@"尖峰电量"];
        lblDetailA2=[self addDetail:frame X:70 Title:@"高峰电量"];
        lblDetailA3=[self addDetail:frame X:100 Title:@"低谷电量"];
        lblDetailA4=[self addDetail:frame X:130 Title:@"累计电量"];
        
        UIWebView *webView1 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 170, 320, 250)];
        [webView1 setUserInteractionEnabled:YES];
        [webView1 setScalesPageToFit:YES];
        [webView1 setBackgroundColor:[UIColor clearColor]];
        [webView1 setOpaque:NO];//使网页透明
        [webView1 setDelegate:self];
        [frame addSubview:webView1];
        [webView1 loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath: path]]];
        
        lblHead2=[self addHead:frame X:420 Title:@"当月电量" Tag:2];
        lblDetailB1=[self addDetail:frame X:460 Title:@"尖峰电量"];
        lblDetailB2=[self addDetail:frame X:500 Title:@"高峰电量"];
        lblDetailB3=[self addDetail:frame X:540 Title:@"低谷电量"];
        lblDetailB4=[self addDetail:frame X:580 Title:@"累计电量"];
        
        UIWebView *webView2 = [[UIWebView alloc] initWithFrame:CGRectMake(0, 620, 320, 250)];
        [webView2 setUserInteractionEnabled:YES];
        [webView2 setScalesPageToFit:YES];
        [webView2 setBackgroundColor:[UIColor clearColor]];
        [webView2 setOpaque:NO];//使网页透明
        [webView2 setDelegate:self];
        [frame addSubview:webView2];
        [webView2 loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath: path]]];
        
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

- (UILabel *)addDetail:(UIView *)frame X:(CGFloat)x Title:(NSString*)title
{
    UIView *head=[[UIView alloc]initWithFrame:CGRectMake1(0, x, 320, 30)];
    [frame addSubview:head];
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 0, 100, 30)];
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
    NSLog(@"%@",[response responseString]);
    if(reqCode==500){
        NSArray *ComElec=[[response resultJSON]objectForKey:@"ComElec"];
        if([ComElec count]>0){
            NSDictionary *data=[ComElec objectAtIndex:0];
            [lblHead1 setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"AvgPrice"]]];
            [lblDetailA1 setText:[data objectForKey:@"TipFee"]];
            [lblDetailA2 setText:[data objectForKey:@"PeakFee"]];
            [lblDetailA3 setText:[data objectForKey:@"ValleyFee"]];
            [lblDetailA4 setText:[data objectForKey:@"TotalFee"]];
        }
    }else if(reqCode==501){
        NSArray *ComElec=[[response resultJSON]objectForKey:@"ComElec"];
        if([ComElec count]>0){
            NSDictionary *data=[ComElec objectAtIndex:0];
            [lblHead2 setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"AvgPrice"]]];
            [lblDetailB1 setText:[data objectForKey:@"TipFee"]];
            [lblDetailB2 setText:[data objectForKey:@"PeakFee"]];
            [lblDetailB3 setText:[data objectForKey:@"ValleyFee"]];
            [lblDetailB4 setText:[data objectForKey:@"TotalFee"]];
        }
    }
}

@end
