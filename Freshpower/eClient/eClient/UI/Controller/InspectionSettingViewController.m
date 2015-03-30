//
//  InspectionSettingViewController.m
//  eClient
//  巡检任务设置
//  Created by weizhenyao on 15/3/23.
//  Copyright (c) 2015年 freshpower. All rights reserved.
//

#import "InspectionSettingViewController.h"
#import "TimeSelectViewController.h"
#import "PersonalSelectViewController.h"
#import "SVButton.h"
#import "SVCheckbox.h"
#import "SVTextField.h"

#define TITLE1COLOR [UIColor colorWithRed:(140/255.0) green:(140/255.0) blue:(140/255.0) alpha:1]
#define TITLECOLOR [UIColor colorWithRed:(200/255.0) green:(200/255.0) blue:(200/255.0) alpha:1]
#define LINECOLOR [UIColor colorWithRed:(230/255.0) green:(230/255.0) blue:(230/255.0) alpha:1]

@interface InspectionSettingViewController ()

@end

@implementation InspectionSettingViewController{
    UILabel *lblTimeSelect,*lblPersonalInfo;
    SVTextField *svTextField1,*svTextField2,*svTextField3,*svTextField4;
    UIDatePicker *datePicker1,*datePicker2,*datePicker3,*datePicker4;
    SVCheckbox *autoDownSend,*manualSend;
    NSInteger dSendType;
    NSString *timeString,*taskUser;
}

- (id)initWithData:(NSDictionary*)data
{
    self=[super init];
    if(self){
        self.data=data;
        [self setTitle:@"巡检设置"];
        UIScrollView *scrollFrame=[[UIScrollView alloc]initWithFrame:self.view.bounds];
        [scrollFrame setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.view addSubview:scrollFrame];
        CGFloat height=0;
        [scrollFrame addSubview:[self addHeadFrame:@"提醒设置" X:0]];
        height=height+30;
        [scrollFrame addSubview:[self addTimeItem:height Title:@"变电站运行记录表"]];
        height=height+155;
        int headCount=4;
        for(int i=0;i<headCount;i++){
            if(i==0){
                svTextField1=[self addTextFieldItem:scrollFrame X:height+i*70 Title:@"变电站电气设备日常巡检"];
                datePicker1=[self createPicker:svTextField1.tf doneAction:@selector(doneDatePicker1) cancelAction:@selector(doneDatePicker1)];
            }else if(i==1){
                svTextField2=[self addTextFieldItem:scrollFrame X:height+i*70 Title:@"高温季节配电房测温表"];
                datePicker2=[self createPicker:svTextField2.tf doneAction:@selector(doneDatePicker2) cancelAction:@selector(doneDatePicker2)];
            }else if(i==2){
                svTextField3=[self addTextFieldItem:scrollFrame X:height+i*70 Title:@"梅雨季节巡视记录表"];
                datePicker3=[self createPicker:svTextField3.tf doneAction:@selector(doneDatePicker3) cancelAction:@selector(doneDatePicker3)];
            }else if(i==3){
                svTextField4=[self addTextFieldItem:scrollFrame X:height+i*70 Title:@"特殊巡视记录表"];
                datePicker4=[self createPicker:svTextField4.tf doneAction:@selector(doneDatePicker4) cancelAction:@selector(doneDatePicker4)];
            }
        }
        height=height+headCount*70;
        [scrollFrame addSubview:[self addHeadFrame:@"下发设置" X:height]];
        [self addSendSetting:scrollFrame X:height+30];
        height=height+30+115;
        [scrollFrame addSubview:[self addHeadFrame:@"巡检人员设置" X:height]];
        lblPersonalInfo=[[UILabel alloc]initWithFrame:CGRectMake1(10, height+30, 300, 40)];
        [lblPersonalInfo setText:@"暂无巡检人员，点击设置"];
        [lblPersonalInfo setTextColor:TITLE1COLOR];
        [lblPersonalInfo setFont:[UIFont systemFontOfSize:14]];
        [lblPersonalInfo setTextAlignment:NSTextAlignmentLeft];
        [lblPersonalInfo setUserInteractionEnabled:YES];
        [lblPersonalInfo addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(personalSelect:)]];
        [scrollFrame addSubview:lblPersonalInfo];
        height=height+30+40+10;
        SVButton *submit=[[SVButton alloc]initWithFrame:CGRectMake1(10, height, 300, 40) Title:@"提交" Type:2];
        [submit addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
        [scrollFrame addSubview:submit];
        [scrollFrame setContentSize:CGSizeMake1(320, height+40+10)];
        
        dSendType=1;
        [self showSendTypeStatus];
    }
    return self;
}

