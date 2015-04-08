//
//  ModifyPwdViewController.m
//  eClient
//
//  Created by Start on 4/8/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "ModifyPwdViewController.h"
#import "SVTextField.h"
#import "SVButton.h"
#import "NSString+Utils.h"

@interface ModifyPwdViewController ()

@end

@implementation ModifyPwdViewController{
    SVTextField *svOldPassword;
    SVTextField *svNewPassword;
    SVTextField *svRePassword;
}

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"修改密码"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 150)];
    [self.view addSubview:frame];
    svOldPassword=[[SVTextField alloc]initWithFrame:CGRectMake1(10, 5, 300, 40) Title:@"旧密码"];
    [frame addSubview:svOldPassword];
    svNewPassword=[[SVTextField alloc]initWithFrame:CGRectMake1(10, 50, 300, 40) Title:@"新密码"];
    [frame addSubview:svNewPassword];
    svRePassword=[[SVTextField alloc]initWithFrame:CGRectMake1(10, 100, 300, 40) Title:@"新密码"];
    [frame addSubview:svRePassword];
    SVButton *bSure=[[SVButton alloc]initWithFrame:CGRectMake1(10, 150, 300, 40) Title:@"确认" Type:2];
    [bSure addTarget:self action:@selector(modify:) forControlEvents:UIControlEventTouchUpInside];
    [frame addSubview:bSure];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if([[User Instance]isLogin]){
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)modify:(id)sender
{
//    USERNAME=[svUserName.tf text];
//    PASSWORD=[[[svPassword.tf text] uppercaseString] md5];
//    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
//    [params setObject:@"99010100" forKey:@"GNID"];
//    [params setObject:USERNAME forKey:@"imei"];
//    [params setObject:PASSWORD forKey:@"authentication"];
//    [params setObject:@"01" forKey:@"QTKEY"];
//    [params setObject:@"1" forKey:@"QTVAL"];
//    self.hRequest=[[HttpRequest alloc]init];
//    [self.hRequest setRequestCode:500];
//    [self.hRequest setDelegate:self];
//    [self.hRequest setController:self];
//    [self.hRequest setIsShowMessage:YES];
//    [self.hRequest handle:URL_appUserCenter requestParams:params];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
}

@end
