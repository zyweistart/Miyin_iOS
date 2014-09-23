//
//  STDataMonitoringLineDetailListViewController.m
//  ElectricianRun
//  数据监测-线路-详细-耗量列表
//  Created by Start on 1/25/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STDataMonitoringLineDetailListViewController.h"
#import "STMonitoringLineDetailCell.h"
#import "NSString+Utils.h"

@interface STDataMonitoringLineDetailListViewController ()

@end

@implementation STDataMonitoringLineDetailListViewController {
    NSDictionary *data;
    BOOL lastMonthSearch;
    NSString *year;
    NSString *month;
}

- (id)initWithData:(NSDictionary *)d lastMonthSearch:(BOOL)flag
{
    [self setIsLoadCache:NO];
    self = [super init];
    if (self) {
        
        [self.view setBackgroundColor:[UIColor whiteColor]];
        data=d;
        lastMonthSearch=flag;
        if(lastMonthSearch){
            NSDate *date=[NSDate date];
            NSDateFormatter *dayformatter =[[NSDateFormatter alloc] init];
            [dayformatter setDateFormat:@"yyyy"];
            year = [dayformatter stringFromDate:date];
            NSDateFormatter *monthformatter =[[NSDateFormatter alloc] init];
            [monthformatter setDateFormat:@"MM"];
            month = [monthformatter stringFromDate:date];
            self.title=[NSString stringWithFormat:@"%@月份历史耗量",month];
        }
        
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(lastMonthSearch){
        return 45;
    }else{
        return 210;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellReuseIdentifier=@"Cell";
    NSUInteger row=[indexPath row];
    NSDictionary *dictionary=[self.dataItemArray objectAtIndex:row];
    
    if(lastMonthSearch){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellReuseIdentifier];
        }
        
        NSString *REPORT_MONTH=[dictionary objectForKey:@"REPORT_MONTH"];
        NSString *REPORT_DAY=[dictionary objectForKey:@"REPORT_DAY"];
        NSString *TOTAL_POWER=[dictionary objectForKey:@"TOTAL_POWER"];
        
        [cell.textLabel setText:[NSString stringWithFormat:@"%@月%@日:%@",REPORT_MONTH,REPORT_DAY,TOTAL_POWER]];
        
        return cell;
    }else{
        STMonitoringLineDetailCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
        if(!cell) {
            cell = [[STMonitoringLineDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifier];
        }
        
        
        [cell.lbl1 setText:[Common NSNullConvertEmptyString:[dictionary objectForKey:@"METER_NAME"]]];
        [cell.lbl2 setText:[Common NSNullConvertEmptyString:[dictionary objectForKey:@"CHANNEL"]]];
        [cell.lbl3 setText:[Common NSNullConvertEmptyString:[dictionary objectForKey:@"REPORT_DATE"]]];
        [cell.lbl4 setText:[Common NSNullConvertEmptyString:[dictionary objectForKey:@"HZ"]]];
        [cell.lbl5 setText:[Common NSNullConvertEmptyString:[dictionary objectForKey:@"V_A"]]];
        [cell.lbl6 setText:[Common NSNullConvertEmptyString:[dictionary objectForKey:@"I_A"]]];
        [cell.lbl7 setText:[Common NSNullConvertEmptyString:[dictionary objectForKey:@"V_B"]]];
        [cell.lbl8 setText:[Common NSNullConvertEmptyString:[dictionary objectForKey:@"I_B"]]];
        [cell.lbl9 setText:[Common NSNullConvertEmptyString:[dictionary objectForKey:@"V_C"]]];
        [cell.lbl10 setText:[Common NSNullConvertEmptyString:[dictionary objectForKey:@"I_C"]]];
        [cell.lbl11 setText:[Common NSNullConvertEmptyString:[dictionary objectForKey:@"P_POWER"]]];
        [cell.lbl12 setText:[Common NSNullConvertEmptyString:[dictionary objectForKey:@"FACTOR"]]];
        return cell;
    }
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
    
    NSMutableDictionary *p=[[NSMutableDictionary alloc]init];
    [p setObject:[Account getUserName] forKey:@"imei"];
    [p setObject:[Account getPassword] forKey:@"authentication"];
    [p setObject:[data objectForKey:@"CP_ID"] forKey:@"QTCP"];
    [p setObject:[data objectForKey:@"METER_ID"] forKey:@"QTLN"];
    if(lastMonthSearch){
        //当月的耗量
        [p setObject:@"SJ21" forKey:@"GNID"];
        [p setObject:[NSString stringWithFormat:@"%@-%@-01",year,month] forKey:@"QTD1"];
    }else{
        //按日期查询耗量
        [p setObject:@"SJ22" forKey:@"GNID"];
        [p setObject:self.startDay forKey:@"QTD1"];
        [p setObject:self.endDay forKey:@"QTD2"];
    }
    
    [p setObject:[NSString stringWithFormat: @"%d",_currentPage] forKey:@"QTPINDEX"];
    [p setObject:[NSString stringWithFormat: @"%d",PAGESIZE] forKey:@"QTPSIZE"];
    
    self.hRequest=[[HttpRequest alloc]init:self delegate:self responseCode:500];
    [self.hRequest setIsShowMessage:NO];
    [self.hRequest start:URLAppMonitoringAlarm params:p];
}

@end
