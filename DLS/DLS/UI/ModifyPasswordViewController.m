//
//  ModifyPasswordViewController.m
//  DLS
//  修改密码
//  Created by Start on 3/13/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "ModifyPasswordViewController.h"
#import "NSString+Utils.h"

#define TITLECOLOR [UIColor colorWithRed:(200/255.0) green:(200/255.0) blue:(200/255.0) alpha:1]
#define MPNORMALCOLOR [UIColor colorWithRed:(57/255.0) green:(87/255.0) blue:(207/255.0) alpha:1]
#define MPPRESENDCOLOR [UIColor colorWithRed:(107/255.0) green:(124/255.0) blue:(194/255.0) alpha:1]

@interface ModifyPasswordViewController ()

@end

@implementation ModifyPasswordViewController{
    UITextField *tfOldPwd,*tfNewPwd,*tfReNewPwd;
}

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"修改密码"];
        
        tfOldPwd=[self addTextFieldFrame:10 Title:@"旧密码" Placeholder:@"请输入旧密码"];
        tfNewPwd=[self addTextFieldFrame:60 Title:@"新密码" Placeholder:@"请输入新密码"];
        tfReNewPwd=[self addTextFieldFrame:110 Title:@"新密码" Placeholder:@"请再次输入新密码"];
        //
        UIButton *bModifyPwd=[[UIButton alloc]initWithFrame:CGRectMake1(10, 160, 300, 40)];
        bModifyPwd.layer.cornerRadius = 5;
        bModifyPwd.layer.masksToBounds = YES;
        [bModifyPwd setTitle:@"确认修改" forState:UIControlStateNormal];
        [bModifyPwd.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [bModifyPwd.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [bModifyPwd setBackgroundImage:[Common createImageWithColor:MPNORMALCOLOR] forState:UIControlStateNormal];
        [bModifyPwd setBackgroundImage:[Common createImageWithColor:MPPRESENDCOLOR] forState:UIControlStateHighlighted];
        [bModifyPwd addTarget:self action:@selector(modifyPwd:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:bModifyPwd];
    }
    return self;
}


- (UITextField*)addTextFieldFrame:(CGFloat)y Title:(NSString*)title Placeholder:(NSString*)placeholder
{
    UIView *vFrame=[[UIView alloc]initWithFrame:CGRectMake1(10, y, 300, 40)];
    vFrame.layer.cornerRadius = 5;
    vFrame.layer.masksToBounds = YES;
    vFrame.layer.borderWidth = 1;
    vFrame.layer.borderColor = [TITLECOLOR CGColor];
    [self.view addSubview:vFrame];
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(0, 0, 50, 40)];
    [lbl setText:title];
    [lbl setFont:[UIFont systemFontOfSize:14]];
    [lbl setTextAlignment:NSTextAlignmentCenter];
    [lbl setTextColor:TITLECOLOR];
    [vFrame addSubview:lbl];
    UITextField *tfPassword=[[UITextField alloc]initWithFrame:CGRectMake1(50, 0,250, 40)];
    [tfPassword setFont:[UIFont systemFontOfSize:14]];
    [tfPassword setPlaceholder:placeholder];
    [tfPassword setTextColor:TITLECOLOR];
    [tfPassword setClearButtonMode:UITextFieldViewModeWhileEditing];
    [tfPassword setSecureTextEntry:YES];
    [vFrame addSubview:tfPassword];
    return tfPassword;
}

- (void)modifyPwd:(id)sender
{
    NSString *oldPwd=[tfOldPwd text];
    if([@""isEqualToString:oldPwd]){
        [Common alert:@"旧密码不能为空"];
        return;
    }
    NSString *newPwd=[tfNewPwd text];
    if([@""isEqualToString:newPwd]){
        [Common alert:@"新密码不能为空"];
        return;
    }
    NSString *reNewPwd=[tfReNewPwd text];
    if(![newPwd isEqualToString:reNewPwd]){
        [Common alert:@"两次密码不相同"];
        return;
    }
    newPwd=[[[newPwd md5] lowercaseString] substringWithRange:NSMakeRange(6, 16)];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[[User Instance]accessToken] forKey:@"access_token"];
    [params setObject:newPwd forKey:@"pwd"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest handle:@"UpdateUser" requestParams:params];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if([response successFlag]){
        [Common alert:@"密码修改成功"];
        NSString *newPwd=[tfNewPwd text];
        [Common setCache:ACCOUNTPASSWORD data:newPwd];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
