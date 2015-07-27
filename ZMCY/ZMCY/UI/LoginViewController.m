//
//  LoginViewController.m
//  ZMCY
//
//  Created by Start on 15/7/19.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "NSString+Utils.h"

@interface LoginViewController ()

@end

@implementation LoginViewController{
    CTextField *tUserName;
    CTextField *tPassword;
}

- (id)init
{
    self=[super init];
    if(self){
        [self cTitle:@"登陆"];
        //
        tUserName=[[CTextField alloc]initWithFrame:CGRectMake1(10, 20, 300, 40) Placeholder:@"邮箱/手机号"];
        [self.view addSubview:tUserName];
        //
        tPassword=[[CTextField alloc]initWithFrame:CGRectMake1(10, 70, 300, 40) Placeholder:@"请输入密码"];
        [tPassword setSecureTextEntry:YES];
        [self.view addSubview:tPassword];
        CButton *bLogin=[[CButton alloc]initWithFrame:CGRectMake1(10, 130, 300, 40) Name:@"登录" Type:1];
        [bLogin addTarget:self action:@selector(goLogin:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:bLogin];
        CLabel *lbl=[[CLabel alloc]initWithFrame:CGRectMake1(00, 210, 140, 40) Text:@"没有账号？"];
        [lbl setFont:[UIFont systemFontOfSize:16]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [lbl setTextColor:DEFAULTITLECOLOR(200)];
        [self.view addSubview:lbl];
        lbl=[[CLabel alloc]initWithFrame:CGRectMake1(140, 210, 140, 40) Text:@"立即注册会员"];
        [lbl setFont:[UIFont systemFontOfSize:16]];
        [lbl setTextAlignment:NSTextAlignmentLeft];
        [lbl setUserInteractionEnabled:YES];
        [lbl addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goRegister:)]];
        [lbl setTextColor:DEFAULTITLECOLORRGB(1, 92, 224)];
        [self.view addSubview:lbl];
        
        [tUserName setText:@"19890624"];
        [tPassword setText:@"19890624"];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)goRegister:(id)sender
{
    [self.navigationController pushViewController:[[RegisterViewController alloc]init] animated:YES];
}

- (void)goLogin:(id)sender
{
    NSString *userName=[tUserName text];
    NSString *password=[tPassword text];
    if([@"" isEqualToString:userName]){
        [Common alert:@"账号不能为空"];
        return;
    }
    if([@"" isEqualToString:password]){
        [Common alert:@"密码不能为空"];
        return;
    }
    NSString *pwd=[password md5];
    NSString *pwd1=[pwd substringWithRange:NSMakeRange(6,16)];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:userName forKey:@"userName"];
    [params setObject:pwd1 forKey:@"pwd"];
    [params setObject:pwd1 forKey:@"clientid"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setRequestCode:500];
    [self.hRequest handle:@"UserLogin" requestParams:params];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if([response successFlag]){
        if(reqCode==500){
            NSDictionary *data=[[response resultJSON]objectForKey:@"Data"];
            NSString *userName=[tUserName text];
            NSString *password=[tPassword text];
            [[User Instance]LoginSuccessWithUserName:userName Password:password Data:data];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

@end