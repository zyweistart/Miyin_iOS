//
//  STAggregatorInfoViewController.m
//  ElectricianRun
//  渠集器信息
//  Created by Start on 2/21/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STAggregatorInfoViewController.h"
#import "STAggregatorEntInfoViewController.h"

@interface STAggregatorInfoViewController ()

@end

@implementation STAggregatorInfoViewController {
    UILabel *lblV1;
    UILabel *lblV2;
    UILabel *lblV3;
    UILabel *lblV4;
    UILabel *lblV5;
    UILabel *lblV6;
    UILabel *lblV7;
    UILabel *lblV8;
    UILabel *lblV9;
    UILabel *lblV10;
    UIButton *btnEnt;
    NSString *SITE_ID;
}

- (id)initWithSerialNo:(NSString*)no {
    self = [super init];
    if (self) {
        self.title=@"汇集器信息";
        [self.view setBackgroundColor:[UIColor whiteColor]];
        self.serialNo=no;
        [self reloadDataSource];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIControl *control=[[UIControl alloc]initWithFrame:CGRectMake(0, 80, 320, 305)];
    
    UILabel *lbl1=[[UILabel alloc]initWithFrame:CGRectMake(80, 5, 80, 20)];
    [lbl1 setTextAlignment:NSTextAlignmentRight];
    [lbl1 setFont:[UIFont systemFontOfSize:12.0]];
    [lbl1 setText:@"序列号:"];
    [lbl1 setTextColor:[UIColor blackColor]];
    [control addSubview:lbl1];
    
    lblV1=[[UILabel alloc]initWithFrame:CGRectMake(160, 5, 120, 20)];
    [lblV1 setTextAlignment:NSTextAlignmentLeft];
    [lblV1 setFont:[UIFont systemFontOfSize:12.0]];
    [lblV1 setTextColor:[UIColor blackColor]];
    [control addSubview:lblV1];
    
    UILabel *lbl2=[[UILabel alloc]initWithFrame:CGRectMake(80, 30, 80, 20)];
    [lbl2 setTextAlignment:NSTextAlignmentRight];
    [lbl2 setFont:[UIFont systemFontOfSize:12.0]];
    [lbl2 setText:@"型号:"];
    [lbl2 setTextColor:[UIColor blackColor]];
    [control addSubview:lbl2];
    
    lblV2=[[UILabel alloc]initWithFrame:CGRectMake(160, 30, 120, 20)];
    [lblV2 setTextAlignment:NSTextAlignmentLeft];
    [lblV2 setFont:[UIFont systemFontOfSize:12.0]];
    [lblV2 setTextColor:[UIColor blackColor]];
    [control addSubview:lblV2];
    
    UILabel *lbl3=[[UILabel alloc]initWithFrame:CGRectMake(80, 55, 80, 20)];
    [lbl3 setTextAlignment:NSTextAlignmentRight];
    [lbl3 setFont:[UIFont systemFontOfSize:12.0]];
    [lbl3 setText:@"与主站通讯:"];
    [lbl3 setTextColor:[UIColor blackColor]];
    [control addSubview:lbl3];
    
    lblV3=[[UILabel alloc]initWithFrame:CGRectMake(160, 55, 120, 20)];
    [lblV3 setTextAlignment:NSTextAlignmentLeft];
    [lblV3 setFont:[UIFont systemFontOfSize:12.0]];
    [lblV3 setTextColor:[UIColor blackColor]];
    [control addSubview:lblV3];
    
    UILabel *lbl4=[[UILabel alloc]initWithFrame:CGRectMake(80, 80, 80, 20)];
    [lbl4 setTextAlignment:NSTextAlignmentRight];
    [lbl4 setFont:[UIFont systemFontOfSize:12.0]];
    [lbl4 setText:@"与主站连接:"];
    [lbl4 setTextColor:[UIColor blackColor]];
    [control addSubview:lbl4];
    
    lblV4=[[UILabel alloc]initWithFrame:CGRectMake(160, 80, 120, 20)];
    [lblV4 setTextAlignment:NSTextAlignmentLeft];
    [lblV4 setFont:[UIFont systemFontOfSize:12.0]];
    [lblV4 setTextColor:[UIColor blackColor]];
    [control addSubview:lblV4];
    
    UILabel *lbl5=[[UILabel alloc]initWithFrame:CGRectMake(80, 105, 80, 20)];
    [lbl5 setTextAlignment:NSTextAlignmentRight];
    [lbl5 setFont:[UIFont systemFontOfSize:12.0]];
    [lbl5 setText:@"使用单位:"];
    [lbl5 setTextColor:[UIColor blackColor]];
    [control addSubview:lbl5];
    
    lblV5=[[UILabel alloc]initWithFrame:CGRectMake(160, 105, 120, 20)];
    [lblV5 setTextAlignment:NSTextAlignmentLeft];
    [lblV5 setFont:[UIFont systemFontOfSize:12.0]];
    [lblV5 setTextColor:[UIColor blackColor]];
    [control addSubview:lblV5];
    
    UILabel *lbl6=[[UILabel alloc]initWithFrame:CGRectMake(80, 130, 80, 20)];
    [lbl6 setTextAlignment:NSTextAlignmentRight];
    [lbl6 setFont:[UIFont systemFontOfSize:12.0]];
    [lbl6 setText:@"配电房编号:"];
    [lbl6 setTextColor:[UIColor blackColor]];
    [control addSubview:lbl6];
    
    lblV6=[[UILabel alloc]initWithFrame:CGRectMake(160, 130, 120, 20)];
    [lblV6 setTextAlignment:NSTextAlignmentLeft];
    [lblV6 setFont:[UIFont systemFontOfSize:12.0]];
    [lblV6 setTextColor:[UIColor blackColor]];
    [control addSubview:lblV6];
    
    UILabel *lbl7=[[UILabel alloc]initWithFrame:CGRectMake(80, 155, 80, 20)];
    [lbl7 setTextAlignment:NSTextAlignmentRight];
    [lbl7 setFont:[UIFont systemFontOfSize:12.0]];
    [lbl7 setText:@"采集路数:"];
    [lbl7 setTextColor:[UIColor blackColor]];
    [control addSubview:lbl7];
    
    lblV7=[[UILabel alloc]initWithFrame:CGRectMake(160, 155, 120, 20)];
    [lblV7 setTextAlignment:NSTextAlignmentLeft];
    [lblV7 setFont:[UIFont systemFontOfSize:12.0]];
    [lblV7 setTextColor:[UIColor blackColor]];
    [control addSubview:lblV7];
    
    UILabel *lbl8=[[UILabel alloc]initWithFrame:CGRectMake(80, 180, 80, 20)];
    [lbl8 setTextAlignment:NSTextAlignmentRight];
    [lbl8 setFont:[UIFont systemFontOfSize:12.0]];
    [lbl8 setText:@"采集器数:"];
    [lbl8 setTextColor:[UIColor blackColor]];
    [control addSubview:lbl8];
    
    lblV8=[[UILabel alloc]initWithFrame:CGRectMake(160, 180, 120, 20)];
    [lblV8 setTextAlignment:NSTextAlignmentLeft];
    [lblV8 setFont:[UIFont systemFontOfSize:12.0]];
    [lblV8 setTextColor:[UIColor blackColor]];
    [control addSubview:lblV8];
    
    UILabel *lbl9=[[UILabel alloc]initWithFrame:CGRectMake(80, 205, 80, 20)];
    [lbl9 setTextAlignment:NSTextAlignmentRight];
    [lbl9 setFont:[UIFont systemFontOfSize:12.0]];
    [lbl9 setText:@"报警信息:"];
    [lbl9 setTextColor:[UIColor blackColor]];
    [control addSubview:lbl9];
    
    lblV9=[[UILabel alloc]initWithFrame:CGRectMake(160, 205, 120, 20)];
    [lblV9 setTextAlignment:NSTextAlignmentLeft];
    [lblV9 setFont:[UIFont systemFontOfSize:12.0]];
    [lblV9 setTextColor:[UIColor redColor]];
    [control addSubview:lblV9];
    
    UILabel *lbl10=[[UILabel alloc]initWithFrame:CGRectMake(80, 230, 80, 20)];
    [lbl10 setTextAlignment:NSTextAlignmentRight];
    [lbl10 setFont:[UIFont systemFontOfSize:12.0]];
    [lbl10 setText:@"异常路数:"];
    [lbl10 setTextColor:[UIColor blackColor]];
    [control addSubview:lbl10];
    
    lblV10=[[UILabel alloc]initWithFrame:CGRectMake(160, 230, 120, 20)];
    [lblV10 setTextAlignment:NSTextAlignmentLeft];
    [lblV10 setFont:[UIFont systemFontOfSize:12.0]];
    [lblV10 setTextColor:[UIColor redColor]];
    [control addSubview:lblV10];
    
    btnEnt=[[UIButton alloc]initWithFrame:CGRectMake(80, 280, 160, 30)];
    btnEnt.titleLabel.font=[UIFont systemFontOfSize:12.0];
    [btnEnt setTitle:@"企业基本信息" forState:UIControlStateNormal];
    [btnEnt setBackgroundColor:[UIColor colorWithRed:(55/255.0) green:(55/255.0) blue:(139/255.0) alpha:1]];
    [btnEnt addTarget:self action:@selector(entinfo:) forControlEvents:UIControlEventTouchUpInside];
    [btnEnt setHidden:YES];
    [control addSubview:btnEnt];
     
    [self.view addSubview:control];
}

- (void)entinfo:(id)sender {
    STAggregatorEntInfoViewController *aggregatorEntInfoViewController=[[STAggregatorEntInfoViewController alloc]initWithSID:SITE_ID];
    [self.navigationController pushViewController:aggregatorEntInfoViewController animated:YES];
}

- (void)reloadDataSource{
    
    NSMutableDictionary *p=[[NSMutableDictionary alloc]init];
    [p setObject:[Account getUserName] forKey:@"imei"];
    [p setObject:[Account getPassword] forKey:@"authentication"];
    [p setObject:@"1" forKey:@"OpWap"];
    [p setObject:@"2" forKey:@"OpType"];
    [p setObject:self.serialNo forKey:@"SerialNo"];
    
    self.hRequest=[[HttpRequest alloc]init:self delegate:self responseCode:500];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest start:URLAppScanNumber params:p];
    
}

