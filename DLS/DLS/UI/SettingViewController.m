//
//  SettingViewController.m
//  DLS
//
//  Created by Start on 3/10/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "SettingViewController.h"
#import "ModifyPasswordViewController.h"
#import "FeedbackViewController.h"
#import "AboutUsViewController.h"
#import "ClauseViewController.h"

#define LOGOUTNORMALCOLOR [UIColor colorWithRed:(57/255.0) green:(87/255.0) blue:(207/255.0) alpha:1]
#define LOGOUTPRESENDCOLOR [UIColor colorWithRed:(107/255.0) green:(124/255.0) blue:(194/255.0) alpha:1]

@interface SettingViewController ()

@end

@implementation SettingViewController

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"设置"];
        //返回
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]
                                               initWithTitle:@"返回"
                                               style:UIBarButtonItemStyleBordered
                                               target:self
                                               action:@selector(goBack:)];
        
        self.dataItemArray=[[NSMutableArray alloc]init];
//        [self.dataItemArray addObject:[NSArray arrayWithObjects:@"把得力手分享给朋友", nil]];
        [self.dataItemArray addObject:[NSArray arrayWithObjects:@"修改密码", nil]];
        [self.dataItemArray addObject:[NSArray arrayWithObjects:@"意见反馈",@"服务条款",@"关于我们", nil]];
        
        self.tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
        [self.view addSubview:self.tableView];
        
        UIView *logoutView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 40)];
        UIButton *bLogout=[[UIButton alloc]initWithFrame:CGRectMake1(10, 0, 300, 40)];
        bLogout.layer.cornerRadius = 5;
        bLogout.layer.masksToBounds = YES;
        [bLogout setTitle:@"退出" forState:UIControlStateNormal];
        [bLogout.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [bLogout.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [bLogout setBackgroundImage:[Common createImageWithColor:LOGOUTNORMALCOLOR] forState:UIControlStateNormal];
        [bLogout setBackgroundImage:[Common createImageWithColor:LOGOUTPRESENDCOLOR] forState:UIControlStateHighlighted];
        [bLogout addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
        [logoutView addSubview:bLogout];
        [self.tableView setTableFooterView:logoutView];
    }
    return self;
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
    return CGHeight(10);
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1  reuseIdentifier: CMainCell];
    }
    NSInteger section=[indexPath section];
    NSInteger row=[indexPath row];
    NSString *content=[[self.dataItemArray objectAtIndex:section]objectAtIndex:row];
    [cell.imageView setImage:[UIImage imageNamed:content]];
    cell.textLabel.text = content;
//    if(!((section==0&&row==0))){
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
//    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section=[indexPath section];
    NSInteger row=[indexPath row];
    if(section==0){
//        if(row==0){
//            //分享
//            [Common alert:@"即将上线"];
//        }
//    }else if(section==0){
        if(row==0){
            //修改密码
            [self.navigationController pushViewController:[[ModifyPasswordViewController alloc]init] animated:YES];
        }
    }else if(section==1){
        if(row==0){
            //意见反馈
            [self.navigationController pushViewController:[[FeedbackViewController alloc]init] animated:YES];
        }else if(row==1){
            //服务条款
            [self.navigationController pushViewController:[[ClauseViewController alloc]init] animated:YES];
        }else if(row==2){
            //关于我们
            [self.navigationController pushViewController:[[AboutUsViewController alloc]init] animated:YES];
        }
    }
}

- (void)logout:(id)sender
{
    [[User Instance]clear];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end