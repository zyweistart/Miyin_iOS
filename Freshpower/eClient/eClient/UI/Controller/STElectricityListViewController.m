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
#import "LoginViewController.h"

@interface STElectricityListViewController ()

@end

@implementation STElectricityListViewController {
    NSMutableDictionary *searchData;
    int selectTypeValue;
}

- (id)initWithSelectType:(int)selectType
{
    selectTypeValue=selectType;
    self = [super init];
    if (self) {
        self.title=@"详细电费";
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.dataItemArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([[self dataItemArray] count]>0){
        return CGHeight(60);
    }else{
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDictionary *dictionary=[self.dataItemArray objectAtIndex:section];
    return [Common NSNullConvertEmptyString:[dictionary objectForKey:@"METER_NAME"]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([[self dataItemArray] count]>0){
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
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if([[self dataItemArray] count]>0){
        NSDictionary *dictionary=[self.dataItemArray objectAtIndex:[indexPath section]];
        STElectricityDetailViewController *electricityDetailViewController=[[STElectricityDetailViewController alloc]initWithData:dictionary selectType:selectTypeValue];
        [self.navigationController pushViewController:electricityDetailViewController animated:YES];
        [electricityDetailViewController loadData];
    }
}



- (void)loadHttp
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[[User Instance] getCPNameId] forKey:@"CP_ID"];
    [params setObject:[searchData objectForKey:@"MeterName"] forKey:@"MeterName"];
    [params setObject:selectTypeValue==0?@"Day":@"Month" forKey:@"SelectType"];
    [params setObject:[NSString stringWithFormat: @"%d",[self currentPage]] forKey:@"PageIndex"];
    [params setObject:[NSString stringWithFormat: @"%@",PAGESIZE] forKey:@"PageSize"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest handle:URL_AppMeterElec requestParams:params];
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
- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if(self.dataItemArray==nil){
        self.dataItemArray=[[NSMutableArray alloc]init];
    }
    NSDictionary *data=[response resultJSON];
    if(data!=nil){
        NSDictionary *rows=[data objectForKey:@"Rows"];
        int result=[[rows objectForKey:@"result"] intValue];
        if(result==1){
            int totalCount=[[rows objectForKey:@"TotalCount"]intValue];
            if(totalCount==0){
                [[self dataItemArray]removeAllObjects];
                [self.tableView reloadData];
            }else{
                for(NSString *key in data){
                    if(![@"Rows" isEqualToString:key]){
                        NSArray *tmpData=[data objectForKey:key];
                        if([self currentPage]==1){
                            self.dataItemArray=[[NSMutableArray alloc]initWithArray:tmpData];
                        } else {
                            [self.dataItemArray addObjectsFromArray:tmpData];
                        }
                        if([tmpData count]>0){
                            // 刷新表格
                            [self.tableView reloadData];
                        }
                        break;
                    }
                }
            }
        } else {
            //            [Common alert:[rows objectForKey:@"remark"]];
            if([self currentPage]==1){
                [[self dataItemArray]removeAllObjects];
                [self.tableView reloadData];
            }
        }
    }else{
        [Common alert:@"数据解析异常"];
    }
    [self loadDone];
}

@end