- (UIView*)addHeadFrame:(NSString*)title X:(CGFloat)x
{
    UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(0, x, 320, 30)];
    [frame setBackgroundColor:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1]];
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 5, 320, 20)];
    [lbl setText:title];
    [lbl setFont:[UIFont systemFontOfSize:14]];
    [lbl setTextColor:[UIColor blackColor]];
    [lbl setTextAlignment:NSTextAlignmentLeft];
    [frame addSubview:lbl];
    return frame;
}

- (UIView*)addTimeItem:(CGFloat)x Title:(NSString*)title
{
    UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(0, x, 320, 100)];
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 5, 300, 20)];
    [lbl setText:title];
    [lbl setFont:[UIFont systemFontOfSize:14]];
    [lbl setNumberOfLines:0];
    [lbl setTextColor:TITLE1COLOR];
    [frame addSubview:lbl];
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake1(10, 30, 30, 30)];
    [image setImage:[UIImage imageNamed:@"勾"]];
    [frame addSubview:image];
    lbl=[[UILabel alloc]initWithFrame:CGRectMake1(45, 30, 70, 30)];
    [lbl setText:@"按小时提醒"];
    [lbl setFont:[UIFont systemFontOfSize:14]];
    [lbl setTextColor:TITLE1COLOR];
    [frame addSubview:lbl];
    lbl=[[UILabel alloc]initWithFrame:CGRectMake1(230, 30, 70, 30)];
    [lbl setText:@"时间段选择"];
    [lbl setFont:[UIFont systemFontOfSize:14]];
    [lbl setTextColor:TITLE1COLOR];
    [lbl setUserInteractionEnabled:YES];
    [lbl addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(timeSelect:)]];
    [frame addSubview:lbl];
    lblTimeSelect=[[UILabel alloc]initWithFrame:CGRectMake1(50, 60, 260, 40)];
//    [lbl setText:@"00:00-02:00-04:00-06:00-08:00-10:00-12:00-14:00-16:00-18:00-20:00-22:00"];
    [lblTimeSelect setFont:[UIFont systemFontOfSize:14]];
    [lblTimeSelect setTextColor:TITLE1COLOR];
    [lblTimeSelect setNumberOfLines:0];
    [frame addSubview:lblTimeSelect];
    lbl=[[UILabel alloc]initWithFrame:CGRectMake1(50, 100, 260, 50)];
    [lbl setText:@"时间段8:00~22:00，每间隔2小时提醒一次，且需要提前10分钟提醒 ，如：7：50发出提醒。"];
    [lbl setFont:[UIFont systemFontOfSize:13]];
    [lbl setTextColor:TITLE1COLOR];
    [lbl setNumberOfLines:0];
    [frame addSubview:lbl];
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake1(0, 154, 320, 1)];
    [line setBackgroundColor:LINECOLOR];
    [frame addSubview:line];
    return frame;
}

- (SVTextField*)addTextFieldItem:(UIView*)frame X:(CGFloat)x Title:(NSString*)title
{
    UIView *f=[[UIView alloc]initWithFrame:CGRectMake1(0, x, 320, 70)];
    [frame addSubview:f];
    UILabel *lblTitle=[[UILabel alloc]initWithFrame:CGRectMake1(10, 5, 300, 20)];
    [lblTitle setText:title];
    [lblTitle setFont:[UIFont systemFontOfSize:14]];
    [lblTitle setNumberOfLines:0];
    [lblTitle setTextColor:TITLE1COLOR];
    [f addSubview:lblTitle];
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake1(10, 30, 30, 30)];
    [image setImage:[UIImage imageNamed:@"勾"]];
    [f addSubview:image];
    lblTitle=[[UILabel alloc]initWithFrame:CGRectMake1(45, 30, 60, 30)];
    [lblTitle setText:@"按天提醒"];
    [lblTitle setFont:[UIFont systemFontOfSize:14]];
    [lblTitle setTextColor:TITLECOLOR];
    [f addSubview:lblTitle];
    SVTextField *timeDate=[[SVTextField alloc]initWithFrame:CGRectMake1(110, 30, 100, 30) Title:nil];
    [f addSubview:timeDate];
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake1(0, 69, 320, 1)];
    [line setBackgroundColor:LINECOLOR];
    [f addSubview:line];
    return timeDate;
}

