//
//  STElectricityDetailViewController.m
//  ElectricianClient
//
//  Created by Start on 3/26/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STElectricityDetailViewController.h"
#import "DataPickerView.h"
#import "DatePickerView.h"
#import "STRows4View.h"
#import "STElectricityView.h"

@interface STElectricityDetailViewController ()<DataPickerViewDelegate,DatePickerViewDelegate,UITextFieldDelegate>

@end

@implementation STElectricityDetailViewController{
    NSDictionary *_data;
    UITextField *txtSearch;
    UITextField *txtSearchDate;
    NSArray *searchType;
    DataPickerView *searchTypedpv;
    DatePickerView *datePicker;
    int searchTypeValue;
    STRows4View *rv0;
    UIView *container;
    STElectricityView *electricityView;
}

- (id)initWithData:(NSDictionary*)data selectType:(int)selectType
{
    searchTypeValue=selectType;
    self = [super init];
    if (self) {
        self.title=@"详细电费";
        _data=data;
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]
                                                           initWithTitle:@"搜索"
                                                           style:UIBarButtonItemStyleBordered
                                                           target:self
                                                           action:@selector(search:)];
        
        datePicker = [[DatePickerView alloc] init];
        [datePicker setDelegate:self];
        
        container=[[UIView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:container];
        rv0=[[STRows4View alloc]initWithFrame:CGRectMake(0, 10, self.view.frame.size.height,30)];
        [container addSubview: rv0];
        [[rv0 lbl1]setText:[_data objectForKey:@"METER_NAME"]];
        
        electricityView=[[STElectricityView alloc]initWithFrame:CGRectMake(10, 40, 300, 130)];
        [container addSubview:electricityView];
    }
    return self;
}

- (void)search:(id)sender
{
    searchType=[[NSArray alloc]initWithObjects:
                @"按日查询",@"按月查询", nil];
    searchTypedpv=[[DataPickerView alloc]initWithData:searchType];
    [searchTypedpv setDelegate:self];
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"历史查询"
                          message:nil
                          delegate:self
                          cancelButtonTitle:@"取消"
                          otherButtonTitles:@"确定",nil];
    [alert setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
    txtSearch=[alert textFieldAtIndex:0];
    [txtSearch setInputView:searchTypedpv];
    [txtSearch setPlaceholder:@""];
    [txtSearch setText:[searchType objectAtIndex:searchTypeValue]];
    
    txtSearchDate= [alert textFieldAtIndex:1];
    [txtSearchDate setPlaceholder:@"请选择日期"];
    [txtSearchDate setSecureTextEntry:NO];
    [txtSearchDate setInputView:datePicker];
    [alert show];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSString *d=[textField text];
    if(![@"" isEqualToString:d]){
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        if(searchTypeValue==0){
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        }else{
            [dateFormatter setDateFormat:@"yyyy-MM"];
        }
        NSDate *date = [dateFormatter dateFromString:d];
        [[datePicker datePicker]setDate:date];
    }
}

- (void)pickerDidPressDoneWithDate:(NSDate*)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if(searchTypeValue==0){
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    }else{
        [dateFormatter setDateFormat:@"yyyy-MM"];
    }
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    if([txtSearchDate isFirstResponder]){
        [txtSearchDate setText:currentDateStr];
        [txtSearchDate resignFirstResponder];
    }
}

- (void)pickerDidPressDoneWithRow:(NSInteger)row {
    if([txtSearch isFirstResponder]){
        if(searchTypeValue!=row){
            [txtSearchDate setText:@""];
            searchTypeValue=row;
            [txtSearch setText:[searchType objectAtIndex:searchTypeValue]];
        }
        [txtSearch resignFirstResponder];
    }
}

- (void)pickerDidPressCancel {
    if([txtSearch isFirstResponder]){
        [txtSearch resignFirstResponder];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1){
        [self loadData];
    }
}

- (void)loadData{
    NSMutableDictionary *p=[[NSMutableDictionary alloc]init];
    [p setObject:[Account getUserName] forKey:@"imei"];
    [p setObject:[Account getPassword] forKey:@"authentication"];
    [p setObject:[[Account getResultData]objectForKey:@"CP_ID"] forKey:@"CP_ID"];
    [p setObject:[NSString stringWithFormat:@"%@",[_data objectForKey:@"METER_ID"]] forKey:@"MeterID"];
    [p setObject:[NSString stringWithFormat:@"%@",searchTypeValue==0?@"Day":@"Month"] forKey:@"SelectType"];
    
    NSString *date=[txtSearchDate text];
    if(date!=nil&&![@"" isEqualToString:date]){
        [p setObject:date forKey:@"sDate"];
        [p setObject:date forKey:@"eDate"];
    }
    self.hRequest=[[HttpRequest alloc]init:self delegate:self responseCode:500];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest start:URLAppHisMeterElec params:p];
}

- (void)requestFinishedByResponse:(Response*)response responseCode:(int)repCode{
    [container setHidden:YES];
    NSDictionary *data=[response resultJSON];
    if(data!=nil){
        NSDictionary *rows=[data objectForKey:@"Rows"];
        int result=[[rows objectForKey:@"result"] intValue];
        if(result==1){
            NSMutableArray *tmpData=[data objectForKey:@"MeterHisElecList"];
            if(tmpData){
                for(NSDictionary *d in tmpData){
                    [container setHidden:NO];
                    [[electricityView lblAvgPrice] setText:[Common NSNullConvertEmptyString:[d objectForKey:@"AvgPrice"]]];
                    [[rv0 lbl4]setText:[Common NSNullConvertEmptyString:[d objectForKey:@"Date"]]];
                    [[[electricityView rv2] lbl2]setText:[Common NSNullConvertEmptyString:[d objectForKey:@"TotalPower"]]];
                    [[[electricityView rv2] lbl3]setText:[Common NSNullConvertEmptyString:[d objectForKey:@"TotalFee"]]];
                    [[[electricityView rv3] lbl2]setText:[Common NSNullConvertEmptyString:[d objectForKey:@"TipPower"]]];
                    [[[electricityView rv3] lbl3]setText:[Common NSNullConvertEmptyString:[d objectForKey:@"TipFee"]]];
                    [[[electricityView rv4] lbl2]setText:[Common NSNullConvertEmptyString:[d objectForKey:@"PeakPower"]]];
                    [[[electricityView rv4] lbl3]setText:[Common NSNullConvertEmptyString:[d objectForKey:@"PeakFee"]]];
                    [[[electricityView rv5] lbl2]setText:[Common NSNullConvertEmptyString:[d objectForKey:@"ValleyPower"]]];
                    [[[electricityView rv5] lbl3]setText:[Common NSNullConvertEmptyString:[d objectForKey:@"ValleyFee"]]];
                    break;
                }
            }else{
                [Common alert:@"查询无数据"];
            }
        }else{
            [Common alert:[rows objectForKey:@"remark"]];
        }
    }else{
        [Common alert:@"数据解析异常"];
    }
}

@end
