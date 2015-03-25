//
//  InspectionManagerViewController.m
//  eClient
//  巡检任务管理
//  Created by Start on 3/21/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "InspectionManagerViewController.h"
#import "InspectionManagerCell.h"
#import "LoginViewController.h"

@interface InspectionManagerViewController ()

@end

@implementation InspectionManagerViewController{
    NSMutableArray *_array;
    NSMutableArray *_arrayData;
}

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"巡检任务管理"];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGHeight(30.0);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSDictionary *data=[[self dataItemArray]objectAtIndex:section];
    UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 30)];
    [frame setBackgroundColor:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1]];
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 5, 320, 20)];
    [lbl setText:[data objectForKey:@"CP_NAME"]];
    [lbl setFont:[UIFont systemFontOfSize:14]];
    [lbl setTextColor:[UIColor blackColor]];
    [lbl setTextAlignment:NSTextAlignmentLeft];
    [frame addSubview:lbl];
    return frame;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self dataItemArray] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CGHeight(217.0);
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    InspectionManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[InspectionManagerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell setController:self];
    NSDictionary *data= [self.dataItemArray objectAtIndex:[indexPath row]];
    NSLog(@"%@",data);
//            [cell.textLabel setText:[data objectForKey:@"NAME"]];
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.dataItemArray count]>0){
        
    }
}

- (void)loadHttp
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[[User Instance]userName] forKey:@"imei"];
    [params setObject:[[User Instance]passWord] forKey:@"authentication"];
    [params setObject:@"TS001" forKey:@"GNID"];
    [params setObject:PAGESIZE forKey:@"QTPSIZE"];
    [params setObject:[NSString stringWithFormat:@"%d",[self currentPage]]  forKey:@"QTPINDEX"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest handle:URL_appTaskingFps requestParams:params];
}

@end
