//
//  STChangeMaterialViewController.m
//  ElectricianRun
//  更换采集器
//  Created by Start on 2/21/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STChangeMaterialViewController.h"

#import "STScanningViewController.h"

@interface STChangeMaterialViewController ()<UIPickerViewDelegate,UIPickerViewDataSource,ScanningDelegate>

@end

@implementation STChangeMaterialViewController{
    UITextField *txtValue2;
    UIPickerView* pickerView;
    NSString *twoDimensionalCode;
    NSArray *selectData;
}

- (id)initWithSerialNo:(NSString*)no {
    self = [super init];
    if (self) {
        self.title=@"变更采集器";
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        self.serialNo=no;
        
        selectData=[[NSArray alloc]initWithObjects:@"--选择--",@"监测数据异常",@"通讯异常",@"采集器损坏",@"采集器不匹配", nil];
        
        UIControl *control=[[UIControl alloc]initWithFrame:CGRectMake(0, 100, 320, 160)];
        [control addTarget:self action:@selector(backgroundDoneEditing:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:control];
        
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 60, 30)];
        lbl.font=[UIFont systemFontOfSize:12.0];
        [lbl setText:@"原序列号"];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [control addSubview:lbl];
        
        UITextField *txtValue1=[[UITextField alloc]initWithFrame:CGRectMake(80, 10, 150, 30)];
        [txtValue1 setFont:[UIFont systemFontOfSize: 12.0]];
        [txtValue1 setClearButtonMode:UITextFieldViewModeWhileEditing];
        [txtValue1 setBorderStyle:UITextBorderStyleRoundedRect];
        [txtValue1 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [txtValue1 setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [txtValue1 setKeyboardType:UIKeyboardTypePhonePad];
        [txtValue1 setEnabled:NO];
        [txtValue1 setText:self.serialNo];
        [control addSubview:txtValue1];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 50, 60, 30)];
        lbl.font=[UIFont systemFontOfSize:12.0];
        [lbl setText:@"新序列号"];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [control addSubview:lbl];
        
        txtValue2=[[UITextField alloc]initWithFrame:CGRectMake(80, 50, 150, 30)];
        [txtValue2 setFont:[UIFont systemFontOfSize: 12.0]];
        [txtValue2 setClearButtonMode:UITextFieldViewModeWhileEditing];
        [txtValue2 setBorderStyle:UITextBorderStyleRoundedRect];
        [txtValue2 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [txtValue2 setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [txtValue2 setKeyboardType:UIKeyboardTypePhonePad];
        [control addSubview:txtValue2];
        
        UIButton *btnScan=[[UIButton alloc]initWithFrame:CGRectMake(235, 50, 30, 30)];
        [btnScan setBackgroundImage:[UIImage imageNamed:@"sj222"] forState:UIControlStateNormal];
        [btnScan setBackgroundColor:[UIColor blueColor]];
        [btnScan addTarget:self action:@selector(scanning:) forControlEvents:UIControlEventTouchUpInside];
        [control addSubview:btnScan];
        
        UIButton *btnSubmit=[[UIButton alloc]initWithFrame:CGRectMake(80, 120, 160, 30)];
        btnSubmit.titleLabel.font=[UIFont systemFontOfSize:12];
        [btnSubmit setTitle:@"开始变更" forState:UIControlStateNormal];
        [btnSubmit setBackgroundColor:[UIColor colorWithRed:(55/255.0) green:(55/255.0) blue:(139/255.0) alpha:1]];
        [btnSubmit addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
        [control addSubview:btnSubmit];
        
        pickerView = [ [ UIPickerView alloc] initWithFrame:CGRectMake(0.0,302.0,320.0,50)];
        pickerView.delegate = self;
        pickerView.dataSource =  self;
        [self.view addSubview:pickerView];
        
    }
    return self;
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
                [Common alert:@"更换成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }else{
        [Common alert:@"查询未找到采集器序列号，请联系管理员"];
    }
    
}

- (void)submit:(id)sender {
    
    NSString *newSerialNo=[txtValue2 text];
    
    if([@"" isEqualToString:newSerialNo]){
        [Common alert:@"请扫描新序列号"];
        return;
    }
    
    twoDimensionalCode=[newSerialNo stringByReplacingOccurrencesOfString:@" " withString:@""];
    if([twoDimensionalCode length]!=12){
        [Common alert:@"编号不符合规则!"];
        return;
    }
    
    NSInteger row=[pickerView selectedRowInComponent:0];
    if(row==0){
        [Common alert:@"请选择更换类型!"];
        return;
    }
    
    NSMutableDictionary *p=[[NSMutableDictionary alloc]init];
    [p setObject:[Account getUserName] forKey:@"imei"];
    [p setObject:[Account getPassword] forKey:@"authentication"];
    [p setObject:@"0" forKey:@"OpWap"];
    [p setObject:@"1" forKey:@"OpType"];
    [p setObject:self.serialNo forKey:@"SerialNo"];
    [p setObject:twoDimensionalCode forKey:@"NewserialNo"];
    [p setObject:[NSString stringWithFormat:@"%d",row] forKey:@"ChangeReason"];
    
    self.hRequest=[[HttpRequest alloc]init:self delegate:self responseCode:500];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest start:URLAppScanNumber params:p];
}

- (void)scanning:(id)sender {
    STScanningViewController *scanningViewController=[[STScanningViewController alloc]init];
    [scanningViewController setDelegate:self];
    [scanningViewController setResponseCode:500];
    [self presentViewController:scanningViewController animated:YES completion:nil];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    if (!view) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 30)];
        label.text = [selectData objectAtIndex:row];
        label.textColor = [UIColor blueColor];
        label.font=[UIFont systemFontOfSize:14];
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
        [view addSubview:label];
    }
    return view ;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [selectData count];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30.0f;
}

- (void)backgroundDoneEditing:(id)sender {
    [txtValue2 resignFirstResponder];
}

- (void)success:(NSString*)value responseCode:(NSInteger)responseCode{
    [txtValue2 setText:value];
    [self backgroundDoneEditing:nil];
}

@end
