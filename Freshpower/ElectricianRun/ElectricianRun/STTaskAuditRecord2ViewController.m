//
//  STTaskAuditRecord2ViewController.m
//  ElectricianRun
//
//  Created by Start on 2/20/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STTaskAuditRecord2ViewController.h"
#import "STTaskAuditRecord3ViewController.h"

@interface STTaskAuditRecord2ViewController ()

@end

@implementation STTaskAuditRecord2ViewController {
    NSInteger _type;
    NSDictionary *_data;
}

- (id)initWithData:(NSDictionary *)data type:(NSInteger)t
{
    [self setIsLoadCache:YES];
    NSString *tag=[NSString stringWithFormat:@"%@,%d",[data objectForKey:@"TASK_ID"],t];
    [self setCachetag:CACHE_DATABYUNIQUE(tag)];
    self = [super init];
    if (self) {
        
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        _type=t;
        _data=data;
        
        if(_type==1){
            self.title=@"站点电耗量信息";
        } else if(_type==3){
            self.title=@"运行设备温度、外观检查";
        } else if(_type==2){
            self.title=@"受总柜运行情况";
        } else if(_type==4){
            self.title=@"TRMS系统巡视检查";
        }
        
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSUInteger row=[indexPath row];
    NSDictionary *dictionary=[self.dataItemArray objectAtIndex:row];
    cell.textLabel.text=[NSString stringWithFormat:@"%@",[dictionary objectForKey:@"NAME"]];
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row=[indexPath row];
    NSDictionary *dictionary=[self.dataItemArray objectAtIndex:row];
    STTaskAuditRecord3ViewController *taskAuditRecord3ViewController=[[STTaskAuditRecord3ViewController alloc]initWithData:_data dic:dictionary type:_type];
    [self.navigationController pushViewController:taskAuditRecord3ViewController animated:YES];
    [taskAuditRecord3ViewController reloadDataSource];
}

- (void)reloadTableViewDataSource{
    
    [self setIsPage:NO];
    
    NSMutableDictionary *p=[[NSMutableDictionary alloc]init];
    [p setObject:[Account getUserName] forKey:@"imei"];
    [p setObject:[Account getPassword] forKey:@"authentication"];
    [p setObject:@"RW12" forKey:@"GNID"];
    [p setObject:[_data objectForKey:@"TASK_ID"] forKey:@"QTTASK"];
    [p setObject:[NSString stringWithFormat:@"%d",_type] forKey:@"QTKEY"];
    
    self.hRequest=[[HttpRequest alloc]init:self delegate:self responseCode:500];
    [self.hRequest setIsShowMessage:NO];
    [self.hRequest start:URLAppMonitoringAlarm params:p];
    
}

@end

