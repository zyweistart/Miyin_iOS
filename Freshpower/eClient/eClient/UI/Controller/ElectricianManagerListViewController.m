//
//  ElectricianManagerListViewController.m
//  eClient
//
//  Created by Start on 3/24/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "ElectricianManagerListViewController.h"
#import "ElectricianManagerViewController.h"
#import "CRTableViewCell.h"

@interface ElectricianManagerListViewController ()

@end

@implementation ElectricianManagerListViewController

- (id)initWithParams:(NSDictionary*)data{
    self=[super initWithParams:data];
    if(self){
        [self setTitle:@"企业电工列表"];
        UIButton *bPublish = [UIButton buttonWithType:UIButtonTypeCustom];
        bPublish.frame = CGRectMake(0, 0, 70, 30);
        bPublish.layer.cornerRadius = 5;
        bPublish.layer.masksToBounds = YES;
        [bPublish setTitle:@"完成" forState:UIControlStateNormal];
        [bPublish.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [bPublish setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bPublish addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:bPublish];
        self.selectedMarks = [NSMutableArray new];
        [self buildTableViewWithView:self.view];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.dataItemArray count]>0){
        static NSString *cellIdentifier = @"Cell";
        CRTableViewCell *cell = (CRTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[CRTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        NSDictionary *data= [self.dataItemArray objectAtIndex:[indexPath row]];
        cell.isSelected = [self.selectedMarks containsObject:data] ? YES : NO;
        cell.textLabel.text = [data objectForKey:@"NAME"];
        return cell;
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.dataItemArray count]>0){
        NSDictionary *data= [self.dataItemArray objectAtIndex:[indexPath row]];
        if ([self.selectedMarks containsObject:data]){
            [self.selectedMarks removeObject:data];
        }else{
            [self.selectedMarks addObject:data];
        }
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark - Methods

- (void)done:(id)sender
{
    if([self.selectedMarks count]==0){
        [Common alert:@"请选中关联电工"];
        return;
    }
    NSMutableString *ms=[[NSMutableString alloc]init];
    for(id data in self.selectedMarks){
        [ms appendFormat:@"%@,",[data objectForKey:@"USER_ID"]];
    }
    NSRange deleteRange = {[ms length]-1,1};
    [ms deleteCharactersInRange:deleteRange];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[[User Instance]getUserName] forKey:@"imei"];
    [params setObject:[[User Instance]getPassword] forKey:@"authentication"];
    [params setObject:@"AC14" forKey:@"GNID"];
    [params setObject:[self.paramData objectForKey:@"CP_ID"] forKey:@"QTCP"];//
    [params setObject:[NSString stringWithFormat:@"%@",ms] forKey:@"QTUSER"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:501];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest handle:URL_appTaskingFps requestParams:params];
}

- (void)loadHttp
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[[User Instance]getUserName] forKey:@"imei"];
    [params setObject:[[User Instance]getPassword] forKey:@"authentication"];
    [params setObject:[self.paramData objectForKey:@"CP_ID"] forKey:@"QTCP"];//
    [params setObject:[self.paramData objectForKey:@"PARAMSNAME"] forKey:@"QTKEY"];//姓名
    [params setObject:[self.paramData objectForKey:@"PARAMSPHONE"] forKey:@"QTVAL"];//手机号
    [params setObject:@"AC13" forKey:@"GNID"];
    [params setObject:PAGESIZE forKey:@"QTPSIZE"];
    [params setObject:[NSString stringWithFormat:@"%d",[self currentPage]]  forKey:@"QTPINDEX"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest handle:URL_appTaskingFps requestParams:params];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if(reqCode==501){
        NSDictionary *rData=[[response resultJSON] objectForKey:@"Results"];
        [Common alert:[rData objectForKey:@"remark"]];
    }else{
        [super requestFinishedByResponse:response requestCode:reqCode];
    }
}

@end
