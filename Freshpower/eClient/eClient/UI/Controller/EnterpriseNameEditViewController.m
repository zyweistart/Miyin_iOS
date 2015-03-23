//
//  EnterpriseNameEditViewController.m
//  eClient
//
//  Created by Start on 3/23/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "EnterpriseNameEditViewController.h"
#import "SVTextField.h"
#import "SVButton.h"

@interface EnterpriseNameEditViewController ()

@end

@implementation EnterpriseNameEditViewController{
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
    SVButton *bSubmit=[[SVButton alloc]initWithFrame:CGRectMake1(10, 50, 300, 40) Title:@"修改" Type:2];
    [bSubmit addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    [frame addSubview:bSubmit];
}

- (void)submit:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
