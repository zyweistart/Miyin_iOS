//
//  STGPSSearchViewController.m
//  ElectricianRun
//
//  Created by Start on 3/9/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STGPSSearchViewController.h"
#import "DatePickerView.h"
#import "DataPickerView.h"

@interface STGPSSearchViewController () <DatePickerViewDelegate,DataPickerViewDelegate,UITextFieldDelegate>

@end

@implementation STGPSSearchViewController {
    DatePickerView *datePicker;
    DataPickerView *sectionTime;
    UITextField *txtValuePhone;
    UITextField *txtValueStartDay;
    UITextField *txtValueEndDay;
    UILabel *lblTimeSection;
    UITextField *txtValueTimeSection;
    NSMutableArray *timeSectionData;//时间阶段数据
    
    UIButton *btnReset;
    UIButton *btnLocation;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.title=@"GPS轨迹查看";
        [self.view setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)buildUIQuantum:(NSMutableArray*)quantum
{
    if([self.delegate searchData]){
        self.title=[NSString stringWithFormat:@"GPS轨迹查看(%@)",[[self.delegate searchData] objectForKey:@"userName"]];
    }
    
    datePicker = [[DatePickerView alloc]initWithPickerMode:UIDatePickerModeDateAndTime];
    [datePicker setDelegate:self];
    timeSectionData=[[NSMutableArray alloc]init];
    [timeSectionData addObject:@"请选择时间段"];
    if(quantum!=nil){
        for(NSDictionary *d in quantum){
            [timeSectionData addObject:[d objectForKey:@"dateValue"]];
        }
    }
    sectionTime=[[DataPickerView alloc]initWithData:timeSectionData];
    [sectionTime setDelegate:self];
    
    ///////////////////////
    
    UIControl *control=[[UIControl alloc]initWithFrame:CGRectMake(0, 80, 320, 210)];
    [control addTarget:self action:@selector(backgroundDoneEditing:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:control];
    
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 90, 30)];
    lbl.font=[UIFont systemFontOfSize:12.0];
    [lbl setText:@"手机号码"];
    [lbl setTextColor:[UIColor blackColor]];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setTextAlignment:NSTextAlignmentRight];
    [control addSubview:lbl];
    
    txtValuePhone=[[UITextField alloc]initWithFrame:CGRectMake(105, 10, 150, 30)];
    [txtValuePhone setFont:[UIFont systemFontOfSize: 12.0]];
    [txtValuePhone setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtValuePhone setBorderStyle:UITextBorderStyleRoundedRect];
    [txtValuePhone setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [txtValuePhone setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [txtValuePhone setKeyboardType:UIKeyboardTypePhonePad];
    [txtValuePhone setPlaceholder:@"请输入手机号码"];
    [control addSubview:txtValuePhone];
    
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 50, 90, 30)];
    lbl.font=[UIFont systemFontOfSize:12.0];
    [lbl setText:@"开始时间"];
    [lbl setTextColor:[UIColor blackColor]];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setTextAlignment:NSTextAlignmentRight];
    [control addSubview:lbl];
    
    txtValueStartDay=[[UITextField alloc]initWithFrame:CGRectMake(105, 50, 150, 30)];
    [txtValueStartDay setFont:[UIFont systemFontOfSize: 12.0]];
    [txtValueStartDay setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtValueStartDay setBorderStyle:UITextBorderStyleRoundedRect];
    [txtValueStartDay setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [txtValueStartDay setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [txtValueStartDay setDelegate:self];
    [txtValueStartDay setPlaceholder:@"请选择开始时间"];
    [txtValueStartDay setInputView:datePicker];
    [control addSubview:txtValueStartDay];
    
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 90, 90, 30)];
    lbl.font=[UIFont systemFontOfSize:12.0];
    [lbl setText:@"结束时间"];
    [lbl setTextColor:[UIColor blackColor]];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setTextAlignment:NSTextAlignmentRight];
    [control addSubview:lbl];
    
    txtValueEndDay=[[UITextField alloc]initWithFrame:CGRectMake(105, 90, 150, 30)];
    [txtValueEndDay setFont:[UIFont systemFontOfSize: 12.0]];
    [txtValueEndDay setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtValueEndDay setBorderStyle:UITextBorderStyleRoundedRect];
    [txtValueEndDay setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [txtValueEndDay setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [txtValueEndDay setDelegate:self];
    [txtValueEndDay setPlaceholder:@"请选择结束时间"];
    [txtValueEndDay setInputView:datePicker];
    [control addSubview:txtValueEndDay];
    
    lblTimeSection=[[UILabel alloc]initWithFrame:CGRectMake(10, 130, 90, 30)];
    lblTimeSection.font=[UIFont systemFontOfSize:12.0];
    [lblTimeSection setText:@"选择时间段"];
    [lblTimeSection setTextColor:[UIColor blackColor]];
    [lblTimeSection setBackgroundColor:[UIColor clearColor]];
    [lblTimeSection setTextAlignment:NSTextAlignmentRight];
    [control addSubview:lblTimeSection];
    
    txtValueTimeSection=[[UITextField alloc]initWithFrame:CGRectMake(105, 130, 150, 30)];
    [txtValueTimeSection setFont:[UIFont systemFontOfSize: 12.0]];
    [txtValueTimeSection setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtValueTimeSection setBorderStyle:UITextBorderStyleRoundedRect];
    [txtValueTimeSection setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [txtValueTimeSection setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [txtValueTimeSection setPlaceholder:@"请选择时间段"];
    [txtValueTimeSection setInputView:sectionTime];
    [control addSubview:txtValueTimeSection];
    
    btnLocation=[[UIButton alloc]initWithFrame:CGRectMake(40, 170, 100, 30)];
    [btnLocation setTitle:@"位置" forState:UIControlStateNormal];
    btnLocation.titleLabel.font=[UIFont systemFontOfSize: 12.0];
    [btnLocation  setBackgroundColor:BTNCOLORGB];
    [btnLocation addTarget:self action:@selector(location:) forControlEvents:UIControlEventTouchUpInside];
    [control addSubview:btnLocation];
    
    btnReset=[[UIButton alloc]initWithFrame:CGRectMake(40, 170, 100, 30)];
    [btnReset setTitle:@"重置" forState:UIControlStateNormal];
    btnReset.titleLabel.font=[UIFont systemFontOfSize: 12.0];
    [btnReset  setBackgroundColor:BTNCOLORGB];
    [btnReset addTarget:self action:@selector(reset:) forControlEvents:UIControlEventTouchUpInside];
    [control addSubview:btnReset];
    
    UIButton *btn2=[[UIButton alloc]initWithFrame:CGRectMake(180, 170, 100, 30)];
    [btn2 setTitle:@"轨迹" forState:UIControlStateNormal];
    btn2.titleLabel.font=[UIFont systemFontOfSize: 12.0];
    [btn2  setBackgroundColor:BTNCOLORGB];
    [btn2 addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
    [control addSubview:btn2];
    
    [self setFormValue];
}

- (void)setFormValue
{
    if([self.delegate searchData]){
        [txtValuePhone setText:[[self.delegate searchData] objectForKey:@"phoneNum"]];
        [txtValuePhone setEnabled:NO];
        [txtValueStartDay setText:[[self.delegate searchData] objectForKey:@"startDate"]];
        [txtValueStartDay setEnabled:NO];
        [txtValueEndDay setText:[[self.delegate searchData] objectForKey:@"endDate"]];
        [txtValueEndDay setEnabled:NO];
        [lblTimeSection setHidden:NO];
        [txtValueTimeSection setHidden:NO];
        [btnReset setHidden:NO];
        [btnLocation setHidden:YES];
    }else{
        [txtValuePhone setText:@""];
        [txtValuePhone setEnabled:YES];
        [txtValueStartDay setText:@""];
        [txtValueStartDay setEnabled:YES];
        [txtValueEndDay setText:@""];
        [txtValueEndDay setEnabled:YES];
        [lblTimeSection setHidden:YES];
        [txtValueTimeSection setHidden:YES];
        [btnReset setHidden:YES];
        [btnLocation setHidden:NO];
    }
}

- (void)backgroundDoneEditing:(id)sender
{
    [txtValuePhone resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSString *d=[textField text];
    if(![@"" isEqualToString:d]){
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm"];
        NSDate *date = [dateFormatter dateFromString:d];
        [[datePicker datePicker]setDate:date];
    }
}

- (void)pickerDidPressDoneWithDate:(NSDate*)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm"];
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    if([txtValueStartDay isFirstResponder]){
        [txtValueStartDay setText:currentDateStr];
        [txtValueStartDay resignFirstResponder];
    }
    if([txtValueEndDay isFirstResponder]){
        [txtValueEndDay setText:currentDateStr];
        [txtValueEndDay resignFirstResponder];
    }
}

- (void)pickerDidPressDoneWithRow:(NSInteger)row {
    if([txtValueTimeSection isFirstResponder]){
        if(row!=0){
            [txtValueTimeSection setText:[timeSectionData objectAtIndex:row]];
        }
        [txtValueTimeSection resignFirstResponder];
    }
}

- (void)pickerDidPressCancel {
    if([txtValueStartDay isFirstResponder]){
        [txtValueStartDay resignFirstResponder];
    }
    if([txtValueEndDay isFirstResponder]){
        [txtValueEndDay resignFirstResponder];
    }
    if([txtValueTimeSection isFirstResponder]){
        [txtValueTimeSection resignFirstResponder];
    }
}

- (void)reset:(id)sender
{
    [self.delegate setSearchData:nil];
    [self setFormValue];
}

- (void)location:(id)sender
{
    NSString *phone=[txtValuePhone text];
    if([@"" isEqualToString:phone]){
        [Common alert:@"手机号码不能为空"];
        return;
    }
//    NSString *startDay=[txtValueStartDay text];
//    if([@"" isEqualToString:startDay]){
//        [Common alert:@"开始时间不能为空"];
//        return;
//    }
//    NSString *endDay=[txtValueEndDay text];
//    if([@"" isEqualToString:endDay]){
//        [Common alert:@"结束时间不能为空"];
//        return;
//    }
    NSMutableDictionary *sdata=[[NSMutableDictionary alloc]init];
    [sdata setObject:phone forKey:@"phoneNum"];
//    [sdata setObject:startDay forKey:@"startDate"];
//    [sdata setObject:endDay forKey:@"endDate"];
    [self.delegate startSearch:sdata responseCode:120];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)search:(id)sender
{
    NSString *phone=[txtValuePhone text];
    if([@"" isEqualToString:phone]){
        [Common alert:@"手机号码不能为空"];
        return;
    }
    NSString *startDay=[txtValueStartDay text];
    if([@"" isEqualToString:startDay]){
        [Common alert:@"开始时间不能为空"];
        return;
    }
    NSString *endDay=[txtValueEndDay text];
    if([@"" isEqualToString:endDay]){
        [Common alert:@"结束时间不能为空"];
        return;
    }
    NSMutableDictionary *sdata=[[NSMutableDictionary alloc]init];
    [sdata setObject:phone forKey:@"phoneNum"];
    [sdata setObject:startDay forKey:@"startDate"];
    [sdata setObject:endDay forKey:@"endDate"];
    if([self.delegate searchData]){
        NSString *timeSection=[txtValueTimeSection text];
        if(![@"" isEqualToString:timeSection]){
            [sdata setObject:timeSection forKey:@"rvalue"];
        }
        [sdata setObject:[[self.delegate searchData] objectForKey:@"UUID"] forKey:@"UUID"];
        [sdata setObject:[[self.delegate searchData] objectForKey:@"userId"] forKey:@"userId"];
        [sdata setObject:[[self.delegate searchData] objectForKey:@"rtype"] forKey:@"rtype"];
        [self.delegate startSearch:sdata responseCode:180];
    }else{
        [self.delegate startSearch:sdata responseCode:150];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end