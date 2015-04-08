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
#import "LoginViewController.h"
#define DISPLAYLINESTR1 @"ia=%.2f;ib=%.2f;ic=%.2f;"

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
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]
                                               initWithTitle:@"搜索"
                                               style:UIBarButtonItemStyleBordered
                                               target:self
                                               action:@selector(search:)];
        
        searchData=[[NSMutableDictionary alloc]init];
        [searchData setObject:@"" forKey:@"MeterName"];
        
        [self buildTableViewWithView:self.view];
    }
    return self;
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if([[User Instance]isLogin]){
        if([[self dataItemArray]count]==0){
            if(!self.tableView.pullTableIsRefreshing) {
                self.tableView.pullTableIsRefreshing=YES;
                [self performSelector:@selector(refreshTable) withObject:nil afterDelay:1.0f];
            }
        }
    }else{
        [self.navigationController pushViewController:[[LoginViewController alloc]init] animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([[self dataItemArray] count]>0){
        return CGHeight(65);
    }else{
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if([[self dataItemArray] count]>0){
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
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if([[self dataItemArray] count]>0){
        NSDictionary *dictionary=[self.dataItemArray objectAtIndex:[indexPath row]];
        STBurdenDetailChartViewController *burdenDetailChartViewController=[[STBurdenDetailChartViewController alloc]initWithData:dictionary];
        [self.navigationController pushViewController:burdenDetailChartViewController animated:YES];
    }
}

- (void)loadHttp
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[[User Instance] getCPNameId] forKey:@"CP_ID"];
    NSString *MeterName=[searchData objectForKey:@"MeterName"];
    if(![@"" isEqualToString:MeterName]){
        [params setObject:MeterName forKey:@"MeterName"];
    }
    [params setObject:[NSString stringWithFormat:@"%d",[self currentPage]] forKey:@"PageIndex"];
    [params setObject:PAGESIZE forKey:@"PageSize"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest handle:URL_AppMeterFhReport requestParams:params];
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
        if(!self.tableView.pullTableIsRefreshing) {
            self.tableView.pullTableIsRefreshing=YES;
            [self performSelector:@selector(refreshTable) withObject:nil afterDelay:1.0f];
        }
    }
}

@end
