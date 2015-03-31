//
//  EquipmentMaintainViewController.m
//  eClient
//  企业设备维护
//  Created by Start on 3/21/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "EquipmentMaintainViewController.h"
#import "LoginViewController.h"
#import "EnterpriseCell.h"

@interface EquipmentMaintainViewController ()

@end

@implementation EquipmentMaintainViewController

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"企业设备维护"];
        [self buildTableViewWithView:self.view];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
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

#pragma mark - tableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.dataItemArray count]>0){
        return CGHeight(60);
    }else{
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.dataItemArray count]>0){
        EnterpriseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
        if(!cell) {
            cell = [[EnterpriseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifier];
        }
        NSDictionary *data=[self.dataItemArray objectAtIndex:[indexPath row]];
        [cell setData:data];
        return cell;
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)loadHttp
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[[User Instance]getUserName] forKey:@"imei"];
    [params setObject:[[User Instance]getPassword] forKey:@"authentication"];
    [params setObject:@"AC16" forKey:@"GNID"];
    [params setObject:PAGESIZE forKey:@"QTPSIZE"];
    [params setObject:[NSString stringWithFormat:@"%d",[self currentPage]]  forKey:@"QTPINDEX"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest handle:URL_appTaskingFps requestParams:params];
}

@end