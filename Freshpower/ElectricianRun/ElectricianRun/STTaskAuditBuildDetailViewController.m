//
//  STTaskAuditBuildDetailViewController.m
//  ElectricianRun
//  巡检任务生成
//  Created by Start on 2/20/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STTaskAuditBuildDetailViewController.h"
#import "DatePickerView.h"
#import "DataPickerView.h"
#import "NSString+Utils.h"

#define LOADUSERCODE 500
#define LOADMODELCODE 501
#define BUILDTASK 502

@interface STTaskAuditBuildDetailViewController () <DatePickerViewDelegate,DataPickerViewDelegate,UITextFieldDelegate>

@end

@implementation STTaskAuditBuildDetailViewController {
    UITextField *txtValue1;
    UITextField *txtValue2;
    UITextField *txtValue3;
    UITextField *txtValue4;
    
    NSMutableArray *data1;
    NSMutableArray *data2;
    
    DataPickerView *userdpv;
    DataPickerView *modeldpv;
    
    DatePickerView *datePicker;
    
    NSString *userId;
    NSString *modelId;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"巡检任务生成";
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]
                                               initWithTitle:@"生成"
                                               style:UIBarButtonItemStyleBordered
                                               target:self
                                               action:@selector(build:)];
        
    }
    return self;
}

