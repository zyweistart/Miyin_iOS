//
//  STBurdenDetailListViewController.m
//  ElectricianClient
//
//  Created by Start on 3/26/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STBurdenDetailListViewController.h"
#import "STBurdenDetailChartViewController.h"
#import "STBurdenCell.h"

@interface STBurdenDetailListViewController ()

@end

@implementation STBurdenDetailListViewController {
    NSMutableDictionary *searchData;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.title=@"详细负荷";
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    STBurdenCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
    if(!cell) {
        cell = [[STBurdenCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifier];
    }
    
    NSDictionary *dictionary=[self.dataItemArray objectAtIndex:[indexPath row]];
    
    [[cell lbl1]setText:[Common NSNullConvertEmptyString:[dictionary objectForKey:@"METER_NAME"]]];
    
    float P_POWER=[[Common NSNullConvertEmptyString:[dictionary objectForKey:@"P_POWER"]]floatValue];
    [[cell lbl2]setText:[NSString stringWithFormat:@"%.2f",P_POWER]];
    NSString *status=[Common NSNullConvertEmptyString:[dictionary objectForKey:@"SWITCH_STATUSTxt"]];
    if([@"合" isEqualToString:status]){
        [[cell lbl3] setTextColor:[UIColor redColor]];
    }else{
        [[cell lbl3] setTextColor:[UIColor greenColor]];
    }
    [[cell lbl3]setText:status];
    
    float FACTOR=[[Common NSNullConvertEmptyString:[dictionary objectForKey:@"FACTOR"]]floatValue];
    [[cell lbl4]setText:[NSString stringWithFormat:@"%.2f",FACTOR]];
    float I_A=[[Common NSNullConvertEmptyString:[dictionary objectForKey:@"I_A"]]floatValue];
    float I_B=[[Common NSNullConvertEmptyString:[dictionary objectForKey:@"I_B"]]floatValue];
    float I_C=[[Common NSNullConvertEmptyString:[dictionary objectForKey:@"I_C"]]floatValue];
    [[cell lbl5]setText:[NSString stringWithFormat:DISPLAYLINESTR1,I_A,I_B,I_C]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dictionary=[self.dataItemArray objectAtIndex:[indexPath row]];
    STBurdenDetailChartViewController *burdenDetailChartViewController=[[STBurdenDetailChartViewController alloc]initWithData:dictionary];
    [self.navigationController pushViewController:burdenDetailChartViewController animated:YES];
}

- (void)reloadTableViewDataSource{
    
    NSMutableDictionary *p=[[NSMutableDictionary alloc]init];
    [p setObject:[[Account getResultData]objectForKey:@"CP_ID"] forKey:@"CP_ID"];
    NSString *MeterName=[searchData objectForKey:@"MeterName"];
    if(![@"" isEqualToString:MeterName]){
        [p setObject:MeterName forKey:@"MeterName"];
    }
    [p setObject:[NSString stringWithFormat: @"%d",_currentPage] forKey:@"PageIndex"];
    [p setObject:[NSString stringWithFormat: @"%d",PAGESIZE] forKey:@"PageSize"];
    self.hRequest=[[HttpRequest alloc]init:self delegate:self responseCode:500];
    [self.hRequest setIsShowMessage:NO];
    [self.hRequest start:URLAppMeterFhReport params:p];
    
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
