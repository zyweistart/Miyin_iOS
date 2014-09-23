//
//  STTaskManagerHandleViewController.m
//  ElectricianRun
//
//  Created by Start on 2/25/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STTaskManagerHandleViewController.h"
#import "STTaskManagerConsumptionViewController.h"

@interface STTaskManagerHandleViewController ()

@end

@implementation STTaskManagerHandleViewController{
    NSString *_taskId;
    NSString *_gnid;
    NSInteger _type;
}

- (id)initWithTaskId:(NSString *)taskId gnid:(NSString *)g type:(NSInteger)t;
{
    
    [self setIsLoadCache:YES];
    NSString *tag=[NSString stringWithFormat:@"%@,%@,%d",taskId,g,t];
    [self setCachetag:CACHE_DATABYUNIQUE(tag)];
    self = [super init];
    if (self) {
        
        [self.view setBackgroundColor:[UIColor whiteColor]];
        _taskId=taskId;
        _gnid=g;
        _type=t;
        
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
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *data=[self.dataItemArray objectAtIndex:[indexPath row]];
    STTaskManagerConsumptionViewController *taskManagerConsumptionViewController=[[STTaskManagerConsumptionViewController alloc]initWithData:data taskId:_taskId gnid:_gnid type:_type];
    [self.navigationController pushViewController:taskManagerConsumptionViewController animated:YES];
    [taskManagerConsumptionViewController reloadTableViewDataSource];
    
}

- (void)reloadTableViewDataSource{
    
    [self setIsPage:NO];
    
    NSMutableDictionary *p=[[NSMutableDictionary alloc]init];
    [p setObject:[Account getUserName] forKey:@"imei"];
    [p setObject:[Account getPassword] forKey:@"authentication"];
    [p setObject:@"RW12" forKey:@"GNID"];
    [p setObject:_taskId forKey:@"QTTASK"];
    [p setObject:[NSString stringWithFormat:@"%d",_type] forKey:@"QTKEY"];
    
    self.hRequest=[[HttpRequest alloc]init:self delegate:self responseCode:500];
    [self.hRequest setIsShowMessage:NO];
    [self.hRequest start:URLAppMonitoringAlarm params:p];
    
}

@end

