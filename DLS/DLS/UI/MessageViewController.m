//
//  MessageViewController.m
//  DLS
//
//  Created by Start on 3/4/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageDetailViewController.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"消息中心"];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.dataItemArray count]>0){
        return CGHeight(45);
    }else{
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
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
        NSString *CreateDate=[Common convertTime:[data objectForKey:@"CreateDate"]];
        [cell.textLabel setText:title];
        [cell.detailTextLabel setText:CreateDate];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        return cell;
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.dataItemArray count]>0){
        NSDictionary *data=[self.dataItemArray objectAtIndex:[indexPath row]];
        [self.navigationController pushViewController:[[MessageDetailViewController alloc]initWithDictionary:data] animated:YES];
    }
}

- (void)loadHttp
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"1" forKey:@"index"];
    [params setObject:@"10" forKey:@"size"];
    [params setObject:[[User Instance]accessToken] forKey:@"access_token"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest handle:@"GetWebMessage" requestParams:params];
}

@end
