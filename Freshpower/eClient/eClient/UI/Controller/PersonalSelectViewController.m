//
//  PersonalSelectViewController.m
//  eClient
//
//  Created by Start on 3/30/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "PersonalSelectViewController.h"

@interface PersonalSelectViewController ()

@end

@implementation PersonalSelectViewController

#pragma mark - Lifecycle
- (id)initWithData:(NSDictionary*)data
{
    self = [super init];
    if (self) {
        self.data=data;
        self.title = @"巡检人员设置";
        
        [self buildTableViewWithView:self.view];
        
        UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 50)];
        [self.tableView setTableHeaderView:frame];
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 0, 300, 50)];
        [lbl setText:@"如果列表中无你想选择的巡检人员，请至[企业账号管理]中进行添加关联"];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextAlignment:NSTextAlignmentLeft];
        [lbl setNumberOfLines:0];
        [frame addSubview:lbl];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if([[self dataItemArray]count]==0){
        if(!self.tableView.pullTableIsRefreshing) {
            self.tableView.pullTableIsRefreshing=YES;
            [self performSelector:@selector(refreshTable) withObject:nil afterDelay:1.0f];
        }
    }
}

#pragma mark - UITableView Data Source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[self dataItemArray] count]>0){
        static NSString *CMainCell = @"cellIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CMainCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier: CMainCell];
        }
        NSDictionary *data = [self.dataItemArray objectAtIndex:[indexPath row]];
        cell.textLabel.text = [data objectForKey:@"NAME"];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        return cell;
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *data = [NSMutableDictionary dictionaryWithDictionary:[self.dataItemArray objectAtIndex:[indexPath row]]];
    [self.delegate onControllerResult:self.resultCode data:data];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - tableView

- (void)loadHttp
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[[User Instance]userName] forKey:@"imei"];
    [params setObject:[[User Instance]passWord] forKey:@"authentication"];
    [params setObject:@"TS005" forKey:@"GNID"];
    [params setObject:[[self data]objectForKey:@"CP_ID"] forKey:@"QTCP"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest handle:URL_appTaskingFps requestParams:params];
}

@end