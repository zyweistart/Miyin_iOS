//
//  STViewUserListViewController.m
//  ElectricianRun
//
//  Created by Start on 3/4/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STViewUserListViewController.h"

@interface STViewUserListViewController ()

@end

@implementation STViewUserListViewController {
    int _type;
    NSString *startDateStr;
    NSString *endDateStr;
}

- (id)initWithTimeType:(int)type
{
    [self setIsLoadCache:YES];
    NSString *d=[NSString stringWithFormat:@"%d",_type];
    [self setCachetag:CACHE_DATABYUNIQUE(d)];
    self = [super init];
    if (self) {
        self.title=@"用户列表";
        [self.view setBackgroundColor:[UIColor whiteColor]];
        _type=type;
        
        NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *endDate=[NSDate date];
        endDateStr = [dateFormatter stringFromDate:endDate];
        if(_type==2){
            NSTimeInterval secondsPerDay = 86400*30;
            NSDate *startDate = [endDate dateByAddingTimeInterval:-secondsPerDay];
            startDateStr = [dateFormatter stringFromDate:startDate];
            startDateStr=[NSString stringWithFormat:@"%@ 00:00",startDateStr];
            endDateStr=[NSString stringWithFormat:@"%@ 23:59",endDateStr];
        }else{
            startDateStr=[NSString stringWithFormat:@"%@ 00:00",endDateStr];
            endDateStr=[NSString stringWithFormat:@"%@ 23:59",endDateStr];
        }
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellReuseIdentifier=@"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellReuseIdentifier];
    }
    NSUInteger row=[indexPath row];
    NSDictionary *dictionary=[self.dataItemArray objectAtIndex:row];
    [cell.textLabel setText:[dictionary objectForKey:@"userName"]];
    [cell.detailTextLabel setText:[dictionary objectForKey:@"phoneNum"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *dictionary=[[NSMutableDictionary alloc]initWithDictionary:[self.dataItemArray objectAtIndex:[indexPath row]]];
    [dictionary setObject:[NSString stringWithFormat:@"%d",_type] forKey:@"rtype"];
    [dictionary setObject:startDateStr forKey:@"startDate"];
    [dictionary setObject:endDateStr forKey:@"endDate"];
    [self.delegate startSearch:dictionary responseCode:200];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
    NSMutableDictionary *p=[[NSMutableDictionary alloc]init];
    [p setObject:[Account getUserName] forKey:@"imei"];
    [p setObject:[Account getPassword] forKey:@"authentication"];
    [p setObject:@"3" forKey:@"rtype"];
    [p setObject:startDateStr forKey:@"startDate"];
    [p setObject:endDateStr forKey:@"endDate"];
    
    self.hRequest=[[HttpRequest alloc]init:self delegate:self responseCode:500];
    [self.hRequest setIsShowMessage:NO];
    [self.hRequest start:URLgetLocationInfo params:p];
}

- (void)requestFinishedByResponse:(Response*)response responseCode:(int)repCode{
    NSArray *tmpData=[[response resultJSON] objectForKey:@"gpsUserList"];
    
    self.dataItemArray=[[NSMutableArray alloc]initWithArray:tmpData];
    
    // 刷新表格
    [self.tableView reloadData];
    
    [self doneLoadingTableViewData];
    
}

@end
