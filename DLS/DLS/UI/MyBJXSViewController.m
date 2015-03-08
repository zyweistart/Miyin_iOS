//
//  MyBJXSViewController.m
//  DLS
//  配件销售
//  Created by Start on 3/5/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "MyBJXSViewController.h"
#import "ProjectBCell.h"

@interface MyBJXSViewController ()

@end

@implementation MyBJXSViewController

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"配件销售"];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    ProjectBCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[ProjectBCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell.image setImage:[UIImage imageNamed:@"category1"]];
    cell.title.text=@"履带吊求租使用一天履带吊求租使用一天履带吊求租使用一天履带吊求租使用一天履带吊求租使用一天履带吊求租使用一天";
    cell.money.text=@"￥4000";
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
