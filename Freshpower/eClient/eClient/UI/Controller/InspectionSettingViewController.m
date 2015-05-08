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
    NSString *dSET_TYPE,*timeString,*taskUser;
    NSMutableArray *headShow;
}

- (id)initWithData:(NSMutableDictionary*)data
{
    self=[super init];
    if(self){
        self.paramData=data;
        [self setTitle:@"巡检设置"];
        UIScrollView *scrollFrame=[[UIScrollView alloc]initWithFrame:self.view.bounds];
        [scrollFrame setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.view addSubview:scrollFrame];
        CGFloat height=0;
        [scrollFrame addSubview:[self addHeadFrame:@"提醒设置" X:0]];
        height=height+30;
        NSArray *MODEL_LIST=[data objectForKey:@"MODEL_LIST"];
        headShow=[[NSMutableArray alloc]init];
        for(int i=0;i<[MODEL_LIST count];i++){
            NSDictionary *d=[MODEL_LIST objectAtIndex:i];
            NSString *SETID=[d objectForKey:@"MODEL_SET_ID"];
            if(![@"0" isEqualToString:SETID]){
                [headShow addObject:d];
            }
        }
        for(int i=0;i<[headShow count];i++){
            NSDictionary *d=[headShow objectAtIndex:i];
            NSString *type=[d objectForKey:@"MODEL_TYPE"];
            if([@"1" isEqualToString:type]){
                [scrollFrame addSubview:[self addTimeItem:height Data:d]];
                height=height+155;
            }else if([@"2" isEqualToString:type]){
                svTextField1=[self addTextFieldItem:scrollFrame X:height Data:d];
                datePicker1=[self createPicker:svTextField1.tf doneAction:@selector(doneDatePicker1) cancelAction:@selector(doneDatePicker1)];
                height=height+70;
            }else if([@"3" isEqualToString:type]){
                svTextField2=[self addTextFieldItem:scrollFrame X:height Data:d];
                datePicker2=[self createPicker:svTextField2.tf doneAction:@selector(doneDatePicker2) cancelAction:@selector(doneDatePicker2)];
                height=height+70;
            }else if([@"4" isEqualToString:type]){
                svTextField3=[self addTextFieldItem:scrollFrame X:height Data:d];
                datePicker3=[self createPicker:svTextField3.tf doneAction:@selector(doneDatePicker3) cancelAction:@selector(doneDatePicker3)];
                height=height+70;
            }else if([@"5" isEqualToString:type]){
                svTextField4=[self addTextFieldItem:scrollFrame X:height Data:d];
                datePicker4=[self createPicker:svTextField4.tf doneAction:@selector(doneDatePicker4) cancelAction:@selector(doneDatePicker4)];
                height=height+70;
            }
        }
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
        dSET_TYPE=[data objectForKey:@"SET_TYPE"];
        if([@"-1" isEqualToString:dSET_TYPE]){
            dSET_TYPE=@"1";
        }
        [self showSendTypeStatus];
        taskUser=[data objectForKey:@"TASK_USER"];
        [lblPersonalInfo setText:[data objectForKey:@"TASK_USER_NAME"]];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if([headShow count]==0){
        [Common alert:@"请选择您要下发的巡检模板"];
        [self.navigationController popViewControllerAnimated:YES];
    }
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

- (UIView*)addTimeItem:(CGFloat)x Data:(NSDictionary*)da
{
    UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(0, x, 320, 100)];
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 5, 300, 20)];
    [lbl setText:[da objectForKey:@"MODEL_NAME"]];
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
    timeString=[da objectForKey:@"DATE_VALUE"];
    [lblTimeSelect setText:timeString];
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

- (SVTextField*)addTextFieldItem:(UIView*)frame X:(CGFloat)x Data:(NSDictionary*)da
{
    UIView *f=[[UIView alloc]initWithFrame:CGRectMake1(0, x, 320, 70)];
    [frame addSubview:f];
    UILabel *lblTitle=[[UILabel alloc]initWithFrame:CGRectMake1(10, 5, 300, 20)];
    [lblTitle setText:[da objectForKey:@"MODEL_NAME"]];
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
    [timeDate.tf setText:[da objectForKey:@"DATE_VALUE"]];
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
    PersonalSelectViewController *personalSelectViewController=[[PersonalSelectViewController alloc]initWithData:self.paramData];
    [personalSelectViewController setDelegate:self];
    [personalSelectViewController setResultCode:501];
    [self.navigationController pushViewController:personalSelectViewController animated:YES];
}

