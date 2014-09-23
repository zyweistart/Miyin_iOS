//
//  STTaskAuditBuildViewController.m
//  ElectricianRun
//  任务稽核-巡检任务生成
//  Created by Start on 1/25/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STTaskAuditBuildViewController.h"
#import "STTaskAuditBuildDetailViewController.h"
#import "STAuditBuildCell.h"
#import "NSString+Utils.h"

@interface STTaskAuditBuildViewController ()

@end

@implementation STTaskAuditBuildViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"巡检任务生成";
        [self.view setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellReuseIdentifier=@"Cell";
    
    STAuditBuildCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
    if(!cell) {
        cell = [[STAuditBuildCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifier];
    }
    
    NSUInteger row=[indexPath row];
    NSDictionary *dictionary=[self.dataItemArray objectAtIndex:row];
    [cell.lbl1 setText:[Common NSNullConvertEmptyString:[dictionary objectForKey:@"CP_NAME"]]];
    [cell.lbl2 setText:[Common NSNullConvertEmptyString:[dictionary objectForKey:@"SITE_NAME"]]];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dictionary=[self.dataItemArray objectAtIndex:[indexPath row]];
    
    STTaskAuditBuildDetailViewController *taskAuditBuildDetailViewController=[[STTaskAuditBuildDetailViewController alloc]init];
    
    [taskAuditBuildDetailViewController setCpId:[dictionary objectForKey:@"CP_ID"]];
    [taskAuditBuildDetailViewController setContractId:[dictionary objectForKey:@"CONTRACT_ID"]];
    [taskAuditBuildDetailViewController setSiteId:[dictionary objectForKey:@"SITE_ID"]];
    
    [self.navigationController pushViewController:taskAuditBuildDetailViewController animated:YES];
    [taskAuditBuildDetailViewController reloadUser];
    [taskAuditBuildDetailViewController reloadModel];
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource {
    
    NSMutableDictionary *p=[[NSMutableDictionary alloc]init];
    [p setObject:[Account getUserName] forKey:@"imei"];
    [p setObject:[Account getPassword] forKey:@"authentication"];
    [p setObject:@"ZY22" forKey:@"GNID"];
    [p setObject:self.cpName forKey:@"QTKEY"];
    [p setObject:self.siteName forKey:@"QTKEY2"];
    [p setObject:[NSString stringWithFormat: @"%d",_currentPage] forKey:@"QTPINDEX"];
    [p setObject:[NSString stringWithFormat: @"%d",PAGESIZE] forKey:@"QTPSIZE"];
    
    self.hRequest=[[HttpRequest alloc]init:self delegate:self responseCode:500];
    [self.hRequest setIsShowMessage:NO];
    [self.hRequest start:URLAppMonitoringAlarm params:p];
    
}

@end
