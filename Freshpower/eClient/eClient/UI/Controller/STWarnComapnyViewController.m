//
//  STWarnComapnyViewController.m
//  ElectricianClient
//
//  Created by Start on 3/26/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STWarnComapnyViewController.h"
#import "LoginViewController.h"
#import "STAlarmCell.h"

@interface STWarnComapnyViewController ()

@end

@implementation STWarnComapnyViewController{
    int _type;
}

- (id)initWithType:(int)type
{
    self = [super init];
    if (self) {
        _type=type;
        if(type==1){
            self.title=@"实时报警";
        }else if(type==2){
            self.title=@"历史报警";
        }
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
        return CGHeight(130);
    }else{
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([[self dataItemArray] count]>0){
        static NSString *cellReuseIdentifier=@"Cell";
        STAlarmCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
        if(!cell) {
            cell = [[STAlarmCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifier];
        }
        
        NSDictionary *data=[self.dataItemArray objectAtIndex:[indexPath row]];
        
        [[cell lbl1] setText:[Common NSNullConvertEmptyString:[data objectForKey:@"METER_NAME"]]];
        [[cell lbl2] setText:[Common NSNullConvertEmptyString:[data objectForKey:@"ALERT_DATE"]]];
        [[cell lbl3] setText:[Common NSNullConvertEmptyString:[data objectForKey:@"ALERT_LEVEL"]]];
        [[cell lbl4] setText:[Common NSNullConvertEmptyString:[data objectForKey:@"ALERT_REPLY"]]];
        [[cell lbl5] setText:[Common NSNullConvertEmptyString:[data objectForKey:@"CONTENT"]]];
        return cell;
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

- (void)loadHttp
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[[User Instance] getCPNameId] forKey:@"CP_ID"];
    [params setObject:[NSString stringWithFormat:@"%d",_type] forKey:@"Type"];
    [params setObject:[NSString stringWithFormat:@"%d",[self currentPage]] forKey:@"PageIndex"];
    [params setObject:PAGESIZE forKey:@"PageSize"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest handle:URL_AppAlertInfo requestParams:params];
    
}

@end
