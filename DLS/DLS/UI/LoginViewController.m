//
//  LoginViewController.m
//  DLS
//
//  Created by Start on 3/5/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "LoginViewController.h"
#import "NSString+Utils.h"
#define TITLECOLOR [UIColor colorWithRed:(200/255.0) green:(200/255.0) blue:(200/255.0) alpha:1]
#define LOGINNORMALCOLOR [UIColor colorWithRed:(57/255.0) green:(87/255.0) blue:(207/255.0) alpha:1]
#define LOGINPRESENDCOLOR [UIColor colorWithRed:(107/255.0) green:(124/255.0) blue:(194/255.0) alpha:1]

@interface LoginViewController ()

@end

@implementation LoginViewController{
    UITextField *tfUserName;
    UITextField *tfPassword;
}

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"登陆"];
        //返回
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]
                                               initWithTitle:@"返回"
                                               style:UIBarButtonItemStyleBordered
                                               target:self
                                               action:@selector(goBack:)];
        //账户框架
        UIView *vUserNameFrame=[[UIView alloc]initWithFrame:CGRectMake1(10, 10, 300, 40)];
        vUserNameFrame.layer.cornerRadius = 5;
        vUserNameFrame.layer.masksToBounds = YES;
        vUserNameFrame.layer.borderWidth = 1;
        vUserNameFrame.layer.borderColor = [TITLECOLOR CGColor];
        [self.view addSubview:vUserNameFrame];
        UILabel *lblUserName=[[UILabel alloc]initWithFrame:CGRectMake1(0, 0, 50, 40)];
        [lblUserName setText:@"账号"];
        [lblUserName setFont:[UIFont systemFontOfSize:14]];
        [lblUserName setTextAlignment:NSTextAlignmentCenter];
        [lblUserName setTextColor:TITLECOLOR];
        [vUserNameFrame addSubview:lblUserName];
        tfUserName=[[UITextField alloc]initWithFrame:CGRectMake1(50, 0,250, 40)];
        [tfUserName setPlaceholder:@"请输入账号"];
        [tfUserName setTextColor:TITLECOLOR];
        [vUserNameFrame addSubview:tfUserName];
        //密码框架
        UIView *vPasswordFrame=[[UIView alloc]initWithFrame:CGRectMake1(10, 60, 300, 40)];
        vPasswordFrame.layer.cornerRadius = 5;
        vPasswordFrame.layer.masksToBounds = YES;
        vPasswordFrame.layer.borderWidth = 1;
        vPasswordFrame.layer.borderColor = [TITLECOLOR CGColor];
        [self.view addSubview:vPasswordFrame];
        UILabel *lblPassword=[[UILabel alloc]initWithFrame:CGRectMake1(0, 0, 50, 40)];
        [lblPassword setText:@"密码"];
        [lblPassword setFont:[UIFont systemFontOfSize:14]];
        [lblPassword setTextAlignment:NSTextAlignmentCenter];
        [lblPassword setTextColor:TITLECOLOR];
        [vPasswordFrame addSubview:lblPassword];
        tfPassword=[[UITextField alloc]initWithFrame:CGRectMake1(50, 0,250, 40)];
        [tfPassword setPlaceholder:@"请输入密码"];
        [tfPassword setTextColor:TITLECOLOR];
        [tfPassword setSecureTextEntry:YES];
        [vPasswordFrame addSubview:tfPassword];
        //登陆
        UIButton *bLogin=[[UIButton alloc]initWithFrame:CGRectMake1(10, 110, 300, 40)];
        bLogin.layer.cornerRadius = 5;
        bLogin.layer.masksToBounds = YES;
        [bLogin setTitle:@"登陆" forState:UIControlStateNormal];
        [bLogin.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [bLogin.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [bLogin setBackgroundImage:[Common createImageWithColor:LOGINNORMALCOLOR] forState:UIControlStateNormal];
        [bLogin setBackgroundImage:[Common createImageWithColor:LOGINPRESENDCOLOR] forState:UIControlStateHighlighted];
        [bLogin addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:bLogin];
        
        [tfUserName setText:[[User Instance]getUserName]];
        [tfPassword setText:[[User Instance]getPassword]];
    }
    return self;
}

- (void)login:(id)sender
{
    NSString *userName=[tfUserName text];
    NSString *password=[tfPassword text];
    if([@"" isEqualToString:userName]){
        [Common alert:@"账号不能为空"];
        return;
    }
    if([@"" isEqualToString:password]){
        [Common alert:@"密码不能为空"];
        return;
    }
    password=[[[password md5] lowercaseString] substringWithRange:NSMakeRange(6, 16)];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:userName forKey:@"userName"];
    [params setObject:password forKey:@"pwd"];
    [params setObject:@"1" forKey:@"clientid"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest handle:@"UserLogin" requestParams:params];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if([response successFlag]){
        NSString *userName=[tfUserName text];
        NSString *password=[tfPassword text];
        [[User Instance]LoginSuccessWithUserName:userName Password:password Data:[[response resultJSON]objectForKey:@"Data"]];
        [[self resultDelegate]onControllerResult:RESULTCODE_LOGIN data:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end