- (void)build:(id)sender {
    
    if([@"" isEqualToString:[txtValue1 text]]){
        [Common alert:@"请选择任务时间"];
        return;
    }
    if([@"" isEqualToString:[txtValue2 text]]){
        [Common alert:@"请选择要求完成时间"];
        return;
    }
    if([@"" isEqualToString:[txtValue3 text]]){
        [Common alert:@"请选择工作人员"];
        return;
    }
    if([@"" isEqualToString:[txtValue4 text]]){
        [Common alert:@"请选择任务模板"];
        return;
    }
    
    NSMutableDictionary *p=[[NSMutableDictionary alloc]init];
    [p setObject:[Account getUserName] forKey:@"imei"];
    [p setObject:[Account getPassword] forKey:@"authentication"];
    [p setObject:@"RW19" forKey:@"GNID"];
    [p setObject:self.cpId forKey:@"QTCP"];
    [p setObject:self.contractId forKey:@"QTCT"];
    [p setObject:self.siteId forKey:@"QTST"];
    [p setObject:userId forKey:@"QTKEY1"];
    [p setObject:modelId forKey:@"QTKEY2"];
    [p setObject:[txtValue1 text] forKey:@"QTD1"];
    [p setObject:[txtValue2 text] forKey:@"QTD2"];
    
    self.hRequest=[[HttpRequest alloc]init:self delegate:self responseCode:BUILDTASK];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest start:URLAppMonitoringAlarm params:p];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    datePicker = [[DatePickerView alloc] init];
    [datePicker setDelegate:self];
    
    UIControl *control=[[UIControl alloc]initWithFrame:CGRectMake(0, 80, 320, 210)];
    [self.view addSubview:control];
    
    UILabel *lblName=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 90, 30)];
    lblName.font=[UIFont systemFontOfSize:12.0];
    [lblName setText:@"任务时间"];
    [lblName setTextColor:[UIColor blackColor]];
    [lblName setBackgroundColor:[UIColor clearColor]];
    [lblName setTextAlignment:NSTextAlignmentRight];
    [control addSubview:lblName];
    
    txtValue1=[[UITextField alloc]initWithFrame:CGRectMake(105, 10, 180, 30)];
    [txtValue1 setFont:[UIFont systemFontOfSize: 12.0]];
    [txtValue1 setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtValue1 setBorderStyle:UITextBorderStyleRoundedRect];
    [txtValue1 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [txtValue1 setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [txtValue1 setInputView:datePicker];
    [txtValue1 setDelegate:self];
    [control addSubview:txtValue1];
    
    lblName=[[UILabel alloc]initWithFrame:CGRectMake(10, 50, 90, 30)];
    lblName.font=[UIFont systemFontOfSize:12.0];
    [lblName setText:@"要求完成时间"];
    [lblName setTextColor:[UIColor blackColor]];
    [lblName setBackgroundColor:[UIColor clearColor]];
    [lblName setTextAlignment:NSTextAlignmentRight];
    [control addSubview:lblName];
    
    txtValue2=[[UITextField alloc]initWithFrame:CGRectMake(105, 50, 180, 30)];
    [txtValue2 setFont:[UIFont systemFontOfSize: 12.0]];
    [txtValue2 setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtValue2 setBorderStyle:UITextBorderStyleRoundedRect];
    [txtValue2 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [txtValue2 setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [txtValue2 setInputView:datePicker];
    [txtValue2 setDelegate:self];
    [control addSubview:txtValue2];
    
    lblName=[[UILabel alloc]initWithFrame:CGRectMake(10, 90, 90, 30)];
    lblName.font=[UIFont systemFontOfSize:12.0];
    [lblName setText:@"工作人员"];
    [lblName setTextColor:[UIColor blackColor]];
    [lblName setBackgroundColor:[UIColor clearColor]];
    [lblName setTextAlignment:NSTextAlignmentRight];
    [control addSubview:lblName];
    
    txtValue3=[[UITextField alloc]initWithFrame:CGRectMake(105, 90, 180, 30)];
    [txtValue3 setFont:[UIFont systemFontOfSize: 12.0]];
    [txtValue3 setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtValue3 setBorderStyle:UITextBorderStyleRoundedRect];
    [txtValue3 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [txtValue3 setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [control addSubview:txtValue3];
    
    lblName=[[UILabel alloc]initWithFrame:CGRectMake(10, 130, 90, 30)];
    lblName.font=[UIFont systemFontOfSize:12.0];
    [lblName setText:@"任务模板"];
    [lblName setTextColor:[UIColor blackColor]];
    [lblName setBackgroundColor:[UIColor clearColor]];
    [lblName setTextAlignment:NSTextAlignmentRight];
    [control addSubview:lblName];
    
    txtValue4=[[UITextField alloc]initWithFrame:CGRectMake(105, 130, 180, 30)];
    [txtValue4 setFont:[UIFont systemFontOfSize: 12.0]];
    [txtValue4 setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtValue4 setBorderStyle:UITextBorderStyleRoundedRect];
    [txtValue4 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [txtValue4 setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [control addSubview:txtValue4];
    
}

//加载工作人员
- (void)reloadUser{
    
    NSMutableDictionary *p=[[NSMutableDictionary alloc]init];
    [p setObject:[Account getUserName] forKey:@"imei"];
    [p setObject:[Account getPassword] forKey:@"authentication"];
    [p setObject:@"ZY23" forKey:@"GNID"];
    [p setObject:self.cpId forKey:@"QTCP"];
    
    self.hRequest=[[HttpRequest alloc]init:self delegate:self responseCode:LOADUSERCODE];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest start:URLAppMonitoringAlarm params:p];
}

//加载任务模板
- (void)reloadModel{
    
    NSMutableDictionary *p=[[NSMutableDictionary alloc]init];
    [p setObject:[Account getUserName] forKey:@"imei"];
    [p setObject:[Account getPassword] forKey:@"authentication"];
    [p setObject:@"ZY24" forKey:@"GNID"];
    [p setObject:@"1" forKey:@"QTKEY"];
    
    self.hRequest=[[HttpRequest alloc]init:self delegate:self responseCode:LOADMODELCODE];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest start:URLAppMonitoringAlarm params:p];
}

- (void)requestFinishedByResponse:(Response*)response responseCode:(int)repCode {
    if(repCode==LOADUSERCODE) {
        NSArray *tmpData=[[response resultJSON] objectForKey:@"table1"];
        if([tmpData count]>0){
            data1=[[NSMutableArray alloc]initWithArray:tmpData];
            
            NSMutableArray *d=[[NSMutableArray alloc]init];
            for(NSDictionary *dic in data1) {
                [d addObject:[dic objectForKey:@"USER_NAME"]];
            }
            
            userdpv=[[DataPickerView alloc]initWithData:d];
            [userdpv setDelegate:self];
            
            [txtValue3 setInputView:userdpv];
            
            //设置默认值
            NSDictionary *tmp= [data1 objectAtIndex:0];
            userId=[tmp objectForKey:@"USER_ID"];
            [txtValue3 setText:[tmp objectForKey:@"USER_NAME"]];
        }else{
            [Common alert:@"工作人员数据为空"];
//            [self.navigationController popViewControllerAnimated:YES];
        }
    } else if(repCode==LOADMODELCODE) {
        NSArray *tmpData=[[response resultJSON] objectForKey:@"table1"];
        if([tmpData count]>0){
            data2=[[NSMutableArray alloc]initWithArray:tmpData];
            
            NSMutableArray *d=[[NSMutableArray alloc]init];
            for(NSDictionary *dic in data2) {
                [d addObject:[dic objectForKey:@"MODEL_NAME"]];
            }
            
            modeldpv=[[DataPickerView alloc]initWithData:d];
            [modeldpv setDelegate:self];
            
            [txtValue4 setInputView:modeldpv];
            //设置默认值
            NSDictionary *tmp= [data2 objectAtIndex:0];
            modelId=[tmp objectForKey:@"MODEL_ID"];
            [txtValue4 setText:[tmp objectForKey:@"MODEL_NAME"]];
        }else{
            [Common alert:@"任务模数据为空"];
//            [self.navigationController popViewControllerAnimated:YES];
        }
    } else if(repCode==BUILDTASK) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)pickerDidPressDoneWithRow:(NSInteger)row {
    if([txtValue3 isFirstResponder]){
        NSDictionary *d= [data1 objectAtIndex:row];
        userId=[d objectForKey:@"USER_ID"];
        [txtValue3 setText:[d objectForKey:@"USER_NAME"]];
        [txtValue3 resignFirstResponder];
    }
    if([txtValue4 isFirstResponder]){
        NSDictionary *d= [data2 objectAtIndex:row];
        modelId=[d objectForKey:@"MODEL_ID"];
        [txtValue4 setText:[d objectForKey:@"MODEL_NAME"]];
        [txtValue4 resignFirstResponder];
    }
}

- (void)pickerDidPressCancel{
    if([txtValue1 isFirstResponder]){
        [txtValue1 resignFirstResponder];
    }
    if([txtValue2 isFirstResponder]){
        [txtValue2 resignFirstResponder];
    }
    if([txtValue3 isFirstResponder]){
        [txtValue3 resignFirstResponder];
    }
    if([txtValue4 isFirstResponder]){
        [txtValue4 resignFirstResponder];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSString *d=[textField text];
    if(![@"" isEqualToString:d]){
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = [dateFormatter dateFromString:d];
        [[datePicker datePicker]setDate:date];
    }
}

- (void)pickerDidPressDoneWithDate:(NSDate*)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    if([txtValue1 isFirstResponder]){
        [txtValue1 setText:currentDateStr];
        [txtValue1 resignFirstResponder];
    }
    if([txtValue2 isFirstResponder]){
        [txtValue2 setText:currentDateStr];
        [txtValue2 resignFirstResponder];
    }
}


@end
