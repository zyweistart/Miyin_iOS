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
        return CGHeight(55);
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
        NSDictionary *data=[self.dataItemArray objectAtIndex:[indexPath row]];
        cell.title.text=[Common getString:[data objectForKey:@"Name"]];
        cell.address.text=[Common getString:[data objectForKey:@"address"]];
        cell.date.text=[Common convertTime:[data objectForKey:@"CreateDate"]];
        return cell;
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.dataItemArray count]>0){
        [self.navigationController pushViewController:[[RentalDetailViewController alloc]initWithDictionary:[self.dataItemArray objectAtIndex:[indexPath row]]] animated:YES];
    }
}

- (BOOL)tableView:(UITableView*)tableView canEditRowAtIndexPath:(NSIndexPath*)indexPath{
    return YES;
}

- (NSString*)tableView:(UITableView*) tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self.dataItemArray count]>[indexPath row]){
        if(editingStyle==UITableViewCellEditingStyleDelete){
            NSDictionary *data=[self.dataItemArray objectAtIndex:[indexPath row]];
            NSString *ID=[data objectForKey:@"Id"];
            NSString *ClassId=[data objectForKey:@"ClassId"];
            NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
            [params setObject:[[User Instance]accessToken] forKey:@"access_token"];
            [params setObject:ID forKey:@"Id"];
            [params setObject:ClassId forKey:@"classId"];
            self.hRequest=[[HttpRequest alloc]init];
            [self.hRequest setRequestCode:501];
            [self.hRequest setDelegate:self];
            [self.hRequest setController:self];
            [self.hRequest handle:@"DelDataFormClassId" requestParams:params];
        }
    }
}

- (void)loadHttp
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"17" forKey:@"Id"];
    [params setObject:[[User Instance]accessToken] forKey:@"access_token"];
    [params setObject:[NSString stringWithFormat:@"%ld",[self currentPage]] forKey:@"index"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest handle:@"GetListALL" requestParams:params];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if(reqCode==501){
        if([response successFlag]){
            [Common alert:[response msg]];
            if(!self.tableView.pullTableIsRefreshing) {
                self.tableView.pullTableIsRefreshing=YES;
                [self performSelector:@selector(refreshTable) withObject:nil afterDelay:1.0f];
            }
        }
    }else{
        [super requestFinishedByResponse:response requestCode:reqCode];
    }
}

- (void)goPublish:(id)sender
{
    [self.navigationController pushViewController:[[PublishRentalViewController alloc]init] animated:YES];
}

@end
