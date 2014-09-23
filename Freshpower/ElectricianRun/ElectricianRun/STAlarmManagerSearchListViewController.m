//
//  STAlarmManagerViewController.m
//  ElectricianRun
//  报警管理
//  Created by Start on 2/20/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STAlarmManagerSearchListViewController.h"
#import "STAlarmCell.h"

#define REQUESTHANDLECODE 1000

@interface STAlarmManagerSearchListViewController ()

@end

@implementation STAlarmManagerSearchListViewController {
    NSMutableArray *deleteDic;
    NSArray *handleData;
    NSMutableDictionary *searchData;
    NSDictionary *selectDic;
}

-(id)initWithData:(NSDictionary*)data
{
    [self setIsLoadCache:NO];
    self = [super init];
    if (self) {
        self.title=@"报警管理";
        
        deleteDic=[[NSMutableArray alloc]init];
        
        handleData=[[NSArray alloc]initWithObjects:
                    @"选择",@"已处理",@"处理未妥",@"试验",
                    @"误报",@"不需要处理",@"正在处理",@"原因不明",
                    @"计划处理",@"人工分闸", nil];
        
        self.navigationItem.rightBarButtonItem=
                                                 [[UIBarButtonItem alloc]
                                                  initWithTitle:@"批量处理"
                                                  style:UIBarButtonItemStyleBordered
                                                  target:self
                                                  action:@selector(edit:)];
        
        searchData=[[NSMutableDictionary alloc]initWithDictionary:data];
        
        
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self autoRefresh];
}

- (void)edit:(id)sender {
    if([self.dataItemArray count]>0){
        UIBarButtonItem *bi=self.navigationItem.rightBarButtonItem;
        
        if ([bi.title isEqualToString: @"批量处理"]) {
            bi.title = @"确定";
            [self.tableView setEditing:YES animated:YES];
            [deleteDic removeAllObjects];
        } else {
            //		bi.title = @"批量处理";
            //		[self.tableView setEditing:NO animated:YES];
            RMPickerViewController *pickerVC = [RMPickerViewController pickerController];
            pickerVC.delegate = self;
            [pickerVC show];
        }
    }else{
        [Common alert:@"暂无数据"];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellReuseIdentifier=@"Cell";
    
    STAlarmCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
    if(!cell) {
        cell = [[STAlarmCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifier];
    }
    
    NSUInteger row=[indexPath row];
    NSDictionary *dictionary=[self.dataItemArray objectAtIndex:row];
    [cell.lbl1 setText:[Common NSNullConvertEmptyString:[dictionary objectForKey:@"ALERT_DATE"]]];
    [cell.lbl2 setText:[Common NSNullConvertEmptyString:[dictionary objectForKey:@"SITE_NAME"]]];
    [cell.lbl3 setText:[Common NSNullConvertEmptyString:[dictionary objectForKey:@"CATA_LOG"]]];
    [cell.lbl4 setText:[Common NSNullConvertEmptyString:[dictionary objectForKey:@"METER_NAME"]]];
    [cell.lbl5 setText:[Common NSNullConvertEmptyString:[dictionary objectForKey:@"CONTENT"]]];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIBarButtonItem *bi=self.navigationItem.rightBarButtonItem;
    selectDic=[self.dataItemArray objectAtIndex:[indexPath row]];
    if ([bi.title isEqualToString: @"批量处理"]) {
        RMPickerViewController *pickerVC = [RMPickerViewController pickerController];
        pickerVC.delegate = self;
        [pickerVC show];
    } else {
        [deleteDic addObject:selectDic];
    }
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.navigationItem.rightBarButtonItem.title isEqualToString: @"确定"]) {
        [deleteDic removeObject:[self.dataItemArray objectAtIndex:[indexPath row]]];
    }
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
    
    NSMutableDictionary *p=[[NSMutableDictionary alloc]init];
    [p setObject:[Account getUserName] forKey:@"imei"];
    [p setObject:[Account getPassword] forKey:@"authentication"];
    [p setObject:@"SJ30" forKey:@"GNID"];
    
    NSString *QTKEY=[searchData objectForKey:@"QTKEY"];
    if(![@"0" isEqualToString:QTKEY]){
        [p setObject:QTKEY forKey:@"QTKEY"];
    }
    NSString *QTKEY1=[searchData objectForKey:@"QTKEY1"];
    if(![@"" isEqualToString:QTKEY1]){
        [p setObject:QTKEY1 forKey:@"QTKEY1"];
    }
    NSString *QTKEY2=[searchData objectForKey:@"QTKEY2"];
    if(![@"0" isEqualToString:QTKEY2]){
        [p setObject:QTKEY2 forKey:@"QTKEY2"];
    }
    [p setObject:[NSString stringWithFormat: @"%d",_currentPage] forKey:@"QTPINDEX"];
    [p setObject:[NSString stringWithFormat: @"%d",PAGESIZE] forKey:@"QTPSIZE"];
    
    self.hRequest=[[HttpRequest alloc]init:self delegate:self responseCode:500];
    [self.hRequest setIsShowMessage:NO];
    [self.hRequest start:URLAppMonitoringAlarm params:p];
    
}

