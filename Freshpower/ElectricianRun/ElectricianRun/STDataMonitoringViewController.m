//
//  STDataMonitoringViewController.m
//  ElectricianRun
//  数据监测
//  Created by Start on 1/25/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STDataMonitoringViewController.h"
#import "STDataMonitoringLineViewController.h"
#import "STDataMonitoringSearchViewController.h"
#import "STDataMonitoringCell.h"

@interface STDataMonitoringViewController ()

@end

@implementation STDataMonitoringViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    [self setIsLoadCache:YES];
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"数据监测";
        
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]
                                               initWithTitle:@"返回"
                                               style:UIBarButtonItemStyleBordered
                                               target:self
                                               action:@selector(back:)];
        
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]
                                               initWithTitle:@"查询"
                                               style:UIBarButtonItemStyleBordered
                                               target:self
                                               action:@selector(search:)];
    }
    return self;
}

- (void)back:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//查询
- (void)search:(id)sender{
//    [self.header beginRefreshing];
    STDataMonitoringSearchViewController *dataMonitoringSearchViewController=[[STDataMonitoringSearchViewController alloc]init];
    [self.navigationController pushViewController:dataMonitoringSearchViewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellReuseIdentifier=@"Cell";
    
    STDataMonitoringCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
    if(!cell) {
        cell = [[STDataMonitoringCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifier];
    }
    
    NSUInteger row=[indexPath row];
    NSDictionary *dictionary=[self.dataItemArray objectAtIndex:row];
    
    [cell.lbl1 setText:[Common NSNullConvertEmptyString:[dictionary objectForKey:@"CP_NAME"]]];
    [cell.lbl2 setText:[Common NSNullConvertEmptyString:[dictionary objectForKey:@"TRANS_COUNT"]]];
    [cell.lbl3 setText:[Common NSNullConvertEmptyString:[dictionary objectForKey:@"MAX_DATE"]]];
    [cell.lbl4 setText:[Common NSNullConvertEmptyString:[dictionary objectForKey:@"MAX_LOAD"]]];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dictionary=[self.dataItemArray objectAtIndex:[indexPath row]];
    STDataMonitoringLineViewController *dataMonitoringLineViewController=[[STDataMonitoringLineViewController alloc]initWithData:dictionary];
    [self.navigationController pushViewController:dataMonitoringLineViewController animated:YES];
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{

    NSMutableDictionary *p=[[NSMutableDictionary alloc]init];
    [p setObject:[Account getUserName] forKey:@"imei"];
    [p setObject:[Account getPassword] forKey:@"authentication"];
    [p setObject:@"SJ10" forKey:@"GNID"];
    [p setObject:@"" forKey:@"QTKEY"];
    [p setObject:[NSString stringWithFormat: @"%d",_currentPage] forKey:@"QTPINDEX"];
    [p setObject:[NSString stringWithFormat: @"%d",PAGESIZE] forKey:@"QTPSIZE"];

    self.hRequest=[[HttpRequest alloc]init:self delegate:self responseCode:500];
    [self.hRequest setIsShowMessage:NO];
    [self.hRequest start:URLAppMonitoringAlarm params:p];
    
}

@end
