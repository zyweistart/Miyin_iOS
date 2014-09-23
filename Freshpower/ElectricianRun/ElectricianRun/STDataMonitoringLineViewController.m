//
//  STDataMonitoringLineViewController.m
//  ElectricianRun
//  数据监测-线路
//  Created by Start on 1/25/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STDataMonitoringLineViewController.h"
#import "STDataMonitoringLineDetailViewController.h"
#import "STDataMonitoringLineSearchViewController.h"
#import "STDataMonitoringLineCell.h"

@interface STDataMonitoringLineViewController ()

@end

@implementation STDataMonitoringLineViewController

- (id)initWithData:(NSDictionary *) data
{
    [self setIsLoadCache:YES];
    [self setCachetag:CACHE_DATABYUNIQUE([data objectForKey:@"CP_ID"])];
    self = [super init];
    if (self) {
        
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        self.data=data;
        
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]
                                                initWithTitle:@"查询"
                                                style:UIBarButtonItemStyleBordered
                                                target:self
                                                action:@selector(search:)];
        
        
    }
    return self;
}

//查询
- (void)search:(id)sender{
    STDataMonitoringLineSearchViewController *dataMonitoringLineSearchViewController=[[STDataMonitoringLineSearchViewController alloc]init];
    [dataMonitoringLineSearchViewController setData:_data];
    [self.navigationController pushViewController:dataMonitoringLineSearchViewController animated:YES];
    [dataMonitoringLineSearchViewController reload];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellReuseIdentifier=@"Cell";
    
    STDataMonitoringLineCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
    if(!cell) {
        cell = [[STDataMonitoringLineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifier];
    }
    
    NSUInteger row=[indexPath row];
    NSDictionary *dictionary=[self.dataItemArray objectAtIndex:row];
    [cell.lbl1 setText:[Common NSNullConvertEmptyString:[dictionary objectForKey:@"METER_NAME"]]];
    NSString *SWITCH_STATUS=[Common NSNullConvertEmptyString:[dictionary objectForKey:@"SWITCH_STATUS"]];
    if([@"1" isEqualToString:SWITCH_STATUS]){
        [cell.lbl2 setTextColor:[UIColor redColor]];
        [cell.lbl2 setText:@"合"];
    }else{
        [cell.lbl2 setTextColor:[UIColor greenColor]];
        [cell.lbl2 setText:@"分"];
    }
    [cell.lbl3 setText:[Common NSNullConvertEmptyString:[dictionary objectForKey:@"REPORT_DATE"]]];
    [cell.lbl4 setText:[Common NSNullConvertEmptyString:[dictionary objectForKey:@"DAY_POWER"]]];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row=[indexPath row];
    NSDictionary *dictionary=[self.dataItemArray objectAtIndex:row];
    STDataMonitoringLineDetailViewController *dataMonitoringLineDetailViewController=[[STDataMonitoringLineDetailViewController alloc]initWithData:dictionary];
    [self.navigationController pushViewController:dataMonitoringLineDetailViewController animated:YES];
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
    
    NSMutableDictionary *p=[[NSMutableDictionary alloc]init];
    [p setObject:[Account getUserName] forKey:@"imei"];
    [p setObject:[Account getPassword] forKey:@"authentication"];
    [p setObject:@"SJ20" forKey:@"GNID"];
    [p setObject:[self.data objectForKey:@"CP_ID"] forKey:@"QTCP"];
    [p setObject:@"" forKey:@"QTKEY"];
    [p setObject:@"" forKey:@"QTKEY1"];
    [p setObject:[NSString stringWithFormat: @"%d",_currentPage] forKey:@"QTPINDEX"];
    [p setObject:[NSString stringWithFormat: @"%d",PAGESIZE] forKey:@"QTPSIZE"];
    
    self.hRequest=[[HttpRequest alloc]init:self delegate:self responseCode:500];
    [self.hRequest setIsShowMessage:NO];
    [self.hRequest start:URLAppMonitoringAlarm params:p];
    
}

@end
