//
//  RegisterViewController.m
//  DLS
//
//  Created by Start on 3/5/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "RegisterViewController.h"
#define TITLECOLOR [UIColor colorWithRed:(200/255.0) green:(200/255.0) blue:(200/255.0) alpha:1]
#define REGISTERNORMALCOLOR [UIColor colorWithRed:(57/255.0) green:(87/255.0) blue:(207/255.0) alpha:1]
#define REGISTERPRESENDCOLOR [UIColor colorWithRed:(107/255.0) green:(124/255.0) blue:(194/255.0) alpha:1]
#define GETNORMALCOLOR [UIColor colorWithRed:(52/255.0) green:(177/255.0) blue:(59/255.0) alpha:1]
#define GETPRESENCOLOR [UIColor colorWithRed:(125/255.0) green:(195/255.0) blue:(136/255.0) alpha:1]

@interface RegisterViewController ()

@end

@implementation RegisterViewController{
    UIScrollView *scrollFrame;
    UITextField *tfUserName;
    UITextField *tfPassword;
    UITextField *tfName;
    UITextField *tfIDCard;
    UITextField *tfPhone;
    UITextField *tfCode;
    UILabel *tfRole;
    NSInteger pvv1;
}

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"注册"];
        //返回
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]
                                               initWithTitle:@"返回"
                                               style:UIBarButtonItemStyleBordered
                                               target:self
                                               action:@selector(goBack:)];
        
        scrollFrame=[[UIScrollView alloc]initWithFrame:self.view.bounds];
        [scrollFrame setContentSize:CGSizeMake(320, 600)];
        [self.view addSubview:scrollFrame];
        
        tfUserName=[self addContentFrame:@"账号" Placeholder:@"请输入账号" TopX:10];
        tfPassword=[self addContentFrame:@"密码" Placeholder:@"请输入密码" TopX:60];
        tfName=[self addContentFrame:@"姓名" Placeholder:@"请输入姓名" TopX:110];
        tfIDCard=[self addContentFrame:@"身份证" Placeholder:@"请输入身份证号码" TopX:160];
        tfRole=[self addContentFrame1:@"角色" TopX:210];
        tfCode=[self addContentFrame:@"验证码" Placeholder:@"请输入验证码" TopX:310];
        
        UIView *vFrame=[[UIView alloc]initWithFrame:CGRectMake1(10, 260, 300, 40)];
        [scrollFrame addSubview:vFrame];
        tfPhone=[[UITextField alloc]initWithFrame:CGRectMake1(0, 0,190, 40)];
        [tfPhone setFont:[UIFont systemFontOfSize:14]];
        [tfPhone setTextAlignment:NSTextAlignmentCenter];
        [tfPhone setPlaceholder:@"请输入手机号码"];
        [tfPhone setTextColor:TITLECOLOR];
        [tfPhone setDelegate:self];
        tfPhone.layer.cornerRadius = 5;
        tfPhone.layer.masksToBounds = YES;
        tfPhone.layer.borderWidth = 1;
        tfPhone.layer.borderColor = [TITLECOLOR CGColor];
        [vFrame addSubview:tfPhone];
        UIButton *bGet = [UIButton buttonWithType:UIButtonTypeCustom];
        [bGet setTitle:@"获取验证码" forState:UIControlStateNormal];
        [bGet.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [bGet setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bGet addTarget:self action:@selector(goGet:) forControlEvents:UIControlEventTouchUpInside];
        bGet.frame = CGRectMake1(200, 0, 100, 40);
        bGet.layer.cornerRadius = 5;
        bGet.layer.masksToBounds = YES;
        [bGet setBackgroundImage:[Common createImageWithColor:GETNORMALCOLOR] forState:UIControlStateNormal];
        [bGet setBackgroundImage:[Common createImageWithColor:GETPRESENCOLOR] forState:UIControlStateHighlighted];
        [vFrame addSubview:bGet];
        
        //登陆
        UIButton *bLogin=[[UIButton alloc]initWithFrame:CGRectMake1(10, 360, 300, 40)];
        bLogin.layer.cornerRadius = 5;
        bLogin.layer.masksToBounds = YES;
        [bLogin setTitle:@"注册" forState:UIControlStateNormal];
        [bLogin.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [bLogin.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [bLogin setBackgroundImage:[Common createImageWithColor:REGISTERNORMALCOLOR] forState:UIControlStateNormal];
        [bLogin setBackgroundImage:[Common createImageWithColor:REGISTERPRESENDCOLOR] forState:UIControlStateHighlighted];
        [bLogin addTarget:self action:@selector(goRegister:) forControlEvents:UIControlEventTouchUpInside];
        [scrollFrame addSubview:bLogin];
        
        self.pv1=[[SinglePickerView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-CGHeight(260), CGWidth(320), CGHeight(260)) WithArray:[CommonData getRole]];
        [self.pv1 setCode:1];
        [self.pv1 setDelegate:self];
        [self.view addSubview:self.pv1];
    }
    return self;
}

- (UITextField*)addContentFrame:(NSString*)title Placeholder:(NSString*)placeholder TopX:(CGFloat)topx
{
    UIView *vFrame=[[UIView alloc]initWithFrame:CGRectMake1(10, topx, 300, 40)];
    vFrame.layer.cornerRadius = 5;
    vFrame.layer.masksToBounds = YES;
    vFrame.layer.borderWidth = 1;
    vFrame.layer.borderColor = [TITLECOLOR CGColor];
    [scrollFrame addSubview:vFrame];
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(0, 0, 50, 40)];
    [lbl setText:title];
    [lbl setFont:[UIFont systemFontOfSize:14]];
    [lbl setTextAlignment:NSTextAlignmentCenter];
    [lbl setTextColor:TITLECOLOR];
    [vFrame addSubview:lbl];
    UITextField *tfContent=[[UITextField alloc]initWithFrame:CGRectMake1(50, 0,250, 40)];
    [tfContent setPlaceholder:placeholder];
    [tfContent setFont:[UIFont systemFontOfSize:14]];
    [tfContent setTextColor:TITLECOLOR];
    [tfContent setDelegate:self];
    [vFrame addSubview:tfContent];
    return tfContent;
}

