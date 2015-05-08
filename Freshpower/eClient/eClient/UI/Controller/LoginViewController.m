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
#import "DGSQViewController.h"
#import "EnterpriseNameModifyViewController.h"
#import "ForgetPwdViewController.h"

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
        UIBarButtonItem *negativeSpacerRight = [[UIBarButtonItem alloc]
                                                initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                target:nil action:nil];
        negativeSpacerRight.width = -20;
        self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacerRight, [[UIBarButtonItem alloc] initWithCustomView:bRegister], nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 200)];
    [self.view addSubview:frame];
    svUserName=[[SVTextField alloc]initWithFrame:CGRectMake1(10, 5, 300, 40) Title:@"账号"];
    [frame addSubview:svUserName];
    svPassword=[[SVTextField alloc]initWithFrame:CGRectMake1(10, 50, 300, 40) Title:@"密码"];
    [svPassword.tf setSecureTextEntry:YES];
    [frame addSubview:svPassword];
    SVButton *bLogin=[[SVButton alloc]initWithFrame:CGRectMake1(10, 100, 300, 40) Title:@"登陆" Type:2];
    [bLogin addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [frame addSubview:bLogin];
    
    UIButton *bForgetPwd = [[UIButton alloc]initWithFrame:CGRectMake1(210, 150, 100, 40)];
    [bForgetPwd setTitle:@"找回密码?" forState:UIControlStateNormal];
    [bForgetPwd.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [bForgetPwd setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [bForgetPwd.titleLabel setTextAlignment:NSTextAlignmentRight];
    [bForgetPwd addTarget:self action:@selector(goForget:) forControlEvents:UIControlEventTouchUpInside];
    [frame addSubview:bForgetPwd];
    
    
//    有监测类型用户(安装我们设备的用户)：cshh   8888aa
//    无监测类型用户（可以增加多个企业的）：zhaox07 111111
//    无监测类型用户（只一个企业的）：15900010001  8888aa
//    电工：15900010010  8888aa
//    [svUserName.tf setText:@"mn1"];
//    [svPassword.tf setText:@"8888aa"];
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
    [self.hRequest handle:URL_appUserCenter requestParams:params];
}

- (void)goRegister:(id)sender
{
    [self.navigationController pushViewController:[[RegisterViewController alloc]init] animated:YES];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if([@"1" isEqualToString:[response code]]){
        NSDictionary *user=[[response resultJSON]objectForKey:@"UserInfo"];
        NSString *roleType=[user objectForKey:@"ROLETYPE"];
        if([@"4" isEqualToString:roleType]){
            //请下载e电工操作版
            [self.navigationController pushViewController:[[DGSQViewController alloc]init] animated:YES];
        }else{
            [[User Instance] LoginSuccessWithUserName:USERNAME Password:PASSWORD Data:[NSMutableDictionary dictionaryWithDictionary:user]];
            NSString *cp_Name=[[User Instance]getCPName];
            if([@"" isEqualToString:cp_Name]){
                //设置企业名称
                [self.navigationController pushViewController:[[EnterpriseNameModifyViewController alloc]init] animated:YES];
            }else{
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }else{
//        [Common alert:[Common NSNullConvertEmptyString:[response msg]]];
    }
}

- (void)goForget:(id)sender
{
    [self.navigationController pushViewController:[[ForgetPwdViewController alloc]init] animated:YES];
}

@end