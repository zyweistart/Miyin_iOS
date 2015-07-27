//
//  RegisterViewController.m
//  ZMCY
//
//  Created by Start on 15/7/19.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController{
    CTextField *tUserName;
    CTextField *tPassword;
    CTextField *tRePassword;
    
}


- (id)init
{
    self=[super init];
    if(self){
        [self cTitle:@"注册"];
        //
        tUserName=[[CTextField alloc]initWithFrame:CGRectMake1(10, 20, 300, 40) Placeholder:@"邮箱/手机号"];
        [self.view addSubview:tUserName];
        //
        tPassword=[[CTextField alloc]initWithFrame:CGRectMake1(10, 70, 300, 40) Placeholder:@"请输入密码"];
        [tPassword setSecureTextEntry:YES];
        [self.view addSubview:tPassword];
        //
        tRePassword=[[CTextField alloc]initWithFrame:CGRectMake1(10, 120, 300, 40) Placeholder:@"请输入密码"];
        [tRePassword setSecureTextEntry:YES];
        [self.view addSubview:tRePassword];
        //
        CButton *bLogin=[[CButton alloc]initWithFrame:CGRectMake1(10, 170, 300, 40) Name:@"登录" Type:1];
        [self.view addSubview:bLogin];
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


@end
