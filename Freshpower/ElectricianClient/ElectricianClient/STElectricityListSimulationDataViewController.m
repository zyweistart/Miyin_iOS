//
//  STElectricityListSimulationDataViewController.m
//  ElectricianClient
//
//  Created by Start on 3/27/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STElectricityListSimulationDataViewController.h"
#import "STElectricityCell.h"
#import "STSimulationData.h"

@interface STElectricityListSimulationDataViewController ()

@end

@implementation STElectricityListSimulationDataViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.title=@"详细电费";
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]
                                               initWithTitle:@"返回"
                                               style:UIBarButtonItemStyleBordered
                                               target:self
                                               action:@selector(back:)];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.dataItemArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDictionary *dictionary=[self.dataItemArray objectAtIndex:section];
    return [Common NSNullConvertEmptyString:[dictionary objectForKey:@"METER_NAME"]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    STElectricityCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
    if(!cell) {
        cell = [[STElectricityCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifier];
    }
    
    NSDictionary *dictionary=[self.dataItemArray objectAtIndex:[indexPath section]];
    if(self.selectTypeValue==0){
        [[cell lbln1] setText:@"昨日总电量:"];
        [[cell lbln2] setText:@"昨日电费:"];
    }else{
        [[cell lbln1] setText:@"当月总电量:"];
        [[cell lbln2] setText:@"当月电费:"];
    }
    
    [[cell lbl1]setText:[Common NSNullConvertEmptyString:[dictionary objectForKey:@"TotalPower"]]];
    [[cell lbl2]setText:[Common NSNullConvertEmptyString:[dictionary objectForKey:@"TotalFee"]]];
    [[cell lbl3]setText:[Common NSNullConvertEmptyString:[dictionary objectForKey:@"AvgPrice"]]];
    [[cell lbl3]setTextColor:[UIColor redColor]];
    
    return cell;
}

@end