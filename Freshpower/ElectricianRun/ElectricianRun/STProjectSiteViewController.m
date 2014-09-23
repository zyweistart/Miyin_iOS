//
//  STProjectSiteViewController.m
//  ElectricianRun
//  工程建站
//  Created by Start on 1/24/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STProjectSiteViewController.h"
#import "STScanningViewController.h"
#import "STProjectSiteAddLineViewController.h"

#define RESPONSECODESCAN 500
#define RESPONSECODESCANADD 501
#define RESPONSECODECREATESITE 502

@interface STProjectSiteViewController ()<ScanningDelegate>

@end

@implementation STProjectSiteViewController{
    UITextField *txtValue1;
    UITextField *txtValue2;
    UITextField *txtValue3;
    UITextField *txtValue4;
    NSDictionary *data;
    NSString *lineCode;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"工程建站";
        [self.view setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIControl *control=[[UIControl alloc]initWithFrame:CGRectMake(0, 164, 320, 300)];
    [self.view addSubview:control];
    //序列号
    UILabel *lblValue1=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 60, 30)];
    lblValue1.font=[UIFont systemFontOfSize:12.0];
    [lblValue1 setText:@"序列号"];
    [lblValue1 setTextColor:[UIColor blackColor]];
    [lblValue1 setBackgroundColor:[UIColor clearColor]];
    [lblValue1 setTextAlignment:NSTextAlignmentRight];
    [control addSubview:lblValue1];
    
    txtValue1=[[UITextField alloc]initWithFrame:CGRectMake(80, 10, 150, 30)];
    [txtValue1 setFont:[UIFont systemFontOfSize: 12.0]];
    [txtValue1 setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtValue1 setBorderStyle:UITextBorderStyleRoundedRect];
    [txtValue1 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [txtValue1 setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [txtValue1 setKeyboardType:UIKeyboardTypePhonePad];
    [txtValue1 setEnabled:NO];
    [control addSubview:txtValue1];
    
    UIButton *btnCalculate=[[UIButton alloc]initWithFrame:CGRectMake(235, 10, 30, 30)];
    [btnCalculate setBackgroundImage:[UIImage imageNamed:@"sj222"] forState:UIControlStateNormal];
    [btnCalculate addTarget:self action:@selector(scanning:) forControlEvents:UIControlEventTouchUpInside];
    [control addSubview:btnCalculate];
    //客户名称
    UILabel *lblValue2=[[UILabel alloc]initWithFrame:CGRectMake(10, 50, 60, 30)];
    lblValue2.font=[UIFont systemFontOfSize:12.0];
    [lblValue2 setText:@"客户名称"];
    [lblValue2 setTextColor:[UIColor blackColor]];
    [lblValue2 setBackgroundColor:[UIColor clearColor]];
    [lblValue2 setTextAlignment:NSTextAlignmentRight];
    [control addSubview:lblValue2];
    
    txtValue2=[[UITextField alloc]initWithFrame:CGRectMake(80, 50, 150, 30)];
    [txtValue2 setFont:[UIFont systemFontOfSize: 12.0]];
    [txtValue2 setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtValue2 setBorderStyle:UITextBorderStyleRoundedRect];
    [txtValue2 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [txtValue2 setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [txtValue2 setKeyboardType:UIKeyboardTypePhonePad];
    [txtValue2 setEnabled:NO];
    [control addSubview:txtValue2];
    //唯一标识
    UILabel *lblValue3=[[UILabel alloc]initWithFrame:CGRectMake(10, 90, 60, 30)];
    lblValue3.font=[UIFont systemFontOfSize:12.0];
    [lblValue3 setText:@"唯一标识"];
    [lblValue3 setTextColor:[UIColor blackColor]];
    [lblValue3 setBackgroundColor:[UIColor clearColor]];
    [lblValue3 setTextAlignment:NSTextAlignmentRight];
    [control addSubview:lblValue3];
    
    txtValue3=[[UITextField alloc]initWithFrame:CGRectMake(80, 90, 150, 30)];
    [txtValue3 setFont:[UIFont systemFontOfSize: 12.0]];
    [txtValue3 setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtValue3 setBorderStyle:UITextBorderStyleRoundedRect];
    [txtValue3 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [txtValue3 setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [txtValue3 setKeyboardType:UIKeyboardTypePhonePad];
    [txtValue3 setEnabled:NO];
    [control addSubview:txtValue3];
    //配电房编号
    UILabel *lblValue4=[[UILabel alloc]initWithFrame:CGRectMake(10, 130, 60, 30)];
    lblValue4.font=[UIFont systemFontOfSize:12.0];
    [lblValue4 setText:@"配电房编号"];
    [lblValue4 setTextColor:[UIColor blackColor]];
    [lblValue4 setBackgroundColor:[UIColor clearColor]];
    [lblValue4 setTextAlignment:NSTextAlignmentRight];
    [control addSubview:lblValue4];
    
    txtValue4=[[UITextField alloc]initWithFrame:CGRectMake(80, 130, 150, 30)];
    [txtValue4 setFont:[UIFont systemFontOfSize: 12.0]];
    [txtValue4 setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtValue4 setBorderStyle:UITextBorderStyleRoundedRect];
    [txtValue4 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [txtValue4 setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [txtValue4 setKeyboardType:UIKeyboardTypePhonePad];
    [txtValue4 setEnabled:NO];
    [control addSubview:txtValue4];
    
    //建站
    UIButton *btnSite=[[UIButton alloc]initWithFrame:CGRectMake(80, 170, 80, 30)];
    [btnSite setBackgroundImage:[UIImage imageNamed:@"jz111"] forState:UIControlStateNormal];
    [btnSite addTarget:self action:@selector(site:) forControlEvents:UIControlEventTouchUpInside];
    [control addSubview:btnSite];
    //添加线路
    UIButton *btnAdd=[[UIButton alloc]initWithFrame:CGRectMake(165, 170, 80, 30)];
    [btnAdd setBackgroundImage:[UIImage imageNamed:@"xl432143"] forState:UIControlStateNormal];
    [btnAdd addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    [control addSubview:btnAdd];
}

- (void)success:(NSString*)value responseCode:(NSInteger)responseCode{
    if(responseCode==RESPONSECODESCAN){
        NSString *v=[value stringByReplacingOccurrencesOfString:@" " withString:@""];
        [txtValue1 setText:value];
        if([v length]==12){
            NSMutableDictionary *p=[[NSMutableDictionary alloc]init];
            [p setObject:[Account getUserName] forKey:@"imei"];
            [p setObject:[Account getPassword] forKey:@"authentication"];
            [p setObject:@"0" forKey:@"OpWap"];
            [p setObject:v forKey:@"SerialNo"];
            
            self.hRequest=[[HttpRequest alloc]init:self delegate:self responseCode:RESPONSECODESCAN];
            [self.hRequest setIsShowMessage:YES];
            [self.hRequest start:URLAppProductInfoBySerial params:p];
        }else{
            [txtValue1 setText:@""];
            [txtValue2 setText:@""];
            [txtValue3 setText:@""];
            [txtValue4 setText:@""];
            [Common alert:@"请扫描正确的汇集器!"];
        }
    }else if(responseCode==RESPONSECODESCANADD){
        NSString *v=[value stringByReplacingOccurrencesOfString:@" " withString:@""];
        if([v length]==14){
            
            lineCode=v;
            
            NSMutableDictionary *p=[[NSMutableDictionary alloc]init];
            [p setObject:[Account getUserName] forKey:@"imei"];
            [p setObject:[Account getPassword] forKey:@"authentication"];
            [p setObject:@"0" forKey:@"OpWap"];
            [p setObject:[v substringToIndex:12] forKey:@"SerialNo"];
            [p setObject:[v substringFromIndex:12] forKey:@"Channel"];
            
            self.hRequest=[[HttpRequest alloc]init:self delegate:self responseCode:RESPONSECODESCANADD];
            [self.hRequest setIsShowMessage:YES];
            [self.hRequest start:URLAppProductInfoBySerial params:p];
        }else{
            [Common alert:@"请扫描正确的采集器！"];
        }
    }
}

- (void)scanning:(id)sender {
    data=nil;
    STScanningViewController *scanningViewController=[[STScanningViewController alloc]init];
    [scanningViewController setDelegate:self];
    [scanningViewController setResponseCode:RESPONSECODESCAN];
    [self presentViewController:scanningViewController animated:YES completion:nil];
}

- (void)site:(id)sender {
    if(data){
        int siteId=[[data objectForKey:@"MSITE_ID"]intValue];
        if(siteId==0){
            NSString *value=[[txtValue1 text] stringByReplacingOccurrencesOfString:@" " withString:@""];
            
            NSMutableDictionary *p=[[NSMutableDictionary alloc]init];
            [p setObject:[Account getUserName] forKey:@"imei"];
            [p setObject:[Account getPassword] forKey:@"authentication"];
            [p setObject:@"2" forKey:@"OpWap"];
            [p setObject:value forKey:@"SerialNo"];
            
            self.hRequest=[[HttpRequest alloc]init:self delegate:self responseCode:RESPONSECODECREATESITE];
            [self.hRequest setIsShowMessage:YES];
            [self.hRequest start:URLAppProductInfoBySerial params:p];
            
        }else{
            [Common alert:@"该站点已经存在，无需添加！"];
        }
    }else{
        [Common alert:@"请先扫描汇集器二维码！"];
    }
}

- (void)add:(id)sender {
    if(data){
        int siteId=[[data objectForKey:@"MSITE_ID"]intValue];
        if(siteId>0){
            NSString *serial=[txtValue1 text];
            if(![@"" isEqualToString:serial]){
                STScanningViewController *scanningViewController=[[STScanningViewController alloc]init];
                [scanningViewController setDelegate:self];
                [scanningViewController setResponseCode:RESPONSECODESCANADD];
                [self presentViewController:scanningViewController animated:YES completion:nil];
            }else{
                [Common alert:@"请先扫描汇集器二维码！"];
            }
        }else{
            [Common alert:@"请先建站！"];
        }
    }else{
        [Common alert:@"请先扫描汇集器二维码！"];
    }
}

- (void)requestFinishedByResponse:(Response*)response responseCode:(int)repCode
{
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
                if(repCode==RESPONSECODESCAN){
                    data=[[NSMutableDictionary alloc]initWithDictionary:dic];
//                    [txtValue1 setText:[dic objectForKey:@"SERIAL_NO"]];
                    [txtValue2 setText:[dic objectForKey:@"CP_NAME"]];
                    [txtValue3 setText:[dic objectForKey:@"CONVERGEKEY"]];
                    [txtValue4 setText:[dic objectForKey:@"SUB_NAME"]];
                }else if(repCode==RESPONSECODESCANADD){
                    NSMutableDictionary *d=[[NSMutableDictionary alloc]initWithDictionary:dic];
                    
                    [d setObject:lineCode forKey:@"SERIAL_NO"];
                    [d setObject:[data objectForKey:@"MSITE_ID"] forKey:@"MSITE_ID"];
                    
                    STProjectSiteAddLineViewController *projectSiteAddLineViewController=[[STProjectSiteAddLineViewController alloc]initWithData:d];
                    [self.navigationController pushViewController:projectSiteAddLineViewController animated:YES];
                }else if(repCode==RESPONSECODECREATESITE){
                    [data setValue:result forKey:@"MSITE_ID"];
                    [Common alert:@"建站成功"];
                }
            }
            break;
        }
    }else{
        if(repCode==RESPONSECODESCAN){
            [Common alert:@"查询未找到汇集器序列号，请联系管理员"];
        }else if(repCode==RESPONSECODESCANADD){
            [Common alert:@"查询未找到采集器序列号，请联系管理员"];
        }else{
            [Common alert:@"暂无记录"];
        }
    }
}

@end
