//
//  STElectricityListViewController.m
//  ElectricianClient
//
//  Created by Start on 3/26/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STElectricityListViewController.h"
#import "STElectricityDetailViewController.h"
#import "STElectricityCell.h"

@interface STElectricityListViewController ()

@end

@implementation STElectricityListViewController {
    NSMutableDictionary *searchData;
    int selectTypeValue;
}

- (id)initWithSelectType:(int)selectType
{
    selectTypeValue=selectType;
    NSString *tag=[NSString stringWithFormat:@"%d",selectType];
    [self setCacheTagName:CACHE_DATABYUNIQUE(tag)];
    self = [super init];
    if (self) {
        self.title=@"详细电费";
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]
                                               initWithTitle:@"返回"
                                               style:UIBarButtonItemStyleBordered
                                               target:self
                                               action:@selector(back:)];
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]
                                                initWithTitle:@"搜索"
                                                style:UIBarButtonItemStyleBordered
                                                target:self
                                                action:@selector(search:)];
        
        searchData=[[NSMutableDictionary alloc]init];
        [searchData setObject:@"" forKey:@"MeterName"];
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
    if(selectTypeValue==0){
        [[cell lbln1] setText:@"昨日总电量:"];
        [[cell lbln2] setText:@"昨日电费:"];
    }else{
        [[cell lbln1] setText:@"当月总电量:"];
        [[cell lbln2] setText:@"当月电费:"];
    }
    [[cell lbl1]setText:[Common NSNullConvertEmptyString:[dictionary objectForKey:@"TotalPower"]]];
    [[cell lbl2]setText:[Common NSNullConvertEmptyString:[dictionary objectForKey:@"TotalFee"]]];
    [[cell lbl3]setText:[Common NSNullConvertEmptyString:[dictionary objectForKey:@"AvgPrice"]]];
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dictionary=[self.dataItemArray objectAtIndex:[indexPath section]];
    STElectricityDetailViewController *electricityDetailViewController=[[STElectricityDetailViewController alloc]initWithData:dictionary selectType:selectTypeValue];
    [self.navigationController pushViewController:electricityDetailViewController animated:YES];
    [electricityDetailViewController loadData];
}

- (void)reloadTableViewDataSource{
    NSMutableDictionary *p=[[NSMutableDictionary alloc]init];
    [p setObject:[[Account getResultData]objectForKey:@"CP_ID"] forKey:@"CP_ID"];
    [p setObject:[searchData objectForKey:@"MeterName"] forKey:@"MeterName"];
    [p setObject:selectTypeValue==0?@"Day":@"Month" forKey:@"SelectType"];
    [p setObject:[NSString stringWithFormat: @"%d",_currentPage] forKey:@"PageIndex"];
    [p setObject:[NSString stringWithFormat: @"%d",PAGESIZE] forKey:@"PageSize"];
    self.hRequest=[[HttpRequest alloc]init:self delegate:self responseCode:500];
    [self.hRequest setIsShowMessage:NO];
    [self.hRequest start:URLAppMeterElec params:p];
}

- (void)search:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"线路名称"
                          message:@""
                          delegate:self
                          cancelButtonTitle:@"取消"
                          otherButtonTitles:@"确定",nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1){
        NSString *content=[[alertView textFieldAtIndex:0]text];
        [searchData setObject:content forKey:@"MeterName"];
        [self autoRefresh];
    }
}

@end