- (void)requestFinishedByResponse:(Response*)response responseCode:(int)repCode {
    NSMutableArray *dataArray=[[NSMutableArray alloc]initWithArray:[[response resultJSON] objectForKey:@"Rows"]];
    if([dataArray count]>0){
        for(NSDictionary *dic in dataArray) {
            NSString *result=[NSString stringWithFormat:@"%@",[dic objectForKey:@"result"]];
            if([@"-15" isEqualToString:result]){
                [Common alert:@"暂未配置远程汇集器信息，请配置再下发!"];
            }else if([@"-14" isEqualToString:result]){
                [Common alert:@"原始采集器序列号不是12位，请修改后再操作。"];
            }else if([@"-13" isEqualToString:result]){
                [Common alert:@"连接中断，已重新连接!"];
            }else if([@"-12" isEqualToString:result]){
                [Common alert:@"连接失败，请检查网络及汇集器是否正常!"];
            }else if([@"-11" isEqualToString:result]){
                [Common alert:@"站点下发类型尚未设置，不可操作！"];
            }else if([@"-10" isEqualToString:result]){
                [Common alert:@"找不到唯一标识或序列号，请核实后再操作！"];
            }else if([@"-9" isEqualToString:result]){
                [Common alert:@"查询未找到采集器序列号，请联系管理员！"];
            }else if([@"-8" isEqualToString:result]){
                [Common alert:@"操作失败，当前用户无管理权限！;"];
            }else if([@"-7" isEqualToString:result]){
                [Common alert:@"原始采集器序列号下未找到线路，不可操作！"];
            }else if([@"-6" isEqualToString:result]){
                [Common alert:@"变更采集器序列号不可操作"];
            }else if([@"-5" isEqualToString:result]){
                [Common alert:@"变更采集器序列号注册类型错误，"];
            }else if([@"-4" isEqualToString:result]){
                [Common alert:@"原始采集器序列号下存在多条线路，不能使用CK型采集器序列号！"];
            }else if([@"-2" isEqualToString:result]){
                [Common alert:@"原始采集器序列号不可操作！"];
            }else if([@"-1" isEqualToString:result]){
                [Common alert:@"序列号变更失败！"];
            }else if([@"0" isEqualToString:result]){
                [Common alert:@"不合法操作（该用户不存在）！"];
            }else{
                [lblV1 setText:[self serialNo]];
                [lblV2 setText:[Common NSNullConvertEmptyString:[dic objectForKey:@"PRODUCT_NO"]]];
                [lblV3 setText:[Common NSNullConvertEmptyString:[dic objectForKey:@"COMMU_TYPE"]]];
                NSString *statusStr=[NSString stringWithFormat:@"%@",[Common NSNullConvertEmptyString:[dic objectForKey:@"STATUS"]]];
                if([@"1" isEqualToString:statusStr]){
                    [lblV4 setText:@"关闭"];
                }else if([@"2" isEqualToString:statusStr]){
                    [lblV4 setText:@"在线"];
                }
                [lblV5 setText:[Common NSNullConvertEmptyString:[dic objectForKey:@"CP_NAME"]]];
                [lblV6 setText:[Common NSNullConvertEmptyString:[dic objectForKey:@"CONVERGE_KEY"]]];
                [lblV7 setText:[Common NSNullConvertEmptyString:[dic objectForKey:@"LINES_COUNT"]]];
                [lblV8 setText:[Common NSNullConvertEmptyString:[dic objectForKey:@"METERS_COUNT"]]];
                [lblV9 setText:[Common NSNullConvertEmptyString:[dic objectForKey:@"ALARM_COUNT"]]];
                [lblV10 setText:[Common NSNullConvertEmptyString:[dic objectForKey:@"ERR_COUNT"]]];
                
                SITE_ID=[Common NSNullConvertEmptyString:[dic objectForKey:@"SITE_ID"]];
                if(![@"" isEqualToString:SITE_ID]){
                    [btnEnt setHidden:NO];
                }
            }
            break;
        }
    }else{
        [Common alert:@"查询未找到汇集器序列号，请联系管理员"];
    }
}

@end