- (UILabel*)addContentFrame1:(NSString*)title TopX:(CGFloat)topx
{
    UIView *vFrame=[[UIView alloc]initWithFrame:CGRectMake1(10, topx, 300, 40)];
    vFrame.layer.cornerRadius = 5;
    vFrame.layer.masksToBounds = YES;
    vFrame.layer.borderWidth = 1;
    vFrame.layer.borderColor = [TITLECOLOR CGColor];
    [scrollFrame addSubview:vFrame];
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(0, 0, 50, 40)];
    [lbl setText:title];
    [lbl setFont:[UIFont systemFontOfSize:14]];
    [lbl setTextAlignment:NSTextAlignmentCenter];
    [lbl setTextColor:TITLECOLOR];
    [vFrame addSubview:lbl];
    lbl=[[UILabel alloc]initWithFrame:CGRectMake1(50, 0,250, 40)];
    [lbl setText:@"请选择"];
    [lbl setFont:[UIFont systemFontOfSize:14]];
    [lbl setTextAlignment:NSTextAlignmentLeft];
    [lbl setTextColor:TITLECOLOR];
    [lbl setUserInteractionEnabled:YES];
    [lbl addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goSRole:)]];
    [vFrame addSubview:lbl];
    return lbl;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)goGet:(id)sender
{
    NSString *phone=[tfPhone text];
    if([@""isEqualToString:phone]){
        [Common alert:@"手机号码不能为空"];
        return;
    }
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:phone forKey:@"phone"];
    [params setObject:@"717747" forKey:@"SMSId"];
    NSMutableDictionary *params1=[[NSMutableDictionary alloc]init];
    [params1 setObject:@"1234" forKey:@"code"];
    [params setObject:params1 forKey:@"parJson"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:501];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest handle:@"SendSMS" requestParams:params];
}

- (void)goRegister:(id)sender
{
    NSString *username=[tfUserName text];
    NSString *password=[tfPassword text];
//    NSString *name=[tfName text];
//    NSString *idcard=[tfIDCard text];
    NSString *phone=[tfPhone text];
    NSString *code=[tfCode text];
    NSDictionary *d=[self.pv1.pickerArray objectAtIndex:pvv1];
    NSString *role=[d objectForKey:MVALUE];
    if([@""isEqualToString:username]){
        [Common alert:@"账号不能为空"];
        return;
    }
    if([@""isEqualToString:password]){
        [Common alert:@"密码不能为空"];
        return;
    }
    if([@""isEqualToString:role]){
        [Common alert:@"个人角色不能为空"];
        return;
    }
    if([@""isEqualToString:phone]){
        [Common alert:@"手机号不能为空"];
        return;
    }
    if([@""isEqualToString:code]){
        [Common alert:@"验证码不能为空"];
        return;
    }
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:username forKey:@"userName"];
    [params setObject:password forKey:@"pwd"];
    [params setObject:password forKey:@"pwd2"];
    [params setObject:phone forKey:@"phone"];
    [params setObject:role forKey:@"per_roles"];
    [params setObject:code forKey:@"SMSCode"];
//    [params setObject:name forKey:@"name"];
//    [params setObject:idcard forKey:@"idcard"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:502];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest handle:@"RegUser" requestParams:params];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if(reqCode==501){
        if([response successFlag]){
            [Common alert:[response msg]];
        }
    }else if(reqCode==502){
        if([response successFlag]){
            [Common alert:@"注册成功"];
            [[self resultDelegate]onControllerResult:RESULTCODE_LOGIN data:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

- (void)goSRole:(id)sender
{
    [self.pv1 setHidden:![self.pv1 isHidden]];
}

- (void)pickerViewDone:(int)code
{
    if(code==1){
        pvv1=[self.pv1.picker selectedRowInComponent:0];
        NSDictionary *d=[self.pv1.pickerArray objectAtIndex:pvv1];
        [tfRole setText:[d objectForKey:MKEY]];
    }
}

@end