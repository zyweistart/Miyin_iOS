//
//  LoginViewController.m
//  eClient
//  找回密码
//  Created by Start on 3/20/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "ForgetPwdViewController.h"
#import "RegisterViewController.h"
#import "SVTextField.h"
#import "SVButton.h"
#import "NSString+Utils.h"
#import "DGSQViewController.h"

@interface ForgetPwdViewController ()

@end

@implementation ForgetPwdViewController{
    SVTextField *svUserName;
}

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"忘记密码"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 100)];
    [self.view addSubview:frame];
    svUserName=[[SVTextField alloc]initWithFrame:CGRectMake1(10, 5, 300, 40) Title:@"账号"];
    [svUserName.tf setPlaceholder:@"请输入手机号码"];
    [frame addSubview:svUserName];
    SVButton *bSend=[[SVButton alloc]initWithFrame:CGRectMake1(10, 50, 300, 40) Title:@"发送短信验证密码" Type:2];
    [bSend addTarget:self action:@selector(get:) forControlEvents:UIControlEventTouchUpInside];
    [frame addSubview:bSend];
}

- (void)get:(id)sender
{
    NSString *USERNAME=[svUserName.tf text];
    if([@"" isEqualToString:USERNAME]){
        [Common alert:@"账号不能为空"];
        return;
    }
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"99010198" forKey:@"GNID"];
    [params setObject:USERNAME forKey:@"QTUSER"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest handle:URL_appUserCenter requestParams:params];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if(reqCode==500){
        if([response successFlag]){
            [Common alert:@"获取成功，请注意查收短信！"];
        }
    }
}

@end
