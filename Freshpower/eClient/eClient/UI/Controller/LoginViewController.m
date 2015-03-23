//
//  LoginViewController.m
//  eClient
//  登陆
//  Created by Start on 3/20/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "LoginViewController.h"
#import "SVTextField.h"
#import "SVButton.h"
#import "NSString+Utils.h"

@interface LoginViewController ()

@end

@implementation LoginViewController{
    SVTextField *svUserName;
    SVTextField *svPassword;
}

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"登陆"];
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
    [svUserName.tf setText:@"15900010001"];
    [svPassword.tf setText:@"8888aa"];
}

- (void)login:(id)sender
{
    NSString *USERNAME=[svUserName.tf text];
    NSString *PASSWORD=[[[svPassword.tf text] uppercaseString] md5];
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
    [self.hRequest handle:URL_LOGIN requestParams:params];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if([@"1" isEqualToString:[response code]]){
        [[User Instance]setIsLogin:YES];
        [[User Instance]setInfo:[[response resultJSON]objectForKey:@"UserInfo"]];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [Common alert:[response msg]];
    }
}

@end
