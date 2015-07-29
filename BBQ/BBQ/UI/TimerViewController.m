//
//  TimerViewController.m
//  BBQ
//
//  Created by Start on 15/7/27.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "TimerViewController.h"
#import "TimerCell.h"

@interface TimerViewController ()

@end

@implementation TimerViewController

- (id)init{
    self=[super init];
    if(self){
        [self cTitle:@"Timer"];
        [self buildTableViewWithView:self.view];
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.tableView setBackgroundColor:DEFAULTITLECOLORRGB(65, 51, 42)];
    }
    return self;
}

- (void)loadData:(NSArray*)array
{
    self.dataItemArray=[[NSMutableArray alloc]initWithArray:array];
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGHeight(190);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"TimerCellIdentifier";
    TimerCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell==nil){
        cell = [[TimerCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier] ;
    }
    NSDictionary *data = [self.dataItemArray objectAtIndex:[indexPath row]];
    [cell setData:data];
    for(id key in [data allKeys]){
        NSString *title=[NSString stringWithFormat:@"%@",key];
        NSString *centigrade=[NSString stringWithFormat:@"%@",[data objectForKey:key]];
        [cell.lblTitle setText:title];
    }
    return  cell;
}

@end