#pragma mark - RMPickerViewController Delegates
- (void)pickerViewController:(RMPickerViewController *)vc didSelectRows:(NSArray *)selectedRows {
    NSInteger row=[[selectedRows objectAtIndex:0] intValue];
    if(row==0){
        [Common alert:@"请选择处理选项！"];
    } else {
        
        NSMutableDictionary *p=[[NSMutableDictionary alloc]init];
        [p setObject:[Account getUserName] forKey:@"imei"];
        [p setObject:[Account getPassword] forKey:@"authentication"];
        
        UIBarButtonItem *bi=self.navigationItem.rightBarButtonItem;
        if ([bi.title isEqualToString: @"确定"]) {
            bi.title = @"批量处理";
            [self.tableView setEditing:NO animated:YES];
            //        NSLog(@"当前选择的为多行模式值为:%@",deleteDic);
            NSMutableString *handleStr=[[NSMutableString alloc]init];
            for(NSDictionary *d in deleteDic){
                [handleStr appendFormat:@"%@,",[d objectForKey:@"ALERT_ID"]];
            }
            NSString *hs=[handleStr substringWithRange:NSMakeRange(0, [handleStr length]-1)];
            [p setObject:@"SJ32" forKey:@"GNID"];
            [p setObject:hs forKey:@"QTKEY"];
        } else {
            //        NSLog(@"当前选择的为单行模式值为：%@",selectDic);
            NSString *hs=[selectDic objectForKey:@"ALERT_ID"];
            [p setObject:@"SJ31" forKey:@"GNID"];
            [p setObject:hs forKey:@"QTALARM"];
        }
        [p setObject:[NSString stringWithFormat:@"%d",row] forKey:@"QTVAL"];
        self.hRequest=[[HttpRequest alloc]init:self delegate:self responseCode:REQUESTHANDLECODE];
        [self.hRequest setIsShowMessage:YES];
        [self.hRequest start:URLAppMonitoringAlarm params:p];
    }
}

- (void)requestFinishedByResponse:(Response*)response responseCode:(int)repCode {
    if(repCode==REQUESTHANDLECODE){
        [self autoRefresh];
    }else{
        [super requestFinishedByResponse:response responseCode:repCode];
    }
}

- (void)pickerViewControllerDidCancel:(RMPickerViewController *)vc {
    UIBarButtonItem *bi=self.navigationItem.rightBarButtonItem;
    if ([bi.title isEqualToString: @"确定"]) {
		bi.title = @"批量处理";
		[self.tableView setEditing:NO animated:YES];
	}
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [handleData count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [handleData objectAtIndex:row];
}
@end
