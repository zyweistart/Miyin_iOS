//
//  STAlarmSetupViewController.m
//  ElectricianRun
//  报警阀值设置
//  Created by Start on 3/3/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STAlarmSetupViewController.h"
#import "STAlarmSetupCell.h"
#define ALARAMSETUPREQUESTCODE 501

@interface STAlarmSetupViewController ()

@end

@implementation STAlarmSetupViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    [self setIsLoadCache:YES];
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"报警阀值设置";
        [self.view setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 58;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellReuseIdentifier=@"Cell";
    
    STAlarmSetupCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
    if(!cell) {
        cell = [[STAlarmSetupCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifier];
    }
    
    NSUInteger row=[indexPath row];
    NSDictionary *dictionary=[self.dataItemArray objectAtIndex:row];
    [cell.lbl1 setText:[Common NSNullConvertEmptyString:[dictionary objectForKey:@"NAME"]]];
    [cell.lbl2 setText:[Common NSNullConvertEmptyString:[dictionary objectForKey:@"TOTAL_FACTOR"]]];
    [cell.lbl3 setText:[Common NSNullConvertEmptyString:[dictionary objectForKey:@"POWER_DEMAND"]]];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row=[indexPath row];
    NSDictionary *dictionary=[self.dataItemArray objectAtIndex:row];
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"数值设置"
                          message:nil
                          delegate:self
                          cancelButtonTitle:@"确定"
                          otherButtonTitles:@"取消",nil];
    [alert setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
    //设置输入框的键盘类型
    UITextField *tf0 = [alert textFieldAtIndex:0];
    [tf0 setPlaceholder:@"功率因数"];
    [tf0 setText:[Common NSNullConvertEmptyString:[dictionary objectForKey:@"TOTAL_FACTOR"]]];
    tf0.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    
    UITextField *tf1 = [alert textFieldAtIndex:1];
    [tf1 setPlaceholder:@"需量"];
    [tf1 setText:[Common NSNullConvertEmptyString:[dictionary objectForKey:@"POWER_DEMAND"]]];
    tf1.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [tf1 setSecureTextEntry:NO];
    alert.tag=row;
    [alert show];
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
    
    NSMutableDictionary *p=[[NSMutableDictionary alloc]init];
    [p setObject:[Account getUserName] forKey:@"imei"];
    [p setObject:[Account getPassword] forKey:@"authentication"];
    [p setObject:@"CP10" forKey:@"GNID"];
    [p setObject:[NSString stringWithFormat: @"%d",_currentPage] forKey:@"QTPINDEX"];
    [p setObject:[NSString stringWithFormat: @"%d",PAGESIZE] forKey:@"QTPSIZE"];
    
    self.hRequest=[[HttpRequest alloc]init:self delegate:self responseCode:500];
    [self.hRequest setIsShowMessage:NO];
    [self.hRequest start:URLAppMonitoringAlarm params:p];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0){
        
        NSDictionary *dictionary=[self.dataItemArray objectAtIndex:alertView.tag];
        if(dictionary!=nil) {
            NSString *content1=[[alertView textFieldAtIndex:0]text];
            NSString *content2=[[alertView textFieldAtIndex:1]text];
            
            NSMutableDictionary *p=[[NSMutableDictionary alloc]init];
            [p setObject:[Account getUserName] forKey:@"imei"];
            [p setObject:[Account getPassword] forKey:@"authentication"];
            [p setObject:@"CP11" forKey:@"GNID"];
            [p setObject:[dictionary objectForKey:@"CP_ID"] forKey:@"QTCP"];
            [p setObject:content1 forKey:@"QTVAL"];
            [p setObject:content2 forKey:@"QTVAL1"];
            
            self.hRequest=[[HttpRequest alloc]init:self delegate:self responseCode:ALARAMSETUPREQUESTCODE];
            [self.hRequest setIsShowMessage:YES];
            [self.hRequest start:URLAppMonitoringAlarm params:p];
        }
    }
}

- (void)requestFinishedByResponse:(Response*)response responseCode:(int)repCode
{
    if(repCode==ALARAMSETUPREQUESTCODE){
        NSDictionary *data=[[response resultJSON] objectForKey:@"Rows"];
        [Common alert:[data objectForKey:@"remark"]];
        if([@"1" isEqualToString:[data objectForKey:@"result"]]){
            [self autoRefresh];
        }
    }else{
        [super requestFinishedByResponse:response responseCode:repCode];
    }
}

@end