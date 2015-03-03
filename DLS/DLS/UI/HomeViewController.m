//
//  HomeViewController.m
//  DLS
//
//  Created by Start on 3/2/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "HomeViewController.h"

#define TOPNAVBGCOLOR [UIColor colorWithRed:(46/255.0) green:(92/255.0) blue:(178/255.0) alpha:1]

#define TOPNAVHEIGHT 100

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)init{
    self=[super init];
    if(self){
        //顶部头视图
        UIView *topView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, TOPNAVHEIGHT)];
        [topView setBackgroundColor:TOPNAVBGCOLOR];
        [self.view addSubview:topView];
        
        UILabel *txtLocation=[[UILabel alloc]initWithFrame:CGRectMake1(0, 30, 50, 30)];
        [txtLocation setTextColor:[UIColor whiteColor]];
        [txtLocation setText:@"杭州<"];
        [topView addSubview:txtLocation];
        
        UITextField *tfSearch=[[UITextField alloc]initWithFrame:CGRectMake1(0, 60, 200, 30)];
        [tfSearch setPlaceholder:@"输入搜索信息"];
        [topView addSubview:tfSearch];
        
        
        
        
        
        self.dataItemArray=[[NSMutableArray alloc]init];
        [self.dataItemArray addObject:@"1"];//Banner条
        [self.dataItemArray addObject:@"2"];//导航
        [self.dataItemArray addObject:@"3"];//分类
        [self.dataItemArray addObject:@"4"];//资讯
        
        self.tableView=[[UITableView alloc]initWithFrame:CGRectMake1(0, TOPNAVHEIGHT, 320, self.view.bounds.size.height-TOPNAVHEIGHT)];
        [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        self.tableView.separatorColor=[UIColor clearColor];
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
        [self.view addSubview:self.tableView];
    }
    return self;
}

- (void)viewDidLoad {
    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    statusBarView.backgroundColor=[UIColor orangeColor];
    [self.view addSubview:statusBarView];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [super viewDidLoad];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *content=[self.dataItemArray objectAtIndex:[indexPath row]];
    if([@"1" isEqualToString:content]){
        return 162;
    }else if([@"2" isEqualToString:content]){
        return 262;
    }else if([@"3" isEqualToString:content]){
        return 362;
    }else{
        return 462;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CMainCell = @"CMainCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CMainCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier: CMainCell];
    }
    NSString *content=[self.dataItemArray objectAtIndex:[indexPath row]];
    cell.textLabel.text=content;
    return cell;
}

@end
