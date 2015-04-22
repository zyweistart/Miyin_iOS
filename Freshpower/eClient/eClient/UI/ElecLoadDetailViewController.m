//
//  ElecLoadDetailViewController.m
//  eClient
//
//  Created by Start on 4/16/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "ElecLoadDetailViewController.h"
#import "ElecLoadDetailCell.h"
#import "ElecLoadDetailChartViewController.h"

#define HEADBGCOLOR [UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1]

@interface ElecLoadDetailViewController ()

@end

@implementation ElecLoadDetailViewController{
    NSMutableArray *headNumberArray;
}

- (id)init
{
    self=[super init];
    if(self){
        headNumberArray=[[NSMutableArray alloc]init];
        self.dataItemArray=[[NSMutableArray alloc]init];
        [self setTitle:@"详细负荷"];
        [self buildTableViewWithView:self.view];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadHttp];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [headNumberArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.dataItemArray objectAtIndex:section]count];
}

//设置区头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGHeight(30);
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *data=[headNumberArray objectAtIndex:section];
    UIView *head = [[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 30)];
    [head setBackgroundColor:HEADBGCOLOR];
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 0, 300, 30)];
    [lbl setText:[NSString stringWithFormat:@"%@",data]];
    [lbl setTextColor:[UIColor blackColor]];
    [lbl setFont:[UIFont systemFontOfSize:16]];
    [lbl setTextAlignment:NSTextAlignmentLeft];
    [head addSubview:lbl];
    return head;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CGHeight(70);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CMainCell = @"CMainCell";
    ElecLoadDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CMainCell];
    if (cell == nil) {
        cell = [[ElecLoadDetailCell alloc] initWithStyle:UITableViewCellStyleValue1  reuseIdentifier: CMainCell];
    }
    NSInteger section=[indexPath section];
    NSInteger row=[indexPath row];
    NSDictionary *data=[[self.dataItemArray objectAtIndex:section]objectAtIndex:row];
    [cell.lbl1 setText:[data objectForKey:@"EQ_NAME"]];
    [cell.lbl2 setText:[NSString stringWithFormat:@"当前负荷 %@",[data objectForKey:@"LOAD"]]];
    [cell.lbl3 setText:[NSString stringWithFormat:@"电流 %@",[data objectForKey:@"I"]]];
    [cell.lbl4 setText:[NSString stringWithFormat:@"总功率因数 %@",[data objectForKey:@"FACTOR"]]];
    [cell.lbl5 setText:[NSString stringWithFormat:@"电压 %@",[data objectForKey:@"U"]]];
    return cell;
}

- (void)tableView:tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section=[indexPath section];
    NSInteger row=[indexPath row];
    NSDictionary *data=[[self.dataItemArray objectAtIndex:section]objectAtIndex:row];
    [self.navigationController pushViewController:[[ElecLoadDetailChartViewController alloc]initWithData:data] animated:YES];
}

- (void)loadHttp
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[[User Instance]getUserName] forKey:@"imei"];
    [params setObject:[[User Instance]getPassword] forKey:@"authentication"];
    [params setObject:[[[User Instance]getResultData]objectForKey:@"CP_ID"] forKey:@"QTCP"];
    [params setObject:@"010402" forKey:@"GNID"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:501];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest handle:URL_appTaskingPower requestParams:params];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    [headNumberArray removeAllObjects];
    [self.dataItemArray removeAllObjects];
    NSArray *table1=[[response resultJSON]objectForKey:@"table1"];
    if(table1){
        [headNumberArray addObject:@"高压侧"];
        [self.dataItemArray addObject:table1];
    }
    NSArray *table2=[[response resultJSON]objectForKey:@"table2"];
    if(table2){
        [headNumberArray addObject:@"低压侧"];
        [self.dataItemArray addObject:table2];
    }
    [self.tableView reloadData];
}

@end