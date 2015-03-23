//
//  ElectricianManagerViewController.m
//  eClient
//  企业电工管理
//  Created by Start on 3/21/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "ElectricianManagerViewController.h"
#import "EDGManagerCell.h"

@interface ElectricianManagerViewController ()

@end

@implementation ElectricianManagerViewController

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"企业电工管理"];
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
        EDGManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell) {
            cell = [[EDGManagerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
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
        
    }
}

- (void)loadHttp
{
    //    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    //    [params setObject:[[User Instance]userName] forKey:@"imei"];
    //    [params setObject:[[User Instance]passWord] forKey:@"authentication"];
    //    [params setObject:@"99010204" forKey:@"GNID"];
    //    [params setObject:PAGESIZE forKey:@"QTPSIZE"];
    //    [params setObject:[NSString stringWithFormat:@"%d",[self currentPage]]  forKey:@"QTPINDEX"];
    //    self.hRequest=[[HttpRequest alloc]init];
    //    [self.hRequest setRequestCode:500];
    //    [self.hRequest setDelegate:self];
    //    [self.hRequest setController:self];
    //    [self.hRequest handle:SERVER_URL(etgWebSite,@"INSPT/appTaskingFps.aspx") requestParams:params];
    for(int i=0;i<10;i++){
        [self.dataItemArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"1111",@"NAME", nil]];
    }
    [self loadDone];
}

@end