- (void)addSendSetting:(UIView*)frame X:(CGFloat)x
{
    UIView *f=[[UIView alloc]initWithFrame:CGRectMake1(0, x, 320, 115)];
    [frame addSubview:f];
    autoDownSend=[[SVCheckbox alloc]initWithFrame:CGRectMake1(0, 5, 100, 30)];
    [[autoDownSend titleLabel]setFont:[UIFont systemFontOfSize:14]];
    [autoDownSend setTitle:@"自动下发" forState:UIControlStateNormal];
    [autoDownSend setTitleColor:TITLECOLOR forState:UIControlStateNormal];
    [autoDownSend setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [autoDownSend addTarget:self action:@selector(sendSetting1:) forControlEvents:UIControlEventTouchUpInside];
    [f addSubview:autoDownSend];
    manualSend=[[SVCheckbox alloc]initWithFrame:CGRectMake1(110, 5, 100, 30)];
    [[manualSend titleLabel]setFont:[UIFont systemFontOfSize:14]];
    [manualSend setTitle:@"手动下发" forState:UIControlStateNormal];
    [manualSend setTitleColor:TITLECOLOR forState:UIControlStateNormal];
    [manualSend setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [manualSend addTarget:self action:@selector(sendSetting2:) forControlEvents:UIControlEventTouchUpInside];
    [f addSubview:manualSend];
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 40, 300, 70)];
    [lbl setText:@"您可以选择适合您的下发方式：1、自动下发：巡检比较频繁且有规律时选择。如每天需要下发巡检任务。2、手动下发：巡检不频繁且无规律时选择。如每周巡检一次或每月巡检几次。"];
    [lbl setFont:[UIFont systemFontOfSize:13]];
    [lbl setNumberOfLines:0];
    [lbl setTextColor:TITLECOLOR];
    [f addSubview:lbl];
}

- (void)timeSelect:(id)sender
{
    TimeSelectViewController *timeSelectViewController=[[TimeSelectViewController alloc]init];
    [timeSelectViewController setDelegate:self];
    [timeSelectViewController setResultCode:500];
    [self.navigationController pushViewController:timeSelectViewController animated:YES];
}

- (void)personalSelect:(id)sender
{
    PersonalSelectViewController *personalSelectViewController=[[PersonalSelectViewController alloc]initWithData:self.data];
    [personalSelectViewController setDelegate:self];
    [personalSelectViewController setResultCode:501];
    [self.navigationController pushViewController:personalSelectViewController animated:YES];
}

- (void)submit:(id)sender
{
    NSLog(@"%@",self.data);
//    NSLog(@"%d\n%@\n%@",dSendType,timeString,taskUser);
}

- (UIDatePicker*)createPicker:(UITextField*)textField doneAction:(SEL)dAction cancelAction:(SEL)cAction
{
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    datePicker.datePickerMode = UIDatePickerModeTime;
    textField.inputView = datePicker;
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake1(0, 0, 320, 44)];
    // 選取日期完成鈕 並給他一個 selector
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:cAction];
    // 把按鈕加進 UIToolbar
    toolBar.items = [NSArray arrayWithObject:right];
    // 原本應該是鍵盤上方附帶內容的區塊 改成一個 UIToolbar 並加上完成鈕
    textField.inputAccessoryView = toolBar;
    return datePicker;
}

- (void)showDateValue:(SVTextField*)pickerField DatePicker:(UIDatePicker*)datePicker
{
    if ([self.view endEditing:NO]) {
        NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"HH:mm";
        pickerField.tf.text = [fmt stringFromDate:datePicker.date];
    }
}

- (void)doneDatePicker1
{
    [self showDateValue:svTextField1 DatePicker:datePicker1];
}

- (void)doneDatePicker2
{
    [self showDateValue:svTextField2 DatePicker:datePicker2];
}

- (void)doneDatePicker3
{
    [self showDateValue:svTextField3 DatePicker:datePicker3];
}

- (void)doneDatePicker4
{
    [self showDateValue:svTextField4 DatePicker:datePicker4];
}

- (void)onControllerResult:(NSInteger)resultCode data:(NSMutableDictionary*)result
{
    if(resultCode==500){
        //
        timeString=[result objectForKey:@"TIMES"];
        [lblTimeSelect setText:timeString];
    }else if(resultCode==501){
        //
        taskUser=[result objectForKey:@"TASK_USER"];
        [lblPersonalInfo setText:[result objectForKey:@"NAME"]];
    }
}

- (void)showSendTypeStatus
{
    if(dSendType==1){
        [autoDownSend setSelected:YES];
        [manualSend setSelected:NO];
    }else{
        [autoDownSend setSelected:NO];
        [manualSend setSelected:YES];
    }
}

- (void)sendSetting1:(id)sender
{
    dSendType=1;
    [self showSendTypeStatus];
}

- (void)sendSetting2:(id)sender
{
    dSendType=2;
    [self showSendTypeStatus];
}

@end