//
//  STTaskAuditViewController.m
//  ElectricianRun
//  任务稽核
//  Created by Start on 1/25/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STTaskAuditViewController.h"
#import "STTaskAuditBuildViewController.h"
#import "STTaskAuditRecordViewController.h"
#import "STTaskAuditMapViewController.h"

@interface STTaskAuditViewController () <DatePickerViewDelegate>

@end

@implementation STTaskAuditViewController {
    DatePickerView *datePicker;
    UIButton *btnBuilder;
    UIButton *btnRecording;
    
    UIControl *view1;
    UIControl *view2;
    UITextField *txtValueView11;
    UITextField *txtValueView12;
    
    UITextField *txtValueView21;
    UITextField *txtValueView22;
    UITextField *txtValueView23;
    UITextField *txtValueView24;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"任务稽核";
        
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]
                                               initWithTitle:@"返回"
                                               style:UIBarButtonItemStyleBordered
                                               target:self
                                               action:@selector(back:)];
        
    }
    return self;
}

- (void)back:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIControl *control=[[UIControl alloc]initWithFrame:CGRectMake(0, 64, 320, 300)];
    [self.view addSubview:control];
    
    datePicker = [[DatePickerView alloc] init];
    [datePicker setDelegate:self];
    
    btnBuilder=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 110, 40)];
    btnBuilder.titleLabel.font=[UIFont systemFontOfSize:12.0f];
    [btnBuilder setTitle:@"巡检任务生成" forState:UIControlStateNormal];
    [btnBuilder setBackgroundColor:[UIColor colorWithRed:(55/255.0) green:(55/255.0) blue:(139/255.0) alpha:1]];
    [btnBuilder addTarget:self action:@selector(build:) forControlEvents:UIControlEventTouchUpInside];
    [control addSubview:btnBuilder];
    
    btnRecording=[[UIButton alloc]initWithFrame:CGRectMake(110, 0, 100, 40)];
    btnRecording.titleLabel.font=[UIFont systemFontOfSize:12.0f];
    [btnRecording setTitle:@"巡检记录" forState:UIControlStateNormal];
    [btnRecording setBackgroundColor:[UIColor colorWithRed:(210/255.0) green:(85/255.0) blue:(24/255.0) alpha:1]];
    [btnRecording addTarget:self action:@selector(recording:) forControlEvents:UIControlEventTouchUpInside];
    [control addSubview:btnRecording];
    
    UIButton *btn3=[[UIButton alloc]initWithFrame:CGRectMake(210, 0, 110, 40)];
    btn3.titleLabel.font=[UIFont systemFontOfSize:12.0f];
    [btn3 setTitle:@"工作人员位置" forState:UIControlStateNormal];
    [btn3 setBackgroundColor:[UIColor colorWithRed:(210/255.0) green:(85/255.0) blue:(24/255.0) alpha:1]];
    [btn3 addTarget:self action:@selector(maplocation:) forControlEvents:UIControlEventTouchUpInside];
    [control addSubview:btn3];
    
    view1=[[UIControl alloc]initWithFrame:CGRectMake(0, 80, 320, 130)];
    [view1 setHidden:NO];
    [view1 addTarget:self action:@selector(backgroundDoneEditing:) forControlEvents:UIControlEventTouchDown];
    [control addSubview:view1];
    
    UILabel *lblName=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 90, 30)];
    lblName.font=[UIFont systemFontOfSize:12.0];
    [lblName setText:@"客户名称"];
    [lblName setTextColor:[UIColor blackColor]];
    [lblName setBackgroundColor:[UIColor clearColor]];
    [lblName setTextAlignment:NSTextAlignmentRight];
    [view1 addSubview:lblName];
    
    txtValueView11=[[UITextField alloc]initWithFrame:CGRectMake(105, 10, 150, 30)];
    [txtValueView11 setFont:[UIFont systemFontOfSize: 12.0]];
    [txtValueView11 setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtValueView11 setBorderStyle:UITextBorderStyleRoundedRect];
    [txtValueView11 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [txtValueView11 setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [view1 addSubview:txtValueView11];
    
    lblName=[[UILabel alloc]initWithFrame:CGRectMake(10, 50, 90, 30)];
    lblName.font=[UIFont systemFontOfSize:12.0];
    [lblName setText:@"站点名称"];
    [lblName setTextColor:[UIColor blackColor]];
    [lblName setBackgroundColor:[UIColor clearColor]];
    [lblName setTextAlignment:NSTextAlignmentRight];
    [view1 addSubview:lblName];
    
    txtValueView12=[[UITextField alloc]initWithFrame:CGRectMake(105, 50, 150, 30)];
    [txtValueView12 setFont:[UIFont systemFontOfSize: 12.0]];
    [txtValueView12 setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtValueView12 setBorderStyle:UITextBorderStyleRoundedRect];
    [txtValueView12 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [txtValueView12 setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [view1 addSubview:txtValueView12];
    
    //查询
    UIButton *btnSearch=[[UIButton alloc]initWithFrame:CGRectMake(80, 90, 160, 30)];
    [btnSearch setTitle:@"查询" forState:UIControlStateNormal];
    btnSearch.titleLabel.font=[UIFont systemFontOfSize: 12.0];
    [btnSearch setBackgroundColor:[UIColor colorWithRed:(55/255.0) green:(55/255.0) blue:(139/255.0) alpha:1]];
//    [btnSearch setBackgroundImage:[UIImage imageNamed:@"button_gb"] forState:UIControlStateNormal];
    [btnSearch addTarget:self action:@selector(search1:) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:btnSearch];
    
    ///////////////////////
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *startDate=[NSDate date];
    NSString *startDateStr = [dateFormatter stringFromDate:startDate];
    NSTimeInterval secondsPerDay = 86400*30;
    NSDate *endDate = [startDate dateByAddingTimeInterval:-secondsPerDay];
    NSString *endDateStr = [dateFormatter stringFromDate:endDate];
    
    view2=[[UIControl alloc]initWithFrame:CGRectMake(0, 80, 320, 210)];
    [view2 setHidden:YES];
    [view2 addTarget:self action:@selector(backgroundDoneEditing:) forControlEvents:UIControlEventTouchDown];
    [control addSubview:view2];
    
    lblName=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 90, 30)];
    lblName.font=[UIFont systemFontOfSize:12.0];
    [lblName setText:@"客户名称"];
    [lblName setTextColor:[UIColor blackColor]];
    [lblName setBackgroundColor:[UIColor clearColor]];
    [lblName setTextAlignment:NSTextAlignmentRight];
    [view2 addSubview:lblName];
    
    txtValueView21=[[UITextField alloc]initWithFrame:CGRectMake(105, 10, 150, 30)];
    [txtValueView21 setFont:[UIFont systemFontOfSize: 12.0]];
    [txtValueView21 setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtValueView21 setBorderStyle:UITextBorderStyleRoundedRect];
    [txtValueView21 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [txtValueView21 setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [view2 addSubview:txtValueView21];
    
    lblName=[[UILabel alloc]initWithFrame:CGRectMake(10, 50, 90, 30)];
    lblName.font=[UIFont systemFontOfSize:12.0];
    [lblName setText:@"站点名称"];
    [lblName setTextColor:[UIColor blackColor]];
    [lblName setBackgroundColor:[UIColor clearColor]];
    [lblName setTextAlignment:NSTextAlignmentRight];
    [view2 addSubview:lblName];
    
    txtValueView22=[[UITextField alloc]initWithFrame:CGRectMake(105, 50, 150, 30)];
    [txtValueView22 setFont:[UIFont systemFontOfSize: 12.0]];
    [txtValueView22 setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtValueView22 setBorderStyle:UITextBorderStyleRoundedRect];
    [txtValueView22 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [txtValueView22 setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [view2 addSubview:txtValueView22];
    
    lblName=[[UILabel alloc]initWithFrame:CGRectMake(10, 90, 90, 30)];
    lblName.font=[UIFont systemFontOfSize:12.0];
    [lblName setText:@"任务开始时间"];
    [lblName setTextColor:[UIColor blackColor]];
    [lblName setBackgroundColor:[UIColor clearColor]];
    [lblName setTextAlignment:NSTextAlignmentRight];
    [view2 addSubview:lblName];
    
    txtValueView23=[[UITextField alloc]initWithFrame:CGRectMake(105, 90, 150, 30)];
    [txtValueView23 setFont:[UIFont systemFontOfSize: 12.0]];
    [txtValueView23 setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtValueView23 setBorderStyle:UITextBorderStyleRoundedRect];
    [txtValueView23 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [txtValueView23 setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [txtValueView23 setDelegate:self];
    [txtValueView23 setText:endDateStr];
    [txtValueView23 setInputView:datePicker];
    [view2 addSubview:txtValueView23];
    
    lblName=[[UILabel alloc]initWithFrame:CGRectMake(10, 130, 90, 30)];
    lblName.font=[UIFont systemFontOfSize:12.0];
    [lblName setText:@"任务结束时间"];
    [lblName setTextColor:[UIColor blackColor]];
    [lblName setBackgroundColor:[UIColor clearColor]];
    [lblName setTextAlignment:NSTextAlignmentRight];
    [view2 addSubview:lblName];
    
    txtValueView24=[[UITextField alloc]initWithFrame:CGRectMake(105, 130, 150, 30)];
    [txtValueView24 setFont:[UIFont systemFontOfSize: 12.0]];
    [txtValueView24 setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtValueView24 setBorderStyle:UITextBorderStyleRoundedRect];
    [txtValueView24 setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [txtValueView24 setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [txtValueView24 setDelegate:self];
    [txtValueView24 setText:startDateStr];
    [txtValueView24 setInputView:datePicker];
    [view2 addSubview:txtValueView24];
    
    //查询
    btnSearch=[[UIButton alloc]initWithFrame:CGRectMake(80, 170, 160, 30)];
    [btnSearch setTitle:@"查询" forState:UIControlStateNormal];
    btnSearch.titleLabel.font=[UIFont systemFontOfSize: 12.0];
    [btnSearch  setBackgroundColor:[UIColor colorWithRed:(55/255.0) green:(55/255.0) blue:(139/255.0) alpha:1]];
    [btnSearch addTarget:self action:@selector(search2:) forControlEvents:UIControlEventTouchUpInside];
    [view2 addSubview:btnSearch];
    
}

- (void)build:(id)sender {
    
    [btnBuilder setBackgroundColor:[UIColor colorWithRed:(55/255.0) green:(55/255.0) blue:(139/255.0) alpha:1]];
    [btnRecording setBackgroundColor:[UIColor colorWithRed:(210/255.0) green:(85/255.0) blue:(24/255.0) alpha:1]];
    
    [view1 setHidden:NO];
    [view2 setHidden:YES];
    [self backgroundDoneEditing:nil];
}

- (void)recording:(id)sender {
    [btnBuilder setBackgroundColor:[UIColor colorWithRed:(210/255.0) green:(85/255.0) blue:(24/255.0) alpha:1]];
    [btnRecording setBackgroundColor:[UIColor colorWithRed:(55/255.0) green:(55/255.0) blue:(139/255.0) alpha:1]];
    
    [view1 setHidden:YES];
    [view2 setHidden:NO];
    [self backgroundDoneEditing:nil];
}

- (void)search1:(id)sender {
    STTaskAuditBuildViewController *taskAuditBuildViewController=[[STTaskAuditBuildViewController alloc]init];
    [taskAuditBuildViewController setCpName:[txtValueView11 text]];
    [taskAuditBuildViewController setSiteName:[txtValueView12 text]];
    [self.navigationController pushViewController:taskAuditBuildViewController animated:YES];
    [taskAuditBuildViewController autoRefresh];
}

- (void)search2:(id)sender {
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *startDate=[dateFormatter dateFromString:[txtValueView24 text]];
    NSTimeInterval secondsPerDay = 86400*1;
    NSDate *endDate = [startDate dateByAddingTimeInterval:secondsPerDay];
    NSString *endDateStr=[dateFormatter stringFromDate:endDate];
    STTaskAuditRecordViewController *taskAuditRecordViewController=[[STTaskAuditRecordViewController alloc]init];
    [taskAuditRecordViewController setCpName:[txtValueView21 text]];
    [taskAuditRecordViewController setSiteName:[txtValueView22 text]];
    [taskAuditRecordViewController setStartDay:[txtValueView23 text]];
    [taskAuditRecordViewController setEndDay:endDateStr];
    
    [self.navigationController pushViewController:taskAuditRecordViewController animated:YES];
    
    [taskAuditRecordViewController autoRefresh];
}

- (void)maplocation:(id)sender {
    STTaskAuditMapViewController *taskAuditMapViewController=[[STTaskAuditMapViewController alloc]init];
    [self.navigationController pushViewController:taskAuditMapViewController animated:YES];
}

- (void)backgroundDoneEditing:(id)sender {
    [txtValueView11 resignFirstResponder];
    [txtValueView12 resignFirstResponder];
    [txtValueView21 resignFirstResponder];
    [txtValueView22 resignFirstResponder];
    [txtValueView23 resignFirstResponder];
    [txtValueView24 resignFirstResponder];
}

#pragma mark - Delegate
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
    if([txtValueView23 isFirstResponder]){
        [txtValueView23 setText:currentDateStr];
        [txtValueView23 resignFirstResponder];
    }
    if([txtValueView24 isFirstResponder]){
        [txtValueView24 setText:currentDateStr];
        [txtValueView24 resignFirstResponder];
    }
}

- (void)pickerDidPressCancel {
    if([txtValueView23 isFirstResponder]){
        [txtValueView23 resignFirstResponder];
    }
    if([txtValueView24 isFirstResponder]){
        [txtValueView24 resignFirstResponder];
    }
}

@end
