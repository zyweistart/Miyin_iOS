//
//  EnterpriseNameModifyViewController.m
//  eClient
//
//  Created by Start on 3/23/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "EnterpriseNameModifyViewController.h"
#import "SVTextField.h"
#import "SVButton.h"

@interface EnterpriseNameModifyViewController ()

@end

@implementation EnterpriseNameModifyViewController{
    SVTextField *tfName;
    NSDictionary *currentData;
}

- (id)initWithParams:(NSDictionary *)data{
    currentData=data;
    self=[super init];
    if(self){
        [self setTitle:@"企业信息维护"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 100)];
    [self.view addSubview:frame];
    tfName=[[SVTextField alloc]initWithFrame:CGRectMake1(10, 5, 300, 40) Title:@"名称"];
    if(currentData){
        [tfName.tf setText:[currentData objectForKey:@"NAME"]];
    }
    [frame addSubview:tfName];
    //有监加盟商用户
    SVButton *bDefault=[[SVButton alloc]initWithFrame:CGRectMake1(10, 50, 145, 40) Title:@"设置默认" Type:2];
    [bDefault addTarget:self action:@selector(setDefault:) forControlEvents:UIControlEventTouchUpInside];
    [frame addSubview:bDefault];
    CGRect rect=CGRectMake1(165, 50, 145, 40);
    //有监一般客户
    SVButton *bSave=[[SVButton alloc]initWithFrame:rect Title:@"保存" Type:2];
    [bSave addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    [frame addSubview:bSave];
    
    NSString *roleType=[[User Instance]getRoleType];
    if([@"1" isEqualToString:roleType]){
        [bDefault setHidden:YES];
        rect=CGRectMake1(10, 50, 300, 40);
        [bSave setFrame:rect];
    }
}

- (void)setDefault:(id)sender
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[[User Instance]getUserName] forKey:@"imei"];
    [params setObject:[[User Instance]getPassword] forKey:@"authentication"];
    [params setObject:@"99010205" forKey:@"GNID"];
    [params setObject:[currentData objectForKey:@"CP_ID"] forKey:@"QTCP"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:501];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest handle:URL_appTaskingFps requestParams:params];
}

- (void)submit:(id)sender
{
    NSString *name=[tfName.tf text];
    if([@"" isEqualToString:name]){
        [Common alert:@"企业名称不能为空"];
        return;
    }
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[[User Instance]getUserName] forKey:@"imei"];
    [params setObject:[[User Instance]getPassword] forKey:@"authentication"];
    [params setObject:@"99010104" forKey:@"GNID"];
    [params setObject:[currentData objectForKey:@"CP_ID"] forKey:@"QTCP"];
    [params setObject:name forKey:@"QTKEY"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest handle:URL_appUserCenter requestParams:params];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if(reqCode==500){
        if([response successFlag]){
            [[User Instance] setCPName:[tfName.tf text]];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else if(reqCode==501){
        if([response successFlag]){
            [[User Instance] setCPName:[tfName.tf text]];
            [self.navigationController popToRootViewControllerAnimated:YES];
//            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

@end