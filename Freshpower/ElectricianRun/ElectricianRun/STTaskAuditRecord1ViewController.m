//
//  STTaskAuditRecord1ViewController.m
//  ElectricianRun
//
//  Created by Start on 2/20/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STTaskAuditRecord1ViewController.h"
#import "STTaskAuditRecord2ViewController.h"

@interface STTaskAuditRecord1ViewController ()

@end

@implementation STTaskAuditRecord1ViewController

- (id)initWithData:(NSDictionary *) data
{
    self = [super init];
    if (self) {
        
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        self.data=data;
        
        self.dataItemArray=[[NSMutableArray alloc]initWithObjects:@"1",@"3",@"2",@"4", nil];
        
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
    NSString *data=[self.dataItemArray objectAtIndex:row];
    if([@"1" isEqualToString:data]){
        cell.textLabel.text=@"站点电耗量信息";
    } else if([@"3" isEqualToString:data]){
        cell.textLabel.text=@"运行设备外观、温度检查";
    } else if([@"2" isEqualToString:data]){
        cell.textLabel.text=@"受总柜运行情况";
    } else if([@"4" isEqualToString:data]){
        cell.textLabel.text=@"TRMS系统巡视检查";
    }
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSUInteger row=[indexPath row];
    NSString *v=[self.dataItemArray objectAtIndex:row];
    STTaskAuditRecord2ViewController *taskAuditRecord2ViewController=[[STTaskAuditRecord2ViewController alloc]initWithData:[self data] type:[v intValue]];
    [self.navigationController pushViewController:taskAuditRecord2ViewController animated:YES];
    
}

@end
