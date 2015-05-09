//
//  CollectionViewController.m
//  DLS
//
//  Created by Start on 3/10/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionCell.h"
#import "MessageDetailViewController.h"


@interface CollectionViewController ()

@end

@implementation CollectionViewController

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"收藏"];
        //返回
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]
                                               initWithTitle:@"返回"
                                               style:UIBarButtonItemStyleBordered
                                               target:self
                                               action:@selector(goBack:)];
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
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        }
        NSDictionary *data=[self.dataItemArray objectAtIndex:[indexPath row]];
        NSString *title=[Common getString:[data objectForKey:@"title"]];
        NSString *Introduction=[Common getString:[data objectForKey:@"Introduction"]];
        [cell.textLabel setText:title];
        [cell.detailTextLabel setText:Introduction];
        return cell;
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.dataItemArray count]>0){
//        [self.navigationController pushViewController:[[MessageDetailViewController alloc]initWithDictionary:[self.dataItemArray objectAtIndex:[indexPath row]]] animated:YES];
    }
}

- (void)loadHttp
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"26" forKey:@"Id"];
    [params setObject:[[User Instance]accessToken] forKey:@"access_token"];
    [params setObject:[NSString stringWithFormat:@"%d",[self currentPage]] forKey:@"index"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest handle:@"GetListALL" requestParams:params];
}

@end