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
        tfCode=[self addContentFrame:@"验证码" Placeholder:@"请输入验证码" TopX:260];
        
        UIView *vFrame=[[UIView alloc]initWithFrame:CGRectMake1(10, 210, 300, 40)];
        [scrollFrame addSubview:vFrame];
        UITextField *tfContent=[[UITextField alloc]initWithFrame:CGRectMake1(0, 0,190, 40)];
        [tfContent setFont:[UIFont systemFontOfSize:14]];
        [tfContent setTextAlignment:NSTextAlignmentCenter];
        [tfContent setPlaceholder:@"请输入手机号码"];
        [tfContent setTextColor:TITLECOLOR];
        tfContent.layer.cornerRadius = 5;
        tfContent.layer.masksToBounds = YES;
        tfContent.layer.borderWidth = 1;
        tfContent.layer.borderColor = [TITLECOLOR CGColor];
        [vFrame addSubview:tfContent];
        UIButton *bGet = [UIButton buttonWithType:UIButtonTypeCustom];
        [bGet setTitle:@"获取验证码" forState:UIControlStateNormal];
        [bGet.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [bGet setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bGet addTarget:self action:@selector(goGet:) forControlEvents:UIControlEventTouchUpInside];
        bGet.frame = CGRectMake(200, 0, 100, 40);
        bGet.layer.cornerRadius = 5;
        bGet.layer.masksToBounds = YES;
        [bGet setBackgroundImage:[Common createImageWithColor:GETNORMALCOLOR] forState:UIControlStateNormal];
        [bGet setBackgroundImage:[Common createImageWithColor:GETPRESENCOLOR] forState:UIControlStateHighlighted];
        [vFrame addSubview:bGet];
        
        //登陆
        UIButton *bLogin=[[UIButton alloc]initWithFrame:CGRectMake1(10, 310, 300, 40)];
        bLogin.layer.cornerRadius = 5;
        bLogin.layer.masksToBounds = YES;
        [bLogin setTitle:@"登陆" forState:UIControlStateNormal];
        [bLogin.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [bLogin.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [bLogin setBackgroundImage:[Common createImageWithColor:REGISTERNORMALCOLOR] forState:UIControlStateNormal];
        [bLogin setBackgroundImage:[Common createImageWithColor:REGISTERPRESENDCOLOR] forState:UIControlStateHighlighted];
        [bLogin addTarget:self action:@selector(goRegister:) forControlEvents:UIControlEventTouchUpInside];
        [scrollFrame addSubview:bLogin];
    }
    return self;
}

- (void)goGet:(id)sender
{
    NSLog(@"获取验证码");
}

- (void)goRegister:(id)sender
{
    NSLog(@"注册");
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
    [vFrame addSubview:tfContent];
    return tfContent;
}


@end
