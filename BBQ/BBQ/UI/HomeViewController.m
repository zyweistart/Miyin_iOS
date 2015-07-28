//
//  HomeViewController.m
//  BBQ
//
//  Created by Start on 15/7/27.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "HomeViewController.h"
#import "InfoCell.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)init{
    self=[super init];
    if(self){
        [self cTitle:@"Home"];
        [self buildTableViewWithView:self.view];
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.tableView setBackgroundColor:DEFAULTITLECOLORRGB(242, 125, 0)];
    }
    return self;
}

- (void)loadData:(NSArray*)array
{
    self.dataItemArray=[[NSMutableArray alloc]initWithArray:array];
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGHeight(210);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"InfoCellIdentifier";
    InfoCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell==nil){
        cell = [[InfoCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier] ;
    }
    NSDictionary *data = [self.dataItemArray objectAtIndex:[indexPath row]];
    for(id key in [data allKeys]){
        [cell.textLabel setText:[NSString stringWithFormat:@"%@",key]];
        [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@",[data objectForKey:key]]];
    }
    return  cell;
}

@end