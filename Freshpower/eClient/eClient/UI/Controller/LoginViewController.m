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
    [frame addSubview:bLogin];
}

@end
