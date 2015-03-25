//
//  InspectionSettingViewController.m
//  eClient
//  巡检任务设置
//  Created by weizhenyao on 15/3/23.
//  Copyright (c) 2015年 freshpower. All rights reserved.
//

#import "InspectionSettingViewController.h"
#import "InspectionTipCell.h"
#import "InspectionDownSendCell.h"

@interface InspectionSettingViewController ()

@end

@implementation InspectionSettingViewController

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"巡检设置"];
        self.dataItemArray=[[NSMutableArray alloc]init];
        [self.dataItemArray addObject:@"提醒设置"];
        [self.dataItemArray addObject:@"下发设置"];
        [self.dataItemArray addObject:@"巡检人员设置"];
        [self buildTableViewWithView:self.view];
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGHeight(30.0);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *name=[[self dataItemArray]objectAtIndex:section];
    UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 30)];
    [frame setBackgroundColor:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1]];
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 5, 320, 20)];
    [lbl setText:name];
    [lbl setFont:[UIFont systemFontOfSize:14]];
    [lbl setTextColor:[UIColor blackColor]];
    [lbl setTextAlignment:NSTextAlignmentLeft];
    [frame addSubview:lbl];
    return frame;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self dataItemArray] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section=[indexPath section];
    if(section==0){
        return 65;
    }else if(section==1){
        return 115;
    }else{
        return 45;
    }
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0){
        return 4;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section=[indexPath section];
    if(section==0){
        static NSString *cellIdentifier = @"InspectionTipCell";
        InspectionTipCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell) {
            cell = [[InspectionTipCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        return cell;
    }else if(section==1){
        static NSString *cellIdentifier = @"InspectionDownSendCell";
        InspectionDownSendCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell) {
            cell = [[InspectionDownSendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        return cell;
    }else{
        static NSString *cellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        return cell;
    }
}

@end
