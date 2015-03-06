//
//  ListViewController.m
//  DLS
//
//  Created by Start on 3/5/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "ListViewController.h"
#import "ProjectCell.h"

@interface ListViewController ()

@end

@implementation ListViewController

- (id)initWithTitle:(NSString*)title Type:(NSInteger)type
{
    self=[super init];
    if(self){
        [self setTitle:title];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CProjectCell = @"CProjectCell";
    ProjectCell *cell = [tableView dequeueReusableCellWithIdentifier:CProjectCell];
    if (cell == nil) {
        cell = [[ProjectCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier: CProjectCell];
    }
    [cell.image setImage:[UIImage imageNamed:@"category1"]];
    cell.title.text=@"履带吊求租一天吊车结婚";
    cell.address.text=@"萧山建设1路";
    cell.money.text=@"40000元";
    [cell setStatus:@"洽谈中" Type:1];
    return cell;
}

@end
