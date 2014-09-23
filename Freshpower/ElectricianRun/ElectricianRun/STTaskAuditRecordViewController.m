//
//  STTaskAuditRecordViewController.m
//  ElectricianRun
//  任务稽核-巡检记录
//  Created by Start on 1/25/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STTaskAuditRecordViewController.h"
#import "STTaskAuditRecord1ViewController.h"
#import "STAuditRecordCell.h"

@interface STTaskAuditRecordViewController ()

@end

@implementation STTaskAuditRecordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"巡检记录";
        [self.view setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellReuseIdentifier=@"Cell";
    
    STAuditRecordCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
    if(!cell) {
        cell = [[STAuditRecordCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifier];
    }
    
    NSUInteger row=[indexPath row];
    NSDictionary *dictionary=[self.dataItemArray objectAtIndex:row];
    [cell.lbl1 setText:[Common NSNullConvertEmptyString:[dictionary objectForKey:@"NAME"]]];
    [cell.lbl2 setText:[Common NSNullConvertEmptyString:[dictionary objectForKey:@"TASK_DATE"]]];
    [cell.lbl3 setText:[Common NSNullConvertEmptyString:[dictionary objectForKey:@"SITE_NAME"]]];
    [cell.lbl4 setText:[Common NSNullConvertEmptyString:[dictionary objectForKey:@"RECOMPLETE_DATE"]]];
    NSString *IS_COMPLETE=[Common NSNullConvertEmptyString:[dictionary objectForKey:@"IS_COMPLETE"]];
    if([@"1" isEqualToString:IS_COMPLETE]){
        [cell.lbl5 setTextColor:[UIColor greenColor]];
        [cell.lbl5 setText:@"是"];
    }else{
        [cell.lbl5 setTextColor:[UIColor redColor]];
        [cell.lbl5 setText:@"否"];
    }
    [cell.lbl6 setText:[Common NSNullConvertEmptyString:[dictionary objectForKey:@"COMPLETE_DATE"]]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dictionary=[self.dataItemArray objectAtIndex:[indexPath row]];
    STTaskAuditRecord1ViewController *taskAuditRecord1ViewController=[[STTaskAuditRecord1ViewController alloc]initWithData:dictionary];
    [self.navigationController pushViewController:taskAuditRecord1ViewController animated:YES];
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
    
    NSMutableDictionary *p=[[NSMutableDictionary alloc]init];
    [p setObject:[Account getUserName] forKey:@"imei"];
    [p setObject:[Account getPassword] forKey:@"authentication"];
    [p setObject:@"RW18" forKey:@"GNID"];
    [p setObject:self.cpName forKey:@"QTKEY"];
    [p setObject:self.siteName forKey:@"QTKEY2"];
    [p setObject:self.startDay forKey:@"QTD1"];
    [p setObject:self.endDay forKey:@"QTD2"];
    [p setObject:[NSString stringWithFormat: @"%d",_currentPage] forKey:@"QTPINDEX"];
    [p setObject:[NSString stringWithFormat: @"%d",PAGESIZE] forKey:@"QTPSIZE"];
    
    self.hRequest=[[HttpRequest alloc]init:self delegate:self responseCode:500];
    [self.hRequest setIsShowMessage:NO];
    [self.hRequest start:URLAppMonitoringAlarm params:p];
    
}

@end

