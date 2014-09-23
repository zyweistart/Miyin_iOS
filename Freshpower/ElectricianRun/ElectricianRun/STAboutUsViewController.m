//
//  STAboutUsViewController.m
//  ElectricianRun
//  关于
//  Created by Start on 2/22/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STAboutUsViewController.h"
#import "STFeedbackViewController.h"
#import "STNavigationWebPageViewController.h"

@interface STAboutUsViewController ()

@end

@implementation STAboutUsViewController


- (id)init {
    self=[super init];
    if(self) {
        self.title=@"关于";
        [self.view setBackgroundColor:[UIColor whiteColor]];
        self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style: UITableViewStyleGrouped];
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
        self.dataItemArray=[[NSMutableArray alloc]initWithObjects:@"用户反馈",@"新能量介绍",@"e电工协议内容",nil];
    }
    return self;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath{
    static NSString *CellIdentifier=@"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSInteger row=[indexPath row];
    cell.textLabel.text=[self.dataItemArray objectAtIndex:row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row=[indexPath row];
    if(row==0){
        STFeedbackViewController *feedbackViewController=[[STFeedbackViewController alloc]init];
        [self.navigationController pushViewController:feedbackViewController animated:YES];
    }else if(row==1){
        STNavigationWebPageViewController *navigationWebPageViewController=[[STNavigationWebPageViewController alloc]initWithNavigationTitle:@"新能量介绍" resourcePath:@"公司介绍"];
        [self.navigationController pushViewController:navigationWebPageViewController animated:YES];
        
    }else if(row==2){
        STNavigationWebPageViewController *navigationWebPageViewController=[[STNavigationWebPageViewController alloc]initWithNavigationTitle:@"e电工协议内容" resourcePath:@"变电站（配电房）运行合作协议"];
        [self.navigationController pushViewController:navigationWebPageViewController animated:YES];
    }
}

@end