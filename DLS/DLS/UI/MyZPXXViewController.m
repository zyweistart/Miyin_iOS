//
//  MyZPXXViewController.m
//  DLS
//  招聘信息
//  Created by Start on 3/5/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "MyZPXXViewController.h"
#import "ProjectACell.h"

@interface MyZPXXViewController ()

@end

@implementation MyZPXXViewController

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"招聘信息"];
        [self buildTableViewWithView:self.view];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
    if(!self.tableView.pullTableIsRefreshing) {
        self.tableView.pullTableIsRefreshing=YES;
        [self performSelector:@selector(refreshTable) withObject:nil afterDelay:1.0f];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    ProjectACell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[ProjectACell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.title.text=@"诚聘客户经理";
    cell.address.text=@"萧山建设1路";
    cell.date.text=@"20-21";
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

- (void)loadHttp
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"9" forKey:@"Id"];
    [params setObject:[NSString stringWithFormat:@"%d",self.currentPage] forKey:@"index"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest handle:@"GetListALL" requestParams:params];
}

@end
