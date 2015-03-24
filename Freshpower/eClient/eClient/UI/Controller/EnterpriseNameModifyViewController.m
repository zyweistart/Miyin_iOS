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
}

- (id)init{
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
    NSLog(@"提交");
    [self.navigationController popViewControllerAnimated:YES];
}

@end
