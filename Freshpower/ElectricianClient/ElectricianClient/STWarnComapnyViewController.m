//
//  STWarnComapnyViewController.m
//  ElectricianClient
//
//  Created by Start on 3/26/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STWarnComapnyViewController.h"
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
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]
                                               initWithTitle:@"返回"
                                               style:UIBarButtonItemStyleBordered
                                               target:self
                                               action:@selector(back:)];
        
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self autoRefresh];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
}

- (void)reloadTableViewDataSource{
    if([Account isLogin]){
        NSMutableDictionary *p=[[NSMutableDictionary alloc]init];
        [p setObject:[[Account getResultData]objectForKey:@"CP_ID"] forKey:@"CP_ID"];
        [p setObject:[NSString stringWithFormat:@"%d",_type] forKey:@"Type"];
        [p setObject:[NSString stringWithFormat: @"%d",_currentPage] forKey:@"PageIndex"];
        [p setObject:[NSString stringWithFormat: @"%d",PAGESIZE] forKey:@"PageSize"];
        
        self.hRequest=[[HttpRequest alloc]init:self delegate:self responseCode:500];
        [self.hRequest setIsShowMessage:NO];
        [self.hRequest start:URLAppAlertInfo params:p];
    }else{
        [self doneLoadingTableViewData];
    }
}

@end
