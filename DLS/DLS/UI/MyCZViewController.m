//
//  MyCZViewController.m
//  DLS
//  我的出租
//  Created by Start on 3/5/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "MyCZViewController.h"
#import "ProjectACell.h"

@interface MyCZViewController ()

@end

@implementation MyCZViewController

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"我的出租"];
        [self buildTableViewWithView:self.view];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(!self.tableView.pullTableIsRefreshing) {
        self.tableView.pullTableIsRefreshing=YES;
        [self performSelector:@selector(refreshTable) withObject:nil afterDelay:1.0f];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
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
    cell.title.text=@"履带吊求租使用一天";
    cell.address.text=@"萧山建设1路";
    cell.date.text=@"20-21";
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}
- (void)loadData
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"3" forKey:@"Id"];
    [params setObject:@"1" forKey:@"index"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest handle:@"GetListALL" requestParams:params];
}

- (void)refreshTable
{
    [self loadData];
}

- (void)loadMoreDataToTable
{
    [self loadData];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    [self loadDone];
}

@end
