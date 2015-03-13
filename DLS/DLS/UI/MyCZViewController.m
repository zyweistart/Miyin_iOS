//
//  MyCZViewController.m
//  DLS
//  我的出租
//  Created by Start on 3/5/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "MyCZViewController.h"
#import "ProjectACell.h"
#import "RentalDetailViewController.h"
#import "PublishRentalViewController.h"

@interface MyCZViewController ()

@end

@implementation MyCZViewController

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"我的出租"];
        //返回
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]
                                               initWithTitle:@"返回"
                                               style:UIBarButtonItemStyleBordered
                                               target:self
                                               action:@selector(goBack:)];
        //
        UIButton *bPublish = [UIButton buttonWithType:UIButtonTypeCustom];
        [bPublish setTitle:@"发布出租" forState:UIControlStateNormal];
        [bPublish.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [bPublish setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bPublish addTarget:self action:@selector(goPublish:) forControlEvents:UIControlEventTouchUpInside];
        bPublish.frame = CGRectMake(0, 0, 70, 30);
        bPublish.layer.cornerRadius = 5;
        bPublish.layer.masksToBounds = YES;
        [bPublish setBackgroundColor:[UIColor colorWithRed:(52/255.0) green:(177/255.0) blue:(59/255.0) alpha:1]];
        self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:bPublish];
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
        ProjectACell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell) {
            cell = [[ProjectACell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        [cell setData:[self.dataItemArray objectAtIndex:[indexPath row]]];
        return cell;
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController pushViewController:[[RentalDetailViewController alloc]initWithDictionary:nil] animated:YES];
}

- (void)loadHttp
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"1" forKey:@"Id"];
    [params setObject:[NSString stringWithFormat:@"%d",[self currentPage]] forKey:@"index"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest handle:@"GetListALL" requestParams:params];
}

- (void)goPublish:(id)sender
{
    [self.navigationController pushViewController:[[PublishRentalViewController alloc]init] animated:YES];
}

@end
