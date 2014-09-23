//
//  STLoginViewController.m
//  ElectricianRun
//  登录
//  Created by Start on 1/24/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STLoginViewController.h"
#import "NSString+Utils.h"

@interface STLoginViewController ()

@end

@implementation STLoginViewController {
    UITextField *txtValueUserName;
    UITextField *txtValuePassword;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"登录";
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]
                                               initWithTitle:@"登录"
                                               style:UIBarButtonItemStyleBordered
                                               target:self
                                               action:@selector(login:)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIControl *control=[[UIControl alloc]initWithFrame:CGRectMake(0, 80, 320, 130)];
    [control setHidden:NO];
    [control addTarget:self action:@selector(backgroundDoneEditing:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:control];
    
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 70, 30)];
    lbl.font=[UIFont systemFontOfSize:12.0];
    [lbl setText:@"账户"];
    [lbl setTextColor:[UIColor blackColor]];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setTextAlignment:NSTextAlignmentRight];
    [control addSubview:lbl];
    
    txtValueUserName=[[UITextField alloc]initWithFrame:CGRectMake(90, 10, 200, 30)];
    [txtValueUserName setFont:[UIFont systemFontOfSize: 12.0]];
    [txtValueUserName setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtValueUserName setBorderStyle:UITextBorderStyleRoundedRect];
    [txtValueUserName setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [txtValueUserName setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [control addSubview:txtValueUserName];
    
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 50, 70, 30)];
    lbl.font=[UIFont systemFontOfSize:12.0];
    [lbl setText:@"密码"];
    [lbl setTextColor:[UIColor blackColor]];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setTextAlignment:NSTextAlignmentRight];
    [control addSubview:lbl];
    
    txtValuePassword=[[UITextField alloc]initWithFrame:CGRectMake(90, 50, 200, 30)];
    [txtValuePassword setFont:[UIFont systemFontOfSize: 12.0]];
    [txtValuePassword setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtValuePassword setBorderStyle:UITextBorderStyleRoundedRect];
    [txtValuePassword setSecureTextEntry:YES];
    [txtValuePassword setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [txtValuePassword setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [control addSubview:txtValuePassword];
    
//    [txtValueUserName setText:@"zhangyy-gzry"];
//    [txtValuePassword setText:@"8888AA"];
    
    [Account clear];
}

- (void)backgroundDoneEditing:(id)sender {
    [txtValueUserName resignFirstResponder];
    [txtValuePassword resignFirstResponder];
}

- (void)login:(id)sender {
    
    NSString *username=[txtValueUserName text];
    NSString *password=[txtValuePassword text];
    if([@"" isEqualToString:username]){
        [Common alert:@"账户输入有误"];
    }else if([@"" isEqualToString:password]){
        [Common alert:@"密码输入有误"];
    }else{
        NSMutableDictionary *p=[[NSMutableDictionary alloc]init];
        [p setObject:username forKey:@"imei"];
        [p setObject:[[password uppercaseString] md5] forKey:@"authentication"];
        [p setObject:@"2" forKey:@"type"];
        [p setObject:@"2" forKey:@"IsEncode"];
        NSString *devicetoken=[Common getCache:DEVICETOKEN];
        if(devicetoken==nil){
            [p setObject:@"" forKey:@"equipmentId"];
        }else{
            [p setObject:devicetoken forKey:@"equipmentId"];
        }
        
        self.hRequest=[[HttpRequest alloc]init:self delegate:self responseCode:500];
        [self.hRequest setIsShowMessage:YES];
        [self.hRequest start:URLcheckMobileValid params:p];
    }
}

- (void)requestFinishedByResponse:(Response*)response responseCode:(int)repCode
{
    NSString *result=[Common NSNullConvertEmptyString:[[response resultJSON] objectForKey:@"result"]];
    if([@"2" isEqualToString:result]){
        NSString *username=[txtValueUserName text];
        NSString *password=[txtValuePassword text];
        [Account LoginSuccessWithUserName:username Password:password Data:[response resultJSON]];
        [Common alert:@"登录成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [Common alert:@"用户名或密码有误，请重试!"];
    }
}

@end