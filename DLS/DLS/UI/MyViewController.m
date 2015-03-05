//
//  MyViewController.m
//  DLS
//
//  Created by Start on 3/2/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "MyViewController.h"
#import "MyCZViewController.h"
#import "MyQZViewController.h"
#import "MySBXSViewController.h"
#import "MySBWXViewController.h"
#import "MyBJXSViewController.h"
#import "MyVIPGCViewController.h"
#import "MyZPXXViewController.h"
#import "MyQZYPViewController.h"
#import "MyHelpCenterViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"我的"];
        
        self.dataItemArray=[[NSMutableArray alloc]init];
        [self.dataItemArray addObject:[NSArray arrayWithObjects:@"我的出租",@"我的求租",@"设备销售",@"设备维修",@"配件销售",@"VIP工程", nil]];
        [self.dataItemArray addObject:[NSArray arrayWithObjects:@"招聘信息",@"我的求职", nil]];
        [self.dataItemArray addObject:[NSArray arrayWithObjects:@"帮助中心",@"得力手客服中心", nil]];
        
        self.tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
        [self.view addSubview:self.tableView];
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
    NSInteger section=[indexPath section];
    NSInteger row=[indexPath row];
    if(section==0){
        if(row==0){
            [self.navigationController pushViewController:[[MyCZViewController alloc]init] animated:YES];
        }else if(row==1){
            [self.navigationController pushViewController:[[MyQZViewController alloc]init] animated:YES];
        }else if(row==2){
            [self.navigationController pushViewController:[[MySBXSViewController alloc]init] animated:YES];
        }else if(row==3){
            [self.navigationController pushViewController:[[MySBWXViewController alloc]init] animated:YES];
        }else if(row==4){
            [self.navigationController pushViewController:[[MyBJXSViewController alloc]init] animated:YES];
        }else if(row==5){
            [self.navigationController pushViewController:[[MyVIPGCViewController alloc]init] animated:YES];
        }
    }else if(section==1){
        if(row==0){
            [self.navigationController pushViewController:[[MyZPXXViewController alloc]init] animated:YES];
        }else if(row==1){
            [self.navigationController pushViewController:[[MyQZYPViewController alloc]init] animated:YES];
        }
    }else{
        if(row==0){
            [self.navigationController pushViewController:[[MyHelpCenterViewController alloc]init] animated:YES];
        }else if(row==1){
            
        }
    }
}

@end
