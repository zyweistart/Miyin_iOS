//
//  ListViewController.m
//  DLS
//
//  Created by Start on 3/5/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "ListViewController.h"
#import "ProjectCell.h"
#import "ProjectDCell.h"
#import "InformationCell.h"

@interface ListViewController ()

@end

@implementation ListViewController

- (id)initWithTitle:(NSString*)title Type:(NSInteger)type
{
    self=[super init];
    if(self){
        self.type=type;
        [self setTitle:title];
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
    if([self.dataItemArray count]>0){
        if(self.type==7){
            return 80;
        }else if(self.type==8){
            return 70;
        }else{
            return 70;
        }
    }else{
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.dataItemArray count]>0){
        if(self.type==7){
            //招标公告
            static NSString *cellIdentifier = @"CInformationCell";
            InformationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if(!cell) {
                cell = [[InformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            [cell setData:[self.dataItemArray objectAtIndex:[indexPath row]]];
            return cell;
        }else if(self.type==8){
            //招聘信息
            static NSString *cellIdentifier = @"CProjectDCell";
            ProjectDCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if(!cell) {
                cell = [[ProjectDCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            [cell setData:[self.dataItemArray objectAtIndex:[indexPath row]]];
            return cell;
        }else{
            static NSString *cellIdentifier = @"CProjectCell";
            ProjectCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[ProjectCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier: cellIdentifier];
            }
            [cell setData:[self.dataItemArray objectAtIndex:[indexPath row]]];
            return cell;
        }
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
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
