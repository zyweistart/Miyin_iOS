//
//  STDataMonitoringLineViewController.m
//  ElectricianRun
//  数据监测-线路
//  Created by Start on 1/25/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STDataMonitoringLineSearchListViewController.h"
#import "STDataMonitoringLineDetailViewController.h"
#import "STDataMonitoringLineCell.h"

@interface STDataMonitoringLineSearchListViewController ()

@end

@implementation STDataMonitoringLineSearchListViewController {
    NSMutableDictionary *data;
    NSMutableDictionary *searchData;
}

-(id)initWithData:(NSDictionary*)d searchData:(NSDictionary*)sd
{
    [self setIsLoadCache:NO];
    self = [super init];
    if (self) {
        
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        data=[[NSMutableDictionary alloc]initWithDictionary:d];
        searchData=[[NSMutableDictionary alloc]initWithDictionary:sd];
        
    }
    return self;
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
    [p setObject:[data objectForKey:@"CP_ID"] forKey:@"QTCP"];
    [p setObject:[searchData objectForKey:@"QTKEY"] forKey:@"QTKEY"];
    [p setObject:[searchData objectForKey:@"QTKEY1"] forKey:@"QTKEY1"];
    [p setObject:[NSString stringWithFormat: @"%d",_currentPage] forKey:@"QTPINDEX"];
    [p setObject:[NSString stringWithFormat: @"%d",PAGESIZE] forKey:@"QTPSIZE"];
    
    self.hRequest=[[HttpRequest alloc]init:self delegate:self responseCode:500];
    [self.hRequest setIsShowMessage:NO];
    [self.hRequest start:URLAppMonitoringAlarm params:p];
    
}

@end
