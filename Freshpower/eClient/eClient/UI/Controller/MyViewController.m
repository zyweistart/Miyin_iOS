//
//  MyViewController.m
//  eClient
//  我的
//  Created by Start on 3/20/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "MyViewController.h"
#import "SVButton.h"

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
    UIView *topFrame=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 80)];
    [self.tableView setTableHeaderView:topFrame];
    UILabel *lblAccount=[[UILabel alloc]initWithFrame:CGRectMake1(0, 10, 50, 30)];
    [lblAccount setText:@"15900010001"];
    [topFrame addSubview:lblAccount];
    UIButton *bModifyPwd=[[UIButton alloc]initWithFrame:CGRectMake1(0, 50, 100, 40)];
    [bModifyPwd setTitle:@"修改密码" forState:UIControlStateNormal];
    [topFrame addSubview:bModifyPwd];
    
    
    
    UIView *bottomFrame=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 40)];
    [self.tableView setTableFooterView:bottomFrame];
    SVButton *bLogout=[[SVButton alloc]initWithFrame:CGRectMake1(10, 0, 300, 40) Title:@"安全退出" Type:2];
    [bottomFrame addSubview:bLogout];
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
    return 10;
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

@end
