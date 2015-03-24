//
//  ElectricianManagerAddViewController.m
//  eClient
//
//  Created by Start on 3/24/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "ElectricianManagerAddViewController.h"

#import "SVTextField.h"
#import "SVButton.h"
#import "SVCheckbox.h"

@interface ElectricianManagerAddViewController ()

@end

@implementation ElectricianManagerAddViewController{
    SVTextField *svName;
    SVTextField *svPhone;
    SVTextField *svCard;
    SVCheckbox *svSex;
}

- (id)initWithParams:(NSDictionary*)data{
    self=[super initWithParams:data];
    if(self){
        [self setTitle:@"添加巡检人员"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 250)];
    [self.view addSubview:frame];
    svName=[[SVTextField alloc]initWithFrame:CGRectMake1(10, 5, 300, 40) Title:@"姓名"];
    [frame addSubview:svName];
    svPhone=[[SVTextField alloc]initWithFrame:CGRectMake1(10, 50, 300, 40) Title:@"手机"];
    [frame addSubview:svPhone];
    svCard=[[SVTextField alloc]initWithFrame:CGRectMake1(10, 100, 300, 40) Title:@"身份证"];
    [frame addSubview:svCard];
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(20, 150, 40, 40)];
    [lbl setText:@"性别"];
    [lbl setTextColor:TITLECOLOR];
    [lbl setFont:[UIFont systemFontOfSize:14]];
    [frame addSubview:lbl];
    svSex=[[SVCheckbox alloc]initWithFrame:CGRectMake1(260, 150, 40, 40)];
    [frame addSubview:svSex];
    SVButton *bSave=[[SVButton alloc]initWithFrame:CGRectMake1(10, 200, 300, 40) Title:@"保存" Type:2];
    [bSave addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    [frame addSubview:bSave];
}

- (void)save:(id)sender
{
    
}

@end
