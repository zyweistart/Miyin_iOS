//
//  RegisterViewController.m
//  eClient
//  注册
//  Created by Start on 3/20/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "RegisterViewController.h"
#import "SVTextField.h"
#import "SVButton.h"
#import "SVCheckbox.h"
#import "NSString+Utils.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController{
    SVTextField *svUserName;
    SVTextField *svPassword;
    NSString *USERNAME;
    NSString *PASSWORD;
    NSInteger type;
}

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"注册"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(0, 40, 320, 265)];
    [self.view addSubview:frame];
    type=1;
    [frame addSubview:[self createHeadTypeSwitch:52 imageName:@"manager" type:1]];
    [frame addSubview:[self createHeadTypeSwitch:187 imageName:@"elec" type:2]];
    svUserName=[[SVTextField alloc]initWithFrame:CGRectMake1(10, 115, 300, 40) Title:@"账号"];
    [frame addSubview:svUserName];
    svPassword=[[SVTextField alloc]initWithFrame:CGRectMake1(10, 165, 200, 40) Title:@"密码"];
    [frame addSubview:svPassword];
    SVButton *bGet=[[SVButton alloc]initWithFrame:CGRectMake1(220, 165, 90, 40) Title:@"获取" Type:2];
    [bGet addTarget:self action:@selector(get:) forControlEvents:UIControlEventTouchUpInside];
    [frame addSubview:bGet];
    SVButton *bLogin=[[SVButton alloc]initWithFrame:CGRectMake1(10, 215, 300, 40) Title:@"登陆" Type:2];
    [bLogin addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [frame addSubview:bLogin];
    [svUserName.tf setText:@"zhaox07"];
    [svPassword.tf setText:@"111111"];
}

- (void)get:(id)sender
{
    USERNAME=[svUserName.tf text];
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

- (UIView*)createHeadTypeSwitch:(CGFloat)x imageName:(NSString*)imageName type:(NSInteger)t
{
    UIView *vManager=[[UIView alloc]initWithFrame:CGRectMake1(x, 10,83, 83)];
    vManager.layer.cornerRadius = 5;
    vManager.layer.masksToBounds = YES;
    vManager.layer.borderWidth = 1;
    vManager.layer.borderColor = [TITLECOLOR CGColor];
    [vManager setBackgroundColor:[UIColor whiteColor]];
    UIImageView *head=[[UIImageView alloc]initWithFrame:CGRectMake1(15, 15, 53, 53)];
    [head setImage:[UIImage imageNamed:imageName]];
    [vManager addSubview:head];
    UIImageView *shead=[[UIImageView alloc]initWithFrame:CGRectMake1(65, 5, 13, 13)];
    if(type==t) {
        [shead setImage:[UIImage imageNamed:@"勾"]];
    }else{
        [shead setImage:[UIImage imageNamed:@"未勾"]];
    }
    [vManager addSubview:shead];
    [vManager setUserInteractionEnabled:YES];
    vManager.tag=t;
    [vManager addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sw:)]];
    return vManager;
}

- (void)sw:(UITapGestureRecognizer*)sender
{
    NSLog(@"%d",[sender.view tag]);
}

@end
