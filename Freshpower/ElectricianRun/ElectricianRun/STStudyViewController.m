//
//  STStudyViewController.m
//  ElectricianRun
//  我要学习
//  Created by Start on 1/24/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STStudyViewController.h"
#import "STNavigationWebPageViewController.h"
#import "STSignupViewController.h"

#define REQUESTCODESUBMIT 43281794

@interface STStudyViewController () {
    NSArray *titleArr;
}

@end

@implementation STStudyViewController {
    NSString *phone;
}

- (id)init {
    self=[super init];
    if(self) {
        self.title=@"我要学习";
        [self.view setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if([Common getCacheByBool:ISMYSTUDYAUDIT]){
        //如果审核通过则直接进入
        [self loadData];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"我要学习"
                              message:@"手机号码"
                              delegate:self
                              cancelButtonTitle:@"取消"
                              otherButtonTitles:@"确定",nil];
        [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
        //设置输入框的键盘类型
        UITextField *tf = [alert textFieldAtIndex:0];
        tf.keyboardType = UIKeyboardTypeNumberPad;
        [alert show];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [titleArr count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath{
    static NSString *CellIdentifier=@"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSInteger row=[indexPath row];
    
    cell.textLabel.font=[UIFont systemFontOfSize:13];
    cell.textLabel.text=[titleArr objectAtIndex:row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row=[indexPath row];
    STNavigationWebPageViewController *navigationWebPageViewController=[[STNavigationWebPageViewController alloc]initWithNavigationTitle:[titleArr objectAtIndex:row] resourcePath:[titleArr objectAtIndex:row]];
    [self.navigationController pushViewController:navigationWebPageViewController animated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1){
        phone=[[alertView textFieldAtIndex:0]text];
        if(![@"" isEqualToString:phone]){
            if([phone length]!=11){
                [Common alert:@"请输入正确的手机号码"];
                self.tabBarController.selectedIndex=0;
                return;
            }
            NSMutableDictionary *p=[[NSMutableDictionary alloc]init];
            [p setObject:phone forKey:@"telNum"];
            [p setObject:@"" forKey:@"identityNo"];
            [p setObject:@"3" forKey:@"operateType"];
            self.hRequest=[[HttpRequest alloc]init:self delegate:self responseCode:REQUESTCODESUBMIT];
            [self.hRequest setIsShowMessage:YES];
            [self.hRequest start:URLelecRegister params:p];
        }else{
            [Common alert:@"请输入手机号码"];
            self.tabBarController.selectedIndex=0;
        }
    }else{
        self.tabBarController.selectedIndex=0;
    }
}

- (void)requestFinishedByResponse:(Response*)response responseCode:(int)repCode
{
    if(repCode==REQUESTCODESUBMIT){
        NSString *result=[[response resultJSON]objectForKey:@"rs"];
        [Common setCacheByBool:ISMYSTUDYAUDIT data:NO];
        if([@"0" isEqualToString:result]){
            [Common alert:@"审核不通过"];
            self.tabBarController.selectedIndex=0;
        }else if([@"1" isEqualToString:result]){
            //审核通过
            [self loadData];
            [Common setCacheByBool:ISMYSTUDYAUDIT data:YES];
        }else if([@"2" isEqualToString:result]){
            [Common alert:@"审核中"];
            self.tabBarController.selectedIndex=0;
        }else if([@"3" isEqualToString:result]){
            [Common alert:@"未提交申请"];
            UINavigationController *signupViewControllerNav = [[UINavigationController alloc] initWithRootViewController:[[STSignupViewController alloc]initWithPhone:phone]];
            [self presentViewController:signupViewControllerNav animated:YES completion:nil];
            self.tabBarController.selectedIndex=0;
        }else{
            [Common alert:@"未知错误"];
            self.tabBarController.selectedIndex=0;
        }
    }
}

- (void)loadData
{
    titleArr=[[NSArray alloc]initWithObjects:
              @"TRMS系统变电站失电报警装置安装调试教程",
              @"TRMS系统变电站远程监测服务安装调试教程",
              @"TRMS系统巡检工作服务规范(e电工版)",
              @"TRMS系统现场安装调试问题处理指南",nil];
    [self.tableView reloadData];
}

@end
