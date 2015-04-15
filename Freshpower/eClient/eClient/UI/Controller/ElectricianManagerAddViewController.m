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
    [svSex setImage:[UIImage imageNamed:@"男"] forState:UIControlStateNormal];
    [svSex setImage:[UIImage imageNamed:@"nv"] forState:UIControlStateSelected];
    [frame addSubview:svSex];
    SVButton *bSave=[[SVButton alloc]initWithFrame:CGRectMake1(10, 200, 300, 40) Title:@"保存" Type:2];
    [bSave addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    [frame addSubview:bSave];
}

- (void)save:(id)sender
{
    NSString *name=[svName.tf text];
    NSString *phone=[svPhone.tf text];
    NSString *card=[svCard.tf text];
//    if([@"" isEqualToString:name]){
//        [Common alert:@"请填写用户名"];
//        return;
//    }
//    if([@"" isEqualToString:phone]){
//        [Common alert:@"请填写手机号码"];
//        return;
//    }
//    if([phone length]!=11){
//        [Common alert:@"请填写正确的手机号码"];
//        return;
//    }
//    if([@"" isEqualToString:card]){
//        [Common alert:@"请填写身份证号码"];
//        return;
//    }
//    if([card length]!=18){
//        [Common alert:@"请填写正确的身份证号码"];
//        return;
//    }
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[[User Instance]getUserName] forKey:@"imei"];
    [params setObject:[[User Instance]getPassword] forKey:@"authentication"];
    [params setObject:[self.paramData objectForKey:@"CP_ID"] forKey:@"QTCP"];//
    [params setObject:@"AC11" forKey:@"GNID"];
    [params setObject:@"" forKey:@"QTUSER"];
    [params setObject:name forKey:@"QTKEY"];
    [params setObject:phone forKey:@"QTVAL"];
    [params setObject:card forKey:@"QTKEY1"];
    if(!svSex.selected){
        [params setObject:@"1" forKey:@"QTVAL1"];
    }else{
        [params setObject:@"0" forKey:@"QTVAL1"];
    }
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest handle:URL_appTaskingFps requestParams:params];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if([response successFlag]){
        [Common alert:[response msg]];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
