//
//  STFeedbackViewController.m
//  ElectricianRun
//  反馈
//  Created by Start on 3/3/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STFeedbackViewController.h"
#define SUBMITFEEDBACKREQUESTCODE 501

@interface STFeedbackViewController ()

@end

@implementation STFeedbackViewController {
    UITextField *txtContent;
    UITextField *txtEmail;
    UITextField *txtPhone;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"反馈";
        [self.view setBackgroundColor:[UIColor whiteColor]];
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]
                                               initWithTitle:@"提交"
                                               style:UIBarButtonItemStyleBordered
                                               target:self
                                               action:@selector(submit:)];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIControl *control=[[UIControl alloc]initWithFrame:CGRectMake(0, 80, 320, 210)];
    [control addTarget:self action:@selector(backgroundDoneEditing:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:control];
    
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 70, 30)];
    lbl.font=[UIFont systemFontOfSize:12.0];
    [lbl setText:@"内容"];
    [lbl setTextColor:[UIColor blackColor]];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setTextAlignment:NSTextAlignmentRight];
    [control addSubview:lbl];
    
    txtContent=[[UITextField alloc]initWithFrame:CGRectMake(85, 10, 200, 30)];
    [txtContent setFont:[UIFont systemFontOfSize: 12.0]];
    [txtContent setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtContent setBorderStyle:UITextBorderStyleRoundedRect];
    [txtContent setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [txtContent setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [txtContent setPlaceholder:@"请输入您的反馈意见"];
    [control addSubview:txtContent];
    
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 50, 70, 30)];
    lbl.font=[UIFont systemFontOfSize:12.0];
    [lbl setText:@"邮箱"];
    [lbl setTextColor:[UIColor blackColor]];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setTextAlignment:NSTextAlignmentRight];
    [control addSubview:lbl];
    
    txtEmail=[[UITextField alloc]initWithFrame:CGRectMake(85, 50, 200, 30)];
    [txtEmail setFont:[UIFont systemFontOfSize: 12.0]];
    [txtEmail setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtEmail setBorderStyle:UITextBorderStyleRoundedRect];
    [txtEmail setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [txtEmail setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [txtEmail setPlaceholder:@"以便将反馈意见告知您"];
    [control addSubview:txtEmail];
    
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 90, 70, 30)];
    lbl.font=[UIFont systemFontOfSize:12.0];
    [lbl setText:@"手机"];
    [lbl setTextColor:[UIColor blackColor]];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setTextAlignment:NSTextAlignmentRight];
    [control addSubview:lbl];
    
    txtPhone=[[UITextField alloc]initWithFrame:CGRectMake(85, 90, 200, 30)];
    [txtPhone setFont:[UIFont systemFontOfSize: 12.0]];
    [txtPhone setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtPhone setBorderStyle:UITextBorderStyleRoundedRect];
    [txtPhone setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [txtPhone setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [txtPhone setPlaceholder:@"请输入手机号码"];
    [control addSubview:txtPhone];
    
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(40, 130, 240, 60)];
    lbl.font=[UIFont systemFontOfSize:12.0];
    [lbl setText:@"如您需要了解反馈结果，请留下邮箱或手机号码，紧急问题可拨打4008-263-365获得及时帮助"];
    [lbl setTextColor:[UIColor blackColor]];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setNumberOfLines:0];
    [lbl setTextAlignment:NSTextAlignmentLeft];
    [control addSubview:lbl];
}

- (void)submit:(id)sender
{
    [self backgroundDoneEditing:nil];
    NSString *content=[txtContent text];
    if([@"" isEqualToString:content]){
        [Common alert:@"请输入反馈内容"];
        return;
    }
    NSString *email=[txtEmail text];
    if([@"" isEqualToString:email]){
        [Common alert:@"邮件不能为空"];
        return;
    }
    if(![Common isValidateEmail:email]){
        [Common alert:@"邮件格式不正确"];
        return;
    }
    NSString *phone=[txtPhone text];
    if([@"" isEqualToString:phone]){
        [Common alert:@"手机号码不能为空"];
        return;
    }
    if([phone length]!=11){
        [Common alert:@"手机号码不正确"];
        return;
    }
    NSMutableDictionary *p=[[NSMutableDictionary alloc]init];
    [p setObject:content forKey:@"content"];
    [p setObject:phone forKey:@"phone"];
    [p setObject:email forKey:@"mail"];
    [p setObject:@"2" forKey:@"msgType"];
    
    self.hRequest=[[HttpRequest alloc]init:self delegate:self responseCode:SUBMITFEEDBACKREQUESTCODE];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest start:URLaddSuggest params:p];
}


- (void)backgroundDoneEditing:(id)sender
{
    [txtContent resignFirstResponder];
    [txtEmail resignFirstResponder];
    [txtPhone resignFirstResponder];
}

- (void)requestFinishedByResponse:(Response*)response responseCode:(int)repCode
{
    if(repCode==SUBMITFEEDBACKREQUESTCODE){
        NSString *rs=[[response resultJSON] objectForKey:@"rs"];
        if([@"1" isEqualToString:rs]){
            [Common alert:@"反馈成功!"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [Common alert:@"反馈失败，请重试!"];
        }
    }
}



@end