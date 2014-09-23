//
//  STInspectionViewController.m
//  ElectricianClient
//
//  Created by Start on 3/27/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STInspectionViewController.h"
#import "STInspectionTemperatureViewController.h"
#import "STInspectionElectricViewController.h"
#import "STElectricalDegreeViewController.h"
#import "STInspectionCell.h"
#import "STCommentViewController.h"

@interface STInspectionViewController ()

@end

@implementation STInspectionViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.title=@"巡检信息";
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]
                                                                  initWithTitle:@"返回"
                                                                  style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(back:)];
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]
                                                initWithTitle:@"评论"
                                                style:UIBarButtonItemStyleBordered
                                                target:self
                                                action:@selector(evaluate:)];
    }
    return self;
}

- (void)evaluate:(id)sender
{
    STCommentViewController *commentViewController=[[STCommentViewController alloc]init];
    [self.navigationController pushViewController:commentViewController animated:YES];
}

- (void)viewDidLoad
{
    self.dataItemArray=[[NSMutableArray alloc]initWithObjects:@"计量电度表数",@"设备温度、外观检查记录",@"总柜电流值及功率因数记录", nil];
    if(self.tableView==nil){
        self.tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
        [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.view addSubview:self.tableView];
        [self.tableView reloadData];
    }
    [super viewDidLoad];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0){
        return 1;
    }else{
        return [self.dataItemArray count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath section]==0){
        return 60;
    }else{
        return 45;
    }
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath{
    
    if([indexPath section]==0){
        static NSString *CellIdentifier=@"STInspectionCell";
        STInspectionCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[STInspectionCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *startDate=[NSDate date];
        NSTimeInterval secondsPerDay = 86400*1;
        NSDate *endDate = [startDate dateByAddingTimeInterval:-secondsPerDay];
        NSString *endDateStr = [dateFormatter stringFromDate:endDate];
        [[cell lbl2]setText:endDateStr];
        return cell;
    }else{
        static NSString *CellIdentifier=@"UITableViewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        [cell.textLabel setText:[self.dataItemArray objectAtIndex:[indexPath row]]];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if([indexPath section]==1){
        int row=[indexPath row];
        if(row==0){
            //计量电度表数
            [self.navigationController pushViewController:[[STElectricalDegreeViewController alloc]init] animated:YES];
        }else if(row==1){
            //设备温度、外观检查记录
            [self.navigationController pushViewController:[[STInspectionTemperatureViewController alloc]init] animated:YES];
        }else{
            //总柜电流值及功率因数记录
            [self.navigationController pushViewController:[[STInspectionElectricViewController alloc]init] animated:YES];
        }
    }
}
@end
