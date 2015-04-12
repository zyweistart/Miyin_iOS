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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *mainView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 25)];
    [mainView setBackgroundColor:[UIColor whiteColor]];
    UILabel *title=[[UILabel alloc]initWithFrame:CGRectMake1(10, 0, 250, 25)];
    [title setFont:[UIFont systemFontOfSize:18]];
    [title setTextColor:[UIColor blackColor]];
    [title setTextAlignment:NSTextAlignmentLeft];
    [mainView addSubview:title];
    UIButton *more=[[UIButton alloc]initWithFrame:CGRectMake1(265, 0, 40, 25)];
    [more setImage:[UIImage imageNamed:@"arrowdown"] forState:UIControlStateNormal];
    [more addTarget:self action:@selector(more:) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:more];
    [title setText:@"jdlkjdls螺杆晒黑晒黑kjsl晒黑晒黑j"];
    return mainView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if([self.dataItemArray count]>0){
        return [[self dataItemArray] count];
    }else{
        return 0;
    }
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([self.dataItemArray count]>0){
        return 1;
    }else{
        return [super tableView:tableView numberOfRowsInSection:section];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.dataItemArray count]>0){
        return 65;
    }else{
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.dataItemArray count]>0){
        static NSString *cellIdentifier = @"Cell";
        CollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell) {
            cell = [[CollectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        [cell setData:[self.dataItemArray objectAtIndex:[indexPath row]]];
        return cell;
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.dataItemArray count]>0){
        [self.navigationController pushViewController:[[MessageDetailViewController alloc]initWithDictionary:[self.dataItemArray objectAtIndex:[indexPath row]]] animated:YES];
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

- (void)more:(id)sender
{
    NSLog(@"更多");
}

@end