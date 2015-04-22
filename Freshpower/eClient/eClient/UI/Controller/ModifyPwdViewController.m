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
    NSString *PASSWORD;
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
    UIControl *frame=[[UIControl alloc]initWithFrame:CGRectMake1(0, 0, 320, 200)];
    [frame addTarget:self action:@selector(backgroundDoneEditing:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:frame];
    svOldPassword=[[SVTextField alloc]initWithFrame:CGRectMake1(10, 5, 300, 40) Title:@"旧密码"];
    [svOldPassword.tf setClearButtonMode:UITextFieldViewModeWhileEditing];
    [svOldPassword.tf setSecureTextEntry:YES];
    [frame addSubview:svOldPassword];
    svNewPassword=[[SVTextField alloc]initWithFrame:CGRectMake1(10, 50, 300, 40) Title:@"新密码"];
    [svNewPassword.tf setSecureTextEntry:YES];
    [frame addSubview:svNewPassword];
    svRePassword=[[SVTextField alloc]initWithFrame:CGRectMake1(10, 100, 300, 40) Title:@"新密码"];
    [svRePassword.tf setSecureTextEntry:YES];
    [frame addSubview:svRePassword];
    SVButton *bSure=[[SVButton alloc]initWithFrame:CGRectMake1(10, 150, 300, 40) Title:@"确认" Type:2];
    [bSure addTarget:self action:@selector(modify:) forControlEvents:UIControlEventTouchUpInside];
    [frame addSubview:bSure];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(![[User Instance]isLogin]){
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)modify:(id)sender
{
    NSString *oldPassword=[svOldPassword.tf text];
    if([@"" isEqualToString:oldPassword]){
        [Common alert:@"旧密码不能为空"];
        return;
    }
    oldPassword=[[oldPassword uppercaseString] md5];
    PASSWORD=[svNewPassword.tf text];
    NSString *rePASSWORD=[svRePassword.tf text];
    if([@"" isEqualToString:PASSWORD]){
        [Common alert:@"新密码不能为空"];
        return;
    }
    if(![PASSWORD isEqualToString:rePASSWORD]){
        [Common alert:@"两次密码不相同"];
        return;
    }
    PASSWORD=[[PASSWORD uppercaseString] md5];
    rePASSWORD=[[rePASSWORD uppercaseString] md5];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[[User Instance]getUserName] forKey:@"imei"];
    [params setObject:oldPassword forKey:@"authentication"];
    [params setObject:PASSWORD forKey:@"Password"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest handle:URL_appUpdatePwd requestParams:params];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if([@"1" isEqualToString:[[response resultJSON]objectForKey:@"rs"]]){
        [Common alert:@"修改成功"];
        [Common setCache:ACCOUNTPASSWORD data:PASSWORD];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [Common alert:@"修改失败"];
    }
}

- (void)backgroundDoneEditing:(id)sender {
    [svOldPassword.tf resignFirstResponder];
    [svNewPassword.tf resignFirstResponder];
    [svRePassword.tf resignFirstResponder];
}

@end
