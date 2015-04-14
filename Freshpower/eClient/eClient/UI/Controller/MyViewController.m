//
//  MyViewController.m
//  eClient
//  我的
//  Created by Start on 3/20/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "MyViewController.h"
#import "SVButton.h"
#import "MaintainEnterpriseInformationViewController.h"
#import "EnterpriseNameModifyViewController.h"
#import "LoginViewController.h"
#import "STAboutUsViewController.h"
#import "ModifyPwdViewController.h"

#define HEADTITLECOLOR [UIColor colorWithRed:(200/255.0) green:(200/255.0) blue:(200/255.0) alpha:1]

@interface MyViewController ()

@end

@implementation MyViewController{
    UILabel *lblAccount;
}

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"我的"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataItemArray=[[NSMutableArray alloc]init];
    [self.dataItemArray addObject:[NSArray arrayWithObjects:@"维护企业信息", nil]];
    [self.dataItemArray addObject:[NSArray arrayWithObjects:@"关于e电工",@"联系新能量",@"推荐给好友", nil]];
    self.tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.view addSubview:self.tableView];
    UIView *topFrame=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 55)];
    [topFrame setBackgroundColor:[UIColor orangeColor]];
    [self.tableView setTableHeaderView:topFrame];
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake1(10, 10, 40, 40)];
    [image setImage:[UIImage imageNamed:@"报警信息"]];
    [topFrame addSubview:image];
    lblAccount=[[UILabel alloc]initWithFrame:CGRectMake1(60, 5, 100, 20)];
    [lblAccount setFont:[UIFont systemFontOfSize:14]];
    [lblAccount setTextColor:HEADTITLECOLOR];
    [topFrame addSubview:lblAccount];
    UIButton *bModifyPwd=[[UIButton alloc]initWithFrame:CGRectMake1(60, 30, 100, 20)];
    [bModifyPwd setTitle:@"修改密码" forState:UIControlStateNormal];
    [bModifyPwd.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [bModifyPwd setTitleColor:HEADTITLECOLOR forState:UIControlStateNormal];
    [bModifyPwd setImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
    [bModifyPwd addTarget:self action:@selector(modifyPwd:) forControlEvents:UIControlEventTouchUpInside];
    [topFrame addSubview:bModifyPwd];
    UIButton *bSwitchUser=[[UIButton alloc]initWithFrame:CGRectMake1(210, 15, 100, 25)];
    [bSwitchUser setTitle:@"切换用户" forState:UIControlStateNormal];
    [bSwitchUser.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [bSwitchUser setTitleColor:HEADTITLECOLOR forState:UIControlStateNormal];
    bSwitchUser.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [bSwitchUser addTarget:self action:@selector(switchUser:) forControlEvents:UIControlEventTouchUpInside];
    [topFrame addSubview:bSwitchUser];
    UIView *bottomFrame=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 40)];
    [self.tableView setTableFooterView:bottomFrame];
    SVButton *bLogout=[[SVButton alloc]initWithFrame:CGRectMake1(10, 0, 300, 40) Title:@"安全退出" Type:2];
    [bLogout addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
    [bottomFrame addSubview:bLogout];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if([[User Instance]isLogin]){
        [lblAccount setText:[[[User Instance]getResultData]objectForKey:@"NAME"]];
    }else{
        [self.navigationController pushViewController:[[LoginViewController alloc]init] animated:YES];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataItemArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.dataItemArray objectAtIndex:section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGHeight(10);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CGHeight(45);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CMainCell = @"CMainCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CMainCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier: CMainCell];
    }
    NSString *content=[[self.dataItemArray objectAtIndex:[indexPath section]]objectAtIndex:[indexPath row]];
    [cell.imageView setImage:[UIImage imageNamed:content]];
    cell.textLabel.text = content;
    NSInteger section=[indexPath section];
    NSInteger row=[indexPath row];
    if(section==0){
        if(row==0){
            NSString *role=[[User Instance]getRoleType];
            NSString *cpName=[[User Instance]getCPName];
            if([@"2"isEqualToString:role]||[@"4"isEqualToString:role]){
                cell.detailTextLabel.text=@"切企业换后，负荷和电量等用电数据会发生变化";
            }else if([@"1" isEqualToString:role]&&[@"" isEqualToString:cpName]){
                cell.detailTextLabel.text=@"请先维护企业名称信息方可进行巡检任务下发操作";
            }
        }
    }
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section=[indexPath section];
    NSInteger row=[indexPath row];
    if(section==0){
        if(row==0){
            if([@"" isEqualToString:[[User Instance]getCPName]]){
                [self.navigationController pushViewController:[[EnterpriseNameModifyViewController alloc]init] animated:YES];
            }else{
                [self.navigationController pushViewController:[[MaintainEnterpriseInformationViewController alloc]init] animated:YES];
            }
        }
    }else if(section==1){
        if(row==0){
            [self.navigationController pushViewController:[[STAboutUsViewController alloc]init] animated:YES];
        }else if(row==1){
            //联系新能量
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[NSString alloc] initWithFormat:@"tel://%@",CUSTOMERSERVICETEL]]];
        }
    }
}

- (void)switchUser:(id)sender
{
    [[User Instance]clear];
    [self.navigationController pushViewController:[[LoginViewController alloc]init] animated:YES];
}

- (void)modifyPwd:(id)sender
{
    [self.navigationController pushViewController:[[ModifyPwdViewController alloc]init] animated:YES];
}

- (void)logout:(id)sender
{
    [[User Instance]clear];
    [self.navigationController pushViewController:[[LoginViewController alloc]init] animated:YES];
}

@end