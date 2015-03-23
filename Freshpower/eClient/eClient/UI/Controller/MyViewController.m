//
//  MyViewController.m
//  eClient
//  我的
//  Created by Start on 3/20/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "MyViewController.h"
#import "SVButton.h"
#import "LoginViewController.h"


#define HEADTITLECOLOR [UIColor colorWithRed:(200/255.0) green:(200/255.0) blue:(200/255.0) alpha:1]

@interface MyViewController ()

@end

@implementation MyViewController

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
    [self.dataItemArray addObject:[NSArray arrayWithObjects:@"关于e电工",@"联系新能量",@"推荐给好友",@"检查更新", nil]];
    self.tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.view addSubview:self.tableView];
    UIView *topFrame=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 55)];
    [topFrame setBackgroundColor:[UIColor orangeColor]];
    [self.tableView setTableHeaderView:topFrame];
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake1(10, 10, 40, 40)];
    [image setImage:[UIImage imageNamed:@"category1"]];
    [topFrame addSubview:image];
    UILabel *lblAccount=[[UILabel alloc]initWithFrame:CGRectMake1(60, 5, 100, 20)];
    [lblAccount setText:@"15900010001"];
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
    if(![[User Instance]isLogin]){
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
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CMainCell = @"CMainCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CMainCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier: CMainCell];
    }
    NSString *content=[[self.dataItemArray objectAtIndex:[indexPath section]]objectAtIndex:[indexPath row]];
    [cell.imageView setImage:[UIImage imageNamed:content]];
    cell.textLabel.text = content;
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSInteger section=[indexPath section];
//    NSInteger row=[indexPath row];
}


- (void)switchUser:(id)sender
{
    [self.navigationController pushViewController:[[LoginViewController alloc]init] animated:YES];
}

- (void)modifyPwd:(id)sender
{
    
}

- (void)logout:(id)sender
{
    [self.navigationController pushViewController:[[LoginViewController alloc]init] animated:YES];
}

@end
