//
//  STDataMonitoringLineDetailViewController.m
//  ElectricianRun
//  数据监测-线路-详细
//  Created by Start on 1/25/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STDataMonitoringLineDetailViewController.h"
#import "STDataMonitoringLineDetailSearchViewController.h"
#import "STDataMonitoringLineDetailListViewController.h"

@interface STDataMonitoringLineDetailViewController ()

@end

@implementation STDataMonitoringLineDetailViewController

- (id)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        self.data=data;
        
        UIControl *control=[[UIControl alloc]initWithFrame:CGRectMake(0, 80, 320, 340)];
        
        UIButton *btnHistory1=[[UIButton alloc]initWithFrame:CGRectMake(10, 5, 145, 30)];
        btnHistory1.titleLabel.font=[UIFont systemFontOfSize:12];
        [btnHistory1 setTitle:@"历史耗量" forState:UIControlStateNormal];
        [btnHistory1 setBackgroundColor:BTNCOLORGB];
        [btnHistory1 addTarget:self action:@selector(history1:) forControlEvents:UIControlEventTouchUpInside];
        [control addSubview:btnHistory1];
        
        UIButton *btnHistory2=[[UIButton alloc]initWithFrame:CGRectMake(165, 5, 145, 30)];
        btnHistory2.titleLabel.font=[UIFont systemFontOfSize:12];
        [btnHistory2 setTitle:@"历史数据" forState:UIControlStateNormal];
        [btnHistory2 setBackgroundColor:BTNCOLORGB];
        [btnHistory2 addTarget:self action:@selector(history2:) forControlEvents:UIControlEventTouchUpInside];
        [control addSubview:btnHistory2];
        
        UILabel *lbl1=[[UILabel alloc]initWithFrame:CGRectMake(25, 40, 80, 20)];
        [lbl1 setTextAlignment:NSTextAlignmentRight];
        [lbl1 setFont:[UIFont systemFontOfSize:12.0]];
        [lbl1 setText:@"线路名称:"];
        [lbl1 setTextColor:[UIColor blackColor]];
        [control addSubview:lbl1];
        
        UILabel *lblV1=[[UILabel alloc]initWithFrame:CGRectMake(110, 40, 200, 20)];
        [lblV1 setTextAlignment:NSTextAlignmentLeft];
        [lblV1 setFont:[UIFont systemFontOfSize:12.0]];
        [lblV1 setText:[Common NSNullConvertEmptyString:[self.data objectForKey:@"METER_NAME"]]];
        [lblV1 setTextColor:[UIColor blackColor]];
        [control addSubview:lblV1];
        
        UILabel *lbl2=[[UILabel alloc]initWithFrame:CGRectMake(25, 65, 80, 20)];
        [lbl2 setTextAlignment:NSTextAlignmentRight];
        [lbl2 setFont:[UIFont systemFontOfSize:12.0]];
        [lbl2 setText:@"上线时间:"];
        [lbl2 setTextColor:[UIColor blackColor]];
        [control addSubview:lbl2];
        
        UILabel *lblV2=[[UILabel alloc]initWithFrame:CGRectMake(110, 65, 120, 20)];
        [lblV2 setTextAlignment:NSTextAlignmentLeft];
        [lblV2 setFont:[UIFont systemFontOfSize:12.0]];
        [lblV2 setText:[Common NSNullConvertEmptyString:[self.data objectForKey:@"REPORT_DATE"]]];
        [lblV2 setTextColor:[UIColor blackColor]];
        [control addSubview:lblV2];
        
        UILabel *lbl3=[[UILabel alloc]initWithFrame:CGRectMake(25, 90, 80, 20)];
        [lbl3 setTextAlignment:NSTextAlignmentRight];
        [lbl3 setFont:[UIFont systemFontOfSize:12.0]];
        [lbl3 setText:@"开关状态:"];
        [lbl3 setTextColor:[UIColor blackColor]];
        [control addSubview:lbl3];
        
        UILabel *lblV3=[[UILabel alloc]initWithFrame:CGRectMake(110, 90, 120, 20)];
        [lblV3 setTextAlignment:NSTextAlignmentLeft];
        [lblV3 setFont:[UIFont systemFontOfSize:12.0]];
        NSString *SWITCH_STATUS=[Common NSNullConvertEmptyString:[self.data objectForKey:@"SWITCH_STATUS"]];
        if([@"1" isEqualToString:SWITCH_STATUS]){
            [lblV3 setTextColor:[UIColor redColor]];
            [lblV3 setText:@"合"];
        }else{
            [lblV3 setTextColor:[UIColor greenColor]];
            [lblV3 setText:@"分"];
        }
        [control addSubview:lblV3];
        
        UILabel *lbl4=[[UILabel alloc]initWithFrame:CGRectMake(25, 115, 80, 20)];
        [lbl4 setTextAlignment:NSTextAlignmentRight];
        [lbl4 setFont:[UIFont systemFontOfSize:12.0]];
        [lbl4 setText:@"日耗量:"];
        [lbl4 setTextColor:[UIColor blackColor]];
        [control addSubview:lbl4];
        
        UILabel *lblV4=[[UILabel alloc]initWithFrame:CGRectMake(110, 115, 120, 20)];
        [lblV4 setTextAlignment:NSTextAlignmentLeft];
        [lblV4 setFont:[UIFont systemFontOfSize:12.0]];
        NSString *DAY_POWER=[Common NSNullConvertEmptyString:[self.data objectForKey:@"DAY_POWER"]];
        if([@"" isEqualToString:DAY_POWER]){
            [lblV4 setText:@""];
        }else{
            [lblV4 setText:[NSString stringWithFormat:@"%@KWh",DAY_POWER]];
        }
        
        [lblV4 setTextColor:[UIColor blackColor]];
        [control addSubview:lblV4];
        
        UILabel *lbl5=[[UILabel alloc]initWithFrame:CGRectMake(25, 140, 80, 20)];
        [lbl5 setTextAlignment:NSTextAlignmentRight];
        [lbl5 setFont:[UIFont systemFontOfSize:12.0]];
        [lbl5 setText:@"A相电压:"];
        [lbl5 setTextColor:[UIColor blackColor]];
        [control addSubview:lbl5];
        
        UILabel *lblV5=[[UILabel alloc]initWithFrame:CGRectMake(110, 140, 120, 20)];
        [lblV5 setTextAlignment:NSTextAlignmentLeft];
        [lblV5 setFont:[UIFont systemFontOfSize:12.0]];
        [lblV5 setText:[NSString stringWithFormat:@"%@V",[Common NSNullConvertEmptyString:[self.data objectForKey:@"V_A"]]]];
        [lblV5 setTextColor:[UIColor blackColor]];
        [control addSubview:lblV5];
        
        UILabel *lbl6=[[UILabel alloc]initWithFrame:CGRectMake(25, 165, 80, 20)];
        [lbl6 setTextAlignment:NSTextAlignmentRight];
        [lbl6 setFont:[UIFont systemFontOfSize:12.0]];
        [lbl6 setText:@"B相电压:"];
        [lbl6 setTextColor:[UIColor blackColor]];
        [control addSubview:lbl6];
        
        UILabel *lblV6=[[UILabel alloc]initWithFrame:CGRectMake(110, 165, 120, 20)];
        [lblV6 setTextAlignment:NSTextAlignmentLeft];
        [lblV6 setFont:[UIFont systemFontOfSize:12.0]];
        [lblV6 setText:[NSString stringWithFormat:@"%@V",[Common NSNullConvertEmptyString:[self.data objectForKey:@"V_B"]]]];
        [lblV6 setTextColor:[UIColor blackColor]];
        [control addSubview:lblV6];
        
        UILabel *lbl7=[[UILabel alloc]initWithFrame:CGRectMake(25, 190, 80, 20)];
        [lbl7 setTextAlignment:NSTextAlignmentRight];
        [lbl7 setFont:[UIFont systemFontOfSize:12.0]];
        [lbl7 setText:@"C相电压:"];
        [lbl7 setTextColor:[UIColor blackColor]];
        [control addSubview:lbl7];
        
        UILabel *lblV7=[[UILabel alloc]initWithFrame:CGRectMake(110, 190, 120, 20)];
        [lblV7 setTextAlignment:NSTextAlignmentLeft];
        [lblV7 setFont:[UIFont systemFontOfSize:12.0]];
        [lblV7 setText:[NSString stringWithFormat:@"%@V",[Common NSNullConvertEmptyString:[self.data objectForKey:@"V_C"]]]];
        [lblV7 setTextColor:[UIColor blackColor]];
        [control addSubview:lblV7];
        
        UILabel *lbl8=[[UILabel alloc]initWithFrame:CGRectMake(25, 215, 80, 20)];
        [lbl8 setTextAlignment:NSTextAlignmentRight];
        [lbl8 setFont:[UIFont systemFontOfSize:12.0]];
        [lbl8 setText:@"A相电流:"];
        [lbl8 setTextColor:[UIColor blackColor]];
        [control addSubview:lbl8];
        
        UILabel *lblV8=[[UILabel alloc]initWithFrame:CGRectMake(110, 215, 120, 20)];
        [lblV8 setTextAlignment:NSTextAlignmentLeft];
        [lblV8 setFont:[UIFont systemFontOfSize:12.0]];
        [lblV8 setText:[NSString stringWithFormat:@"%@A",[Common NSNullConvertEmptyString:[self.data objectForKey:@"I_A"]]]];
        [lblV8 setTextColor:[UIColor blackColor]];
        [control addSubview:lblV8];
        
        UILabel *lbl9=[[UILabel alloc]initWithFrame:CGRectMake(25, 240, 80, 20)];
        [lbl9 setTextAlignment:NSTextAlignmentRight];
        [lbl9 setFont:[UIFont systemFontOfSize:12.0]];
        [lbl9 setText:@"B相电流:"];
        [lbl9 setTextColor:[UIColor blackColor]];
        [control addSubview:lbl9];
        
        UILabel *lblV9=[[UILabel alloc]initWithFrame:CGRectMake(110, 240, 120, 20)];
        [lblV9 setTextAlignment:NSTextAlignmentLeft];
        [lblV9 setFont:[UIFont systemFontOfSize:12.0]];
        [lblV9 setText:[NSString stringWithFormat:@"%@A",[Common NSNullConvertEmptyString:[self.data objectForKey:@"I_B"]]]];
        [lblV9 setTextColor:[UIColor blackColor]];
        [control addSubview:lblV9];
        
        UILabel *lbl10=[[UILabel alloc]initWithFrame:CGRectMake(25, 265, 80, 20)];
        [lbl10 setTextAlignment:NSTextAlignmentRight];
        [lbl10 setFont:[UIFont systemFontOfSize:12.0]];
        [lbl10 setText:@"C相电流:"];
        [lbl10 setTextColor:[UIColor blackColor]];
        [control addSubview:lbl10];
        
        UILabel *lblV10=[[UILabel alloc]initWithFrame:CGRectMake(110, 265, 120, 20)];
        [lblV10 setTextAlignment:NSTextAlignmentLeft];
        [lblV10 setFont:[UIFont systemFontOfSize:12.0]];
        [lblV10 setText:[NSString stringWithFormat:@"%@A",[Common NSNullConvertEmptyString:[self.data objectForKey:@"I_C"]]]];
        [lblV10 setTextColor:[UIColor blackColor]];
        [control addSubview:lblV10];
        
        UILabel *lbl11=[[UILabel alloc]initWithFrame:CGRectMake(25, 290, 80, 20)];
        [lbl11 setTextAlignment:NSTextAlignmentRight];
        [lbl11 setFont:[UIFont systemFontOfSize:12.0]];
        [lbl11 setText:@"总有功功率:"];
        [lbl11 setTextColor:[UIColor blackColor]];
        [control addSubview:lbl11];
        
        UILabel *lblV11=[[UILabel alloc]initWithFrame:CGRectMake(110, 290, 120, 20)];
        [lblV11 setTextAlignment:NSTextAlignmentLeft];
        [lblV11 setFont:[UIFont systemFontOfSize:12.0]];
        
        NSString *P_POWER=[Common NSNullConvertEmptyString:[self.data objectForKey:@"P_POWER"]];
        if([@"" isEqualToString:P_POWER]){
            [lblV11 setText:@""];
        }else{
            [lblV11 setText:[NSString stringWithFormat:@"%@KW",P_POWER]];
        }
        [lblV11 setTextColor:[UIColor blackColor]];
        [control addSubview:lblV11];
        
        UILabel *lbl12=[[UILabel alloc]initWithFrame:CGRectMake(25, 315, 80, 20)];
        [lbl12 setTextAlignment:NSTextAlignmentRight];
        [lbl12 setFont:[UIFont systemFontOfSize:12.0]];
        [lbl12 setText:@"总功率因数:"];
        [lbl12 setTextColor:[UIColor blackColor]];
        [control addSubview:lbl12];
        
        UILabel *lblV12=[[UILabel alloc]initWithFrame:CGRectMake(110, 315, 120, 20)];
        [lblV12 setTextAlignment:NSTextAlignmentLeft];
        [lblV12 setFont:[UIFont systemFontOfSize:12.0]];
        [lblV12 setText:[Common NSNullConvertEmptyString:[self.data objectForKey:@"FACTOR"]]];
        [lblV12 setTextColor:[UIColor blackColor]];
        [control addSubview:lblV12];
        
        [self.view addSubview:control];
    }
    return self;
}

- (void)history1:(id)sender {
    STDataMonitoringLineDetailListViewController *dataMonitoringLineDetailListViewController=[[STDataMonitoringLineDetailListViewController alloc]initWithData:self.data lastMonthSearch:YES];
    [self.navigationController pushViewController:dataMonitoringLineDetailListViewController animated:YES];
    [dataMonitoringLineDetailListViewController autoRefresh];
}

- (void)history2:(id)sender {
    STDataMonitoringLineDetailSearchViewController *dataMonitoringLineDetailSearchViewController=[[STDataMonitoringLineDetailSearchViewController alloc]initWithData:self.data];
    [self.navigationController pushViewController:dataMonitoringLineDetailSearchViewController animated:YES];
}

@end