- (void)submit:(id)sender
{
    if(taskUser==nil||[@"" isEqualToString:taskUser]||[@"0" isEqualToString:taskUser]){
        [Common alert:@"请设置巡检人员"];
        return;
    }
    NSString *str1=[svTextField1.tf text];
    NSString *str2=[svTextField2.tf text];
    NSString *str3=[svTextField3.tf text];
    NSString *str4=[svTextField4.tf text];
//    NSLog(@"1:%@\n2:%@\n3:%@\n4:%@\n5:%@\n6:%@\n7:%@",timeString,str1,str2,str3,str4,dSET_TYPE,taskUser);
    NSMutableString *ms=[[NSMutableString alloc]init];
    NSMutableString *types=[[NSMutableString alloc]init];
    for(id d in headShow){
        NSString *TYPE=[d objectForKey:@"MODEL_TYPE"];
        if([@"1"isEqualToString:TYPE]){
            if(![@"" isEqualToString:timeString]){
                [ms appendFormat:@"%@,",timeString];
            }else{
                [Common alert:@"变电站运行记录产表不能为空"];
                return;
            }
        }else if([@"2"isEqualToString:TYPE]){
            if(![@"" isEqualToString:str1]){
                [ms appendFormat:@"%@,",str1];
            }else{
                [Common alert:@"变电站电气设备日常巡检不能为空"];
                return;
            }
        }else if([@"3"isEqualToString:TYPE]){
            if(![@"" isEqualToString:str2]){
                [ms appendFormat:@"%@,",str2];
            }else{
                [Common alert:@"高温季节配电房测温表不能为空"];
                return;
            }
        }else if([@"4"isEqualToString:TYPE]){
            if(![@"" isEqualToString:str3]){
                [ms appendFormat:@"%@,",str3];
            }else{
                [Common alert:@"梅雨季节巡视记录表不能为空"];
                return;
            }
        }else if([@"5"isEqualToString:TYPE]){
            if(![@"" isEqualToString:str4]){
                [ms appendFormat:@"%@,",str4];
            }else{
                [Common alert:@"特殊巡视记录表不能为空"];
                return;
            }
        }
        [types appendFormat:@"%@,",TYPE];
    }
    NSRange deleteRange1 = {[types length]-1,1};
    [types deleteCharactersInRange:deleteRange1];
    NSRange deleteRange = {[ms length]-1,1};
    [ms deleteCharactersInRange:deleteRange];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[[User Instance]getUserName] forKey:@"imei"];
    [params setObject:[[User Instance]getPassword] forKey:@"authentication"];
    [params setObject:@"TS004" forKey:@"GNID"];
    [params setObject:[self.paramData objectForKey:@"CP_ID"] forKey:@"QTCP"];
    [params setObject:types forKey:@"QTKEY"];
    [params setObject:ms forKey:@"QTVAL"];
    [params setObject:dSET_TYPE forKey:@"QTKEY1"];
    [params setObject:taskUser forKey:@"QTUSER"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest handle:URL_appTaskingFps requestParams:params];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if([response successFlag]){
        NSMutableDictionary *da=[[NSMutableDictionary alloc]init];
        [da setObject:dSET_TYPE forKey:@"dSET_TYPE"];
        [self.delegate onControllerResult:500 data:da];
        [self.navigationController popViewControllerAnimated:YES];
    }
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
    if([@"1" isEqualToString:dSET_TYPE]){
        [autoDownSend setSelected:YES];
        [manualSend setSelected:NO];
    }else if([@"2" isEqualToString:dSET_TYPE]){
        [autoDownSend setSelected:NO];
        [manualSend setSelected:YES];
    }
}

- (void)sendSetting1:(id)sender
{
    dSET_TYPE=@"1";
    [self showSendTypeStatus];
}

- (void)sendSetting2:(id)sender
{
    dSET_TYPE=@"2";
    [self showSendTypeStatus];
}

@end