//
//  STDataMonitoringLineDetailSearchViewController.m
//  ElectricianRun
//
//  Created by Start on 2/22/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STDataMonitoringLineDetailSearchViewController.h"
#import "STDataMonitoringLineDetailListViewController.h"

@interface STDataMonitoringLineDetailSearchViewController ()

@end

@implementation STDataMonitoringLineDetailSearchViewController {
    
    DatePickerView *datePicker;
    
    UITextField *txtStartValue;
    UITextField *txtEndValue;
}


- (id)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        
        self.title=@"历史数据查询";
        
        self.data=data;
        
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]
                                                initWithTitle:@"查询"
                                                style:UIBarButtonItemStyleBordered
                                                target:self
                                                action:@selector(search:)];
        
    }
    return self;
}

//查询
- (void)search:(id)sender{
    NSString *startDay=[txtStartValue text];
    NSString *endDay=[txtEndValue text];
    STDataMonitoringLineDetailListViewController *dataMonitoringLineDetailListViewController=[[STDataMonitoringLineDetailListViewController alloc]initWithData:self.data lastMonthSearch:NO];
    [dataMonitoringLineDetailListViewController setStartDay:startDay];
    [dataMonitoringLineDetailListViewController setEndDay:endDay];
    [self.navigationController pushViewController:dataMonitoringLineDetailListViewController animated:YES];
    [dataMonitoringLineDetailListViewController autoRefresh];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    datePicker = [[DatePickerView alloc] initWithPickerMode:UIDatePickerModeDateAndTime];
    [datePicker setDelegate:self];
    
    UIControl *control=[[UIControl alloc]initWithFrame:CGRectMake(0, 100, 320, 90)];
    [self.view addSubview:control];
    
    UILabel *lblName=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 90, 30)];
    lblName.font=[UIFont systemFontOfSize:12.0];
    [lblName setText:@"开始时间"];
    [lblName setTextColor:[UIColor blackColor]];
    [lblName setBackgroundColor:[UIColor clearColor]];
    [lblName setTextAlignment:NSTextAlignmentRight];
    [control addSubview:lblName];
    
    txtStartValue=[[UITextField alloc]initWithFrame:CGRectMake(105, 10, 150, 30)];
    [txtStartValue setFont:[UIFont systemFontOfSize: 12.0]];
    [txtStartValue setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtStartValue setBorderStyle:UITextBorderStyleRoundedRect];
    [txtStartValue setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [txtStartValue setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [txtStartValue setDelegate:self];
    [txtStartValue setInputView:datePicker];
    [control addSubview:txtStartValue];
    
    lblName=[[UILabel alloc]initWithFrame:CGRectMake(10, 50, 90, 30)];
    lblName.font=[UIFont systemFontOfSize:12.0];
    [lblName setText:@"结束时间"];
    [lblName setTextColor:[UIColor blackColor]];
    [lblName setBackgroundColor:[UIColor clearColor]];
    [lblName setTextAlignment:NSTextAlignmentRight];
    [control addSubview:lblName];
    
    txtEndValue=[[UITextField alloc]initWithFrame:CGRectMake(105, 50, 150, 30)];
    [txtEndValue setFont:[UIFont systemFontOfSize: 12.0]];
    [txtEndValue setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtEndValue setBorderStyle:UITextBorderStyleRoundedRect];
    [txtEndValue setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [txtEndValue setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [txtEndValue setDelegate:self];
    [txtEndValue setInputView:datePicker];
    [control addSubview:txtEndValue];
    
}

#pragma mark - Delegate
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
    if([txtStartValue isFirstResponder]){
        [txtStartValue setText:currentDateStr];
        [txtStartValue resignFirstResponder];
    }
    if([txtEndValue isFirstResponder]){
        [txtEndValue setText:currentDateStr];
        [txtEndValue resignFirstResponder];
    }
}

- (void)pickerDidPressCancel {
    if([txtStartValue isFirstResponder]){
        [txtStartValue resignFirstResponder];
    }
    if([txtEndValue isFirstResponder]){
        [txtEndValue resignFirstResponder];
    }
}

@end

