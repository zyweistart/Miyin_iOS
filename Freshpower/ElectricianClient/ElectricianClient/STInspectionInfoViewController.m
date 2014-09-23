//
//  STInspectionInfoViewController.m
//  ElectricianClient
//
//  Created by Start on 3/26/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STInspectionInfoViewController.h"
#import "STTaskAuditRecordViewController.h"
#import "DatePickerView.h"

@interface STInspectionInfoViewController () <DatePickerViewDelegate,UITextFieldDelegate>

@end

@implementation STInspectionInfoViewController {
    UITextField *txtValueView1;
    UITextField *txtValueView2;
    UITextField *txtValueView3;
    UITextField *txtValueView4;
    DatePickerView *datePicker;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.title=@"巡检信息";
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]
                                                initWithTitle:@"返回"
                                                style:UIBarButtonItemStyleBordered
                                                target:self
                                                action:@selector(back:)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    datePicker = [[DatePickerView alloc] init];
    [datePicker setDelegate:self];
    
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *startDate=[NSDate date];
    NSString *startDateStr = [dateFormatter stringFromDate:startDate];
    NSTimeInterval secondsPerDay = 86400*30;
    NSDate *endDate = [startDate dateByAddingTimeInterval:-secondsPerDay];
    NSString *endDateStr = [dateFormatter stringFromDate:endDate];
    
    UIControl *container=[[UIControl alloc]initWithFrame:CGRectMake(0, 70, 320, 220)];
    [container addTarget:self action:@selector(backgroundDoneEditing:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:container];
    
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 90, 30)];
    lbl.font=[UIFont systemFontOfSize:12.0];
    [lbl setText:@"客户名称"];
    [lbl setTextColor:[UIColor blackColor]];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setTextAlignment:NSTextAlignmentRight];
    [container addSubview:lbl];
    
    txtValueView1=[[UITextField alloc]initWithFrame:CGRectMake(105, 10, 150, 30)];
    [txtValueView1 setFont:[UIFont systemFontOfSize: 12.0]];
    [txtValueView1 setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtValueView1 setBorderStyle:UITextBorderStyleRoundedRect];
    [txtValueView1 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [txtValueView1 setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    if([Account isLogin]){
        [txtValueView1 setText:[[Account getResultData]objectForKey:@"NAME"]];
    }
    [container addSubview:txtValueView1];
    
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 50, 90, 30)];
    lbl.font=[UIFont systemFontOfSize:12.0];
    [lbl setText:@"站点名称"];
    [lbl setTextColor:[UIColor blackColor]];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setTextAlignment:NSTextAlignmentRight];
    [container addSubview:lbl];
    
    txtValueView2=[[UITextField alloc]initWithFrame:CGRectMake(105, 50, 150, 30)];
    [txtValueView2 setFont:[UIFont systemFontOfSize: 12.0]];
    [txtValueView2 setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtValueView2 setBorderStyle:UITextBorderStyleRoundedRect];
    [txtValueView2 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [txtValueView2 setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [container addSubview:txtValueView2];
    
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 90, 90, 30)];
    lbl.font=[UIFont systemFontOfSize:12.0];
    [lbl setText:@"任务开始时间"];
    [lbl setTextColor:[UIColor blackColor]];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setTextAlignment:NSTextAlignmentRight];
    [container addSubview:lbl];
    
    txtValueView3=[[UITextField alloc]initWithFrame:CGRectMake(105, 90, 150, 30)];
    [txtValueView3 setFont:[UIFont systemFontOfSize: 12.0]];
    [txtValueView3 setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtValueView3 setBorderStyle:UITextBorderStyleRoundedRect];
    [txtValueView3 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [txtValueView3 setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [txtValueView3 setDelegate:self];
    [txtValueView3 setText:endDateStr];
    [txtValueView3 setInputView:datePicker];
    [container addSubview:txtValueView3];
    
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 130, 90, 30)];
    lbl.font=[UIFont systemFontOfSize:12.0];
    [lbl setText:@"任务结束时间"];
    [lbl setTextColor:[UIColor blackColor]];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setTextAlignment:NSTextAlignmentRight];
    [container addSubview:lbl];
    
    txtValueView4=[[UITextField alloc]initWithFrame:CGRectMake(105, 130, 150, 30)];
    [txtValueView4 setFont:[UIFont systemFontOfSize: 12.0]];
    [txtValueView4 setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtValueView4 setBorderStyle:UITextBorderStyleRoundedRect];
    [txtValueView4 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [txtValueView4 setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [txtValueView4 setDelegate:self];
    [txtValueView4 setText:startDateStr];
    [txtValueView4 setInputView:datePicker];
    [container addSubview:txtValueView4];
    
    //查询
    UIButton *btnSearch=[[UIButton alloc]initWithFrame:CGRectMake(80, 180, 160, 30)];
    [btnSearch setTitle:@"查询" forState:UIControlStateNormal];
    btnSearch.titleLabel.font=[UIFont systemFontOfSize: 12.0];
    [btnSearch  setBackgroundColor:[UIColor colorWithRed:(55/255.0) green:(55/255.0) blue:(139/255.0) alpha:1]];
    [btnSearch addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
    [container addSubview:btnSearch];
}

- (void)backgroundDoneEditing:(id)sender
{
    [txtValueView1 resignFirstResponder];
    [txtValueView2 resignFirstResponder];
    [txtValueView3 resignFirstResponder];
    [txtValueView4 resignFirstResponder];
}

- (void)search:(id)sender
{
    NSString *value1=[txtValueView1 text];
    if([@"" isEqualToString:value1]){
        [Common alert:@"请输入客户名称!"];
        return;
    }
    NSString *value3=[txtValueView3 text];
    if([@"" isEqualToString:value3]){
        [Common alert:@"请选择开始日期!"];
        return;
    }
    NSString *value4=[txtValueView4 text];
    if([@"" isEqualToString:value4]){
        [Common alert:@"请选择结束日期!"];
        return;
    }
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *startDate=[dateFormatter dateFromString:value4];
    NSTimeInterval secondsPerDay = 86400*1;
    NSDate *endDate = [startDate dateByAddingTimeInterval:secondsPerDay];
    NSString *endDateStr=[dateFormatter stringFromDate:endDate];
    STTaskAuditRecordViewController *taskAuditRecordViewController=[[STTaskAuditRecordViewController alloc]init];
    [taskAuditRecordViewController setCpName:value1];
    [taskAuditRecordViewController setSiteName:[txtValueView2 text]];
    [taskAuditRecordViewController setStartDay:value3];
    [taskAuditRecordViewController setEndDay:endDateStr];
    
    [self.navigationController pushViewController:taskAuditRecordViewController animated:YES];
    
    [taskAuditRecordViewController autoRefresh];
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
    if([txtValueView3 isFirstResponder]){
        [txtValueView3 setText:currentDateStr];
        [txtValueView3 resignFirstResponder];
    }
    if([txtValueView4 isFirstResponder]){
        [txtValueView4 setText:currentDateStr];
        [txtValueView4 resignFirstResponder];
    }
}

- (void)pickerDidPressCancel {
    if([txtValueView3 isFirstResponder]){
        [txtValueView3 resignFirstResponder];
    }
    if([txtValueView4 isFirstResponder]){
        [txtValueView4 resignFirstResponder];
    }
}

@end
