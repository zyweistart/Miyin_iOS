//
//  STDataMonitoringViewController.m
//  ElectricianRun
//  数据监测
//  Created by Start on 1/25/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STDataMonitoringSearchListViewController.h"
#import "STDataMonitoringLineViewController.h"
#import "STDataMonitoringCell.h"

@interface STDataMonitoringSearchListViewController ()

@end

@implementation STDataMonitoringSearchListViewController {
    NSMutableDictionary *searchData;
}


-(id)initWithData:(NSDictionary*)data
{
    [self setIsLoadCache:NO];
    self = [super init];
    if (self) {
        self.title=@"数据监测";
        
        searchData=[[NSMutableDictionary alloc]initWithDictionary:data];
    }
    return self;
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
    [p setObject:[searchData objectForKey:@"name"] forKey:@"QTKEY"];
    [p setObject:[NSString stringWithFormat: @"%d",_currentPage] forKey:@"QTPINDEX"];
    [p setObject:[NSString stringWithFormat: @"%d",PAGESIZE] forKey:@"QTPSIZE"];
    
    self.hRequest=[[HttpRequest alloc]init:self delegate:self responseCode:500];
    [self.hRequest setIsShowMessage:NO];
    [self.hRequest start:URLAppMonitoringAlarm params:p];
    
}

@end
