//
//  STScanningOperationViewController.m
//  ElectricianRun
//  扫描操作
//  Created by Start on 2/19/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STScanningOperationViewController.h"
#import "STAggregatorInfoViewController.h"
#import "STLineInfoViewController.h"
#import "STChangeMaterialViewController.h"
#import "STScanningViewController.h"
#import "DataPickerView.h"

@interface STScanningOperationViewController()<ScanningDelegate,DataPickerViewDelegate>

@end

@implementation STScanningOperationViewController {
    NSArray *selectData;
    UITextField *txtValue1;
    NSString *channl;
    NSString *twoDimensionalCode;
    DataPickerView *dpvOperation;
    UITextField *txtOperation;
    NSInteger selectrow;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"扫描操作";
        [self.view setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    selectrow=0;
    selectData=[[NSArray alloc]initWithObjects:@"请选择",@"线路实时信息",@"更换采集器",nil];
    dpvOperation=[[DataPickerView alloc]initWithData:selectData];
    [dpvOperation setDelegate:self];
    
    UIControl *control=[[UIControl alloc]initWithFrame:CGRectMake(0, 104, 320, 140)];
    [control addTarget:self action:@selector(backgroundDoneEditing:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:control];
    
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 60, 30)];
    lbl.font=[UIFont systemFontOfSize:12.0];
    [lbl setText:@"操作"];
    [lbl setTextColor:[UIColor blackColor]];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setTextAlignment:NSTextAlignmentRight];
    [control addSubview:lbl];
    
    txtOperation=[[UITextField alloc]initWithFrame:CGRectMake(80, 10, 150, 30)];
    [txtOperation setFont:[UIFont systemFontOfSize: 12.0]];
    [txtOperation setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtOperation setBorderStyle:UITextBorderStyleRoundedRect];
    [txtOperation setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [txtOperation setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [txtOperation setKeyboardType:UIKeyboardTypePhonePad];
    [txtOperation setInputView:dpvOperation];
    [txtOperation setText:[selectData objectAtIndex:selectrow]];
    [control addSubview:txtOperation];
    
    UILabel *lblValue1=[[UILabel alloc]initWithFrame:CGRectMake(10, 50, 60, 30)];
    lblValue1.font=[UIFont systemFontOfSize:12.0];
    [lblValue1 setText:@"二维码"];
    [lblValue1 setTextColor:[UIColor blackColor]];
    [lblValue1 setBackgroundColor:[UIColor clearColor]];
    [lblValue1 setTextAlignment:NSTextAlignmentRight];
    [control addSubview:lblValue1];
    
    txtValue1=[[UITextField alloc]initWithFrame:CGRectMake(80, 50, 150, 30)];
    [txtValue1 setFont:[UIFont systemFontOfSize: 12.0]];
    [txtValue1 setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtValue1 setBorderStyle:UITextBorderStyleRoundedRect];
    [txtValue1 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [txtValue1 setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [txtValue1 setKeyboardType:UIKeyboardTypePhonePad];
    [control addSubview:txtValue1];
    
    UIButton *btnCalculate=[[UIButton alloc]initWithFrame:CGRectMake(235, 50, 30, 30)];
    [btnCalculate setBackgroundImage:[UIImage imageNamed:@"sj222"] forState:UIControlStateNormal];
    [btnCalculate addTarget:self action:@selector(scanning:) forControlEvents:UIControlEventTouchUpInside];
    [control addSubview:btnCalculate];
    
    UIButton *btnSubmit=[[UIButton alloc]initWithFrame:CGRectMake(80, 100, 160, 30)];
    [btnSubmit.titleLabel setFont:[UIFont systemFontOfSize: 12.0]];
    [btnSubmit setTitle:@"提交" forState:UIControlStateNormal];
    [btnSubmit setBackgroundColor:[UIColor colorWithRed:(55/255.0) green:(55/255.0) blue:(139/255.0) alpha:1]];
    [btnSubmit addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    [control addSubview:btnSubmit];
    
}

- (void)submit:(id)sender {
    
    NSString *code=[txtValue1 text];
    if([@"" isEqualToString:code]){
        [Common alert:@"请扫描二维码"];
        return;
    }
    twoDimensionalCode=[code stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if([twoDimensionalCode length]==14){
        channl=[twoDimensionalCode substringFromIndex:12];
    }
    
    //获取选中的列中的所在的行
    if([twoDimensionalCode length]==12){
        if(selectrow==0){
            STAggregatorInfoViewController *aggregatorInfoViewController=[[STAggregatorInfoViewController alloc]initWithSerialNo:twoDimensionalCode];
            [self.navigationController pushViewController:aggregatorInfoViewController animated:YES];
        } else {
            [Common alert:@"请扫描采集器！"];
        }
    } else if([twoDimensionalCode length]==14){
        NSString *code=[twoDimensionalCode substringToIndex:12];
        if(selectrow==0){
            [Common alert:@"请选择操作类型！"];
        }else if(selectrow==1) {
            //线路实时信息
            STLineInfoViewController *lineInfoViewController=[[STLineInfoViewController alloc]initWithSerialNo:code channelNo:channl];
            [self.navigationController pushViewController:lineInfoViewController animated:YES];
        } else if(selectrow==2) {
            //更换采集器
            STChangeMaterialViewController *changeMaterialViewController=[[STChangeMaterialViewController alloc]initWithSerialNo:code];
            [self.navigationController pushViewController:changeMaterialViewController animated:YES];
        }
    } else {
        [Common alert:@"二维码不符合规则!"];
    }
}

- (void)scanning:(id)sender {
    STScanningViewController *scanningViewController=[[STScanningViewController alloc]init];
    [scanningViewController setDelegate:self];
    [scanningViewController setResponseCode:500];
    [self presentViewController:scanningViewController animated:YES completion:nil];
}

- (void)backgroundDoneEditing:(id)sender {
    [txtOperation resignFirstResponder];
    [txtValue1 resignFirstResponder];
}

- (void)success:(NSString*)value responseCode:(NSInteger)responseCode{
    [txtValue1 setText:value];
    
//    [txtValue1 performSelectorOnMainThread:@selector(setText:) withObject:value waitUntilDone:NO];
    
    [self backgroundDoneEditing:nil];
}

- (void)pickerDidPressDoneWithRow:(NSInteger)row {
    if([txtOperation isFirstResponder]){
        selectrow=row;
        [txtOperation setText:[selectData objectAtIndex:row]];
        [txtOperation resignFirstResponder];
    }
}

- (void)pickerDidPressCancel{
    if([txtOperation isFirstResponder]){
        [txtOperation resignFirstResponder];
    }
}

@end
