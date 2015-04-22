//
//  MaintainEnterpriseInformationViewController.m
//  eClient
//  维护企业信息
//  Created by Start on 3/23/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "MaintainEnterpriseInformationViewController.h"
#import "EnterpriseNameModifyViewController.h"

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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if([[User Instance]isLogin]){
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
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        NSDictionary *data= [self.dataItemArray objectAtIndex:[indexPath row]];
        [cell.textLabel setText:[data objectForKey:@"NAME"]];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        return cell;
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.dataItemArray count]>0){
        NSDictionary *data= [self.dataItemArray objectAtIndex:[indexPath row]];
        [self.navigationController pushViewController:[[EnterpriseNameModifyViewController alloc]initWithParams:data] animated:YES];
    }
}

- (void)loadHttp
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[[User Instance]getUserName] forKey:@"imei"];
    [params setObject:[[User Instance]getPassword] forKey:@"authentication"];
    [params setObject:@"99010204" forKey:@"GNID"];
    [params setObject:PAGESIZE forKey:@"QTPSIZE"];
    [params setObject:[NSString stringWithFormat:@"%ld",[self currentPage]]  forKey:@"QTPINDEX"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest handle:URL_appTaskingFps requestParams:params];
}

@end