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
//    rect=CGRectMake(10, 50, 300, 40);
    SVButton *bSave=[[SVButton alloc]initWithFrame:rect Title:@"保存" Type:2];
    [bSave addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    [frame addSubview:bSave];
}

- (void)setDefault:(id)sender
{
    NSLog(@"设置为默认");
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)submit:(id)sender
{
    NSString *name=[tfName.tf text];
    if([@"" isEqualToString:name]){
        [Common alert:@"企业名称不能为空"];
        return;
    }
    NSDictionary *data=[[User Instance]getResultData];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[[User Instance]getUserName] forKey:@"imei"];
    [params setObject:[[User Instance]getPassword] forKey:@"authentication"];
    [params setObject:@"99010104" forKey:@"GNID"];
    [params setObject:[data objectForKey:@"CP_ID"] forKey:@"QTCP"];
    [params setObject:name forKey:@"QTKEY"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest handle:URL_appUserCenter requestParams:params];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if(reqCode==500){
        if([response successFlag]){
            [[[User Instance]getResultData] setObject:[tfName.tf text] forKey:@"CP_NAME"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

@end