//
//  MaintainEnterpriseInformationViewController.m
//  eClient
//  维护企业信息
//  Created by Start on 3/23/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "MaintainEnterpriseInformationViewController.h"

@interface MaintainEnterpriseInformationViewController ()

@end

@implementation MaintainEnterpriseInformationViewController

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"维护企业信息"];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.dataItemArray count]>0){
        return 55;
    }else{
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.dataItemArray count]>0){
        static NSString *cellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        [cell.textLabel setText:@"退出"];
        return cell;
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.dataItemArray count]>0){
        
    }
}

- (void)loadHttp
{
//    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
//    [params setObject:@"1" forKey:@"Id"];
//    [params setObject:[NSString stringWithFormat:@"%d",[self currentPage]] forKey:@"index"];
//    self.hRequest=[[HttpRequest alloc]init];
//    [self.hRequest setRequestCode:500];
//    [self.hRequest setDelegate:self];
//    [self.hRequest setController:self];
//    [self.hRequest handle:@"GetListALL" requestParams:params];
    
    [self loadDone];
}

@end