//
//  ElectricianManagerSearchViewController.m
//  eClient
//  企业电工搜索
//  Created by Start on 3/24/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "ElectricianManagerSearchViewController.h"
#import "ElectricianManagerListViewController.h"
#import "SVTextField.h"
#import "SVButton.h"
#import "NSString+Utils.h"

@interface ElectricianManagerSearchViewController ()

@end

@implementation ElectricianManagerSearchViewController{
    SVTextField *svName;
    SVTextField *svPhone;
}

- (id)initWithParams:(NSDictionary*)data{
    self=[super initWithParams:data];
    if(self){
        [self setTitle:@"搜索"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 150)];
    [self.view addSubview:frame];
    svName=[[SVTextField alloc]initWithFrame:CGRectMake1(10, 5, 300, 40) Title:@"姓名"];
    [frame addSubview:svName];
    svPhone=[[SVTextField alloc]initWithFrame:CGRectMake1(10, 50, 300, 40) Title:@"手机"];
    [frame addSubview:svPhone];
    SVButton *bSearch=[[SVButton alloc]initWithFrame:CGRectMake1(10, 100, 300, 40) Title:@"查询" Type:2];
    [bSearch addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
    [frame addSubview:bSearch];
}

- (void)search:(id)sender
{
    NSString *name=[svName.tf text];
    NSString *phone=[svPhone.tf text];
    [self.paramData setObject:name forKey:@"PARAMSNAME"];
    [self.paramData setObject:phone forKey:@"PARAMSPHONE"];
    [self.navigationController pushViewController:[[ElectricianManagerListViewController alloc]initWithParams:self.paramData] animated:YES];
}

@end
