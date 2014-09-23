//
//  STLoginViewController.m
//  ElectricianRun
//  登录
//  Created by Start on 1/24/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STLoginViewController.h"
#import "NSString+Utils.h"
#import "STIndexViewController.h"
#import "STFindElectricianMapViewController.h"
#import "STMyeViewController.h"
#import "STGuideViewController.h"

@interface STLoginViewController ()

@end

@implementation STLoginViewController {
    UITextField *txtValueUserName;
    UITextField *txtValuePassword;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.title=@"登录";
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]
                                               initWithTitle:@"返回"
                                               style:UIBarButtonItemStyleBordered
                                               target:self
                                               action:@selector(back:)];
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]
                                               initWithTitle:@"登录"
                                               style:UIBarButtonItemStyleBordered
                                               target:self
                                               action:@selector(login:)];
    }
    return self;
}

- (void)back:(id)sender
{
    STGuideViewController *guideViewController=[[STGuideViewController alloc]init];
    [self presentViewController:guideViewController animated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIControl *control=[[UIControl alloc]initWithFrame:CGRectMake(0, 80, 320, 130)];
    [control setHidden:NO];
    [control addTarget:self action:@selector(backgroundDoneEditing:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:control];
    
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 70, 30)];
    lbl.font=[UIFont systemFontOfSize:12.0];
    [lbl setText:@"账户"];
    [lbl setTextColor:[UIColor blackColor]];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setTextAlignment:NSTextAlignmentRight];
    [control addSubview:lbl];
    
    txtValueUserName=[[UITextField alloc]initWithFrame:CGRectMake(90, 10, 200, 30)];
    [txtValueUserName setFont:[UIFont systemFontOfSize: 12.0]];
    [txtValueUserName setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtValueUserName setBorderStyle:UITextBorderStyleRoundedRect];
    [txtValueUserName setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [txtValueUserName setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [control addSubview:txtValueUserName];
    
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 50, 70, 30)];
    lbl.font=[UIFont systemFontOfSize:12.0];
    [lbl setText:@"密码"];
    [lbl setTextColor:[UIColor blackColor]];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setTextAlignment:NSTextAlignmentRight];
    [control addSubview:lbl];
    
    txtValuePassword=[[UITextField alloc]initWithFrame:CGRectMake(90, 50, 200, 30)];
    [txtValuePassword setFont:[UIFont systemFontOfSize: 12.0]];
    [txtValuePassword setClearButtonMode:UITextFieldViewModeWhileEditing];
    [txtValuePassword setBorderStyle:UITextBorderStyleRoundedRect];
    [txtValuePassword setSecureTextEntry:YES];
    [txtValuePassword setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [txtValuePassword setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [control addSubview:txtValuePassword];
    
//    [txtValueUserName setText:@"xb"];
//    [txtValuePassword setText:@"8888aa"];
    
    [Account clear];
}

- (void)backgroundDoneEditing:(id)sender {
    [txtValueUserName resignFirstResponder];
    [txtValuePassword resignFirstResponder];
}

- (void)login:(id)sender {
    
    NSString *username=[txtValueUserName text];
    NSString *password=[txtValuePassword text];
    if([@"" isEqualToString:username]){
        [Common alert:@"账户输入有误"];
    }else if([@"" isEqualToString:password]){
        [Common alert:@"密码输入有误"];
    }else{
        NSMutableDictionary *p=[[NSMutableDictionary alloc]init];
        [p setObject:username forKey:@"imei"];
        [p setObject:[[password uppercaseString] md5] forKey:@"authentication"];
        [p setObject:@"2" forKey:@"type"];
        
        self.hRequest=[[HttpRequest alloc]init:self delegate:self responseCode:500];
        [self.hRequest setIsShowMessage:YES];
        [self.hRequest start:URLcheckMobileValid params:p];
    }
}

- (void)requestFinishedByResponse:(Response*)response responseCode:(int)repCode
{
    NSString *result=[Common NSNullConvertEmptyString:[[response resultJSON] objectForKey:@"result"]];
    if([@"1" isEqualToString:result]){
        NSString *username=[txtValueUserName text];
        NSString *password=[txtValuePassword text];
        [Account LoginSuccessWithUserName:username Password:password Data:[response resultJSON]];
        [Common alert:@"登录成功"];
        
        //首页
        STIndexViewController *indexViewController = [[STIndexViewController alloc]init];
        indexViewController.tabBarItem.title=@"首页";
        indexViewController.tabBarItem.image=[UIImage imageNamed:@"sy2"];
        //我要学习
        UINavigationController *findElectricianMapViewControllerNav = [[UINavigationController alloc] initWithRootViewController:[[STFindElectricianMapViewController alloc]init]];
        findElectricianMapViewControllerNav.tabBarItem.title=@"找电工";
        findElectricianMapViewControllerNav.tabBarItem.image=[UIImage imageNamed:@"dg2"];
        //我的e电工
        UINavigationController *myeViewControllerNav = [[UINavigationController alloc] initWithRootViewController:[[STMyeViewController alloc]init]];
        myeViewControllerNav.tabBarItem.title=@"我的e电工";
        myeViewControllerNav.tabBarItem.image=[UIImage imageNamed:@"e2"];
        
        UITabBarController *tabBarController=[[UITabBarController alloc]init];
        [tabBarController setViewControllers:[NSArray arrayWithObjects:
                                              indexViewController,
                                              findElectricianMapViewControllerNav,
                                              myeViewControllerNav,
                                              nil] animated:YES];
        [self presentViewController:tabBarController animated:YES completion:nil];
    }else{
        [Common alert:@"用户名或密码有误，请重试!"];
    }
}

@end