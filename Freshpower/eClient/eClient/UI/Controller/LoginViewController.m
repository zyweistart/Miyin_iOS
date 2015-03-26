//
//  LoginViewController.m
//  eClient
//  登陆
//  Created by Start on 3/20/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "SVTextField.h"
#import "SVButton.h"
#import "NSString+Utils.h"

@interface LoginViewController ()

@end

@implementation LoginViewController{
    SVTextField *svUserName;
    SVTextField *svPassword;
    NSString *USERNAME;
    NSString *PASSWORD;
}

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"登陆"];
        UIButton *bRegister = [UIButton buttonWithType:UIButtonTypeCustom];
        [bRegister setTitle:@"注册" forState:UIControlStateNormal];
        [bRegister.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [bRegister setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bRegister addTarget:self action:@selector(goRegister:) forControlEvents:UIControlEventTouchUpInside];
        bRegister.frame = CGRectMake(0, 0, 70, 30);
        bRegister.layer.cornerRadius = 5;
        bRegister.layer.masksToBounds = YES;
        self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:bRegister];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 150)];
    [self.view addSubview:frame];
    svUserName=[[SVTextField alloc]initWithFrame:CGRectMake1(10, 5, 300, 40) Title:@"账号"];
    [frame addSubview:svUserName];
    svPassword=[[SVTextField alloc]initWithFrame:CGRectMake1(10, 50, 300, 40) Title:@"密码"];
    [frame addSubview:svPassword];
    SVButton *bLogin=[[SVButton alloc]initWithFrame:CGRectMake1(10, 100, 300, 40) Title:@"登陆" Type:2];
    [bLogin addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [frame addSubview:bLogin];
    [svUserName.tf setText:@"zhaox07"];
    [svPassword.tf setText:@"111111"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if([[User Instance]isLogin]){
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)login:(id)sender
{
    USERNAME=[svUserName.tf text];
    PASSWORD=[[[svPassword.tf text] uppercaseString] md5];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"99010100" forKey:@"GNID"];
    [params setObject:USERNAME forKey:@"imei"];
    [params setObject:PASSWORD forKey:@"authentication"];
    [params setObject:@"01" forKey:@"QTKEY"];
    [params setObject:@"1" forKey:@"QTVAL"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest handle:SERVER_URL(etgWebSite,@"appUserCenter.aspx") requestParams:params];
}

- (void)goRegister:(id)sender
{
    [self.navigationController pushViewController:[[RegisterViewController alloc]init] animated:YES];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if([@"1" isEqualToString:[response code]]){
        [[User Instance]setUserName:USERNAME];
        [[User Instance]setPassWord:PASSWORD];
        [[User Instance]setIsLogin:YES];
        [[User Instance]setInfo:[[response resultJSON]objectForKey:@"UserInfo"]];
//        [self.navigationController popToRootViewControllerAnimated:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [Common alert:[response msg]];
    }
}

@end
