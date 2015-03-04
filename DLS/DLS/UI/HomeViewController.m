//
//  HomeViewController.m
//  DLS
//
//  Created by Start on 3/2/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeBannerCell.h"
#import "HomeCategoryCell.h"
#import "HomeInformationCell.h"
#import <QuartzCore/QuartzCore.h>

#define TOPNAVBGCOLOR [UIColor colorWithRed:(46/255.0) green:(92/255.0) blue:(178/255.0) alpha:1]

#define TOPNAVHEIGHT 60

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
        //定位文案
        UILabel *txtLocation=[[UILabel alloc]initWithFrame:CGRectMake1(5, 25, 50, 30)];
        [txtLocation setTextColor:[UIColor whiteColor]];
        [txtLocation setText:@"杭州"];
        [txtLocation setFont:[UIFont systemFontOfSize:15]];
        [txtLocation setTextAlignment:NSTextAlignmentCenter];
        [topView addSubview:txtLocation];
        //搜索框架
        UIView *vSearchFramework=[[UIView alloc]initWithFrame:CGRectMake1(60, 25, 200, 30)];
        vSearchFramework.layer.cornerRadius = 15;
        vSearchFramework.layer.masksToBounds = YES;
        [vSearchFramework setBackgroundColor:[UIColor colorWithRed:(33/255.0) green:(67/255.0) blue:(131/255.0) alpha:1]];
        [topView addSubview:vSearchFramework];
        //搜索图标
        UIImageView *iconSearch=[[UIImageView alloc]initWithFrame:CGRectMake1(10, 6, 18, 18)];
        [iconSearch setImage:[UIImage imageNamed:@"search"]];
        [vSearchFramework addSubview:iconSearch];
        //搜索框
        UITextField *tfSearch=[[UITextField alloc]initWithFrame:CGRectMake1(38, 0, 152, 30)];
        [tfSearch setPlaceholder:@"输入搜索信息"];
        [tfSearch setTextColor:[UIColor whiteColor]];
        [vSearchFramework addSubview:tfSearch];
        //右消息按钮
        UIImageView *imgMessage=[[UIImageView alloc]initWithFrame:CGRectMake1(278, 30, 24, 20)];
        [imgMessage setImage:[UIImage imageNamed:@"message"]];
        [topView addSubview:imgMessage];
        //
        self.dataItemArray=[[NSMutableArray alloc]init];
        [self.dataItemArray addObject:@"1"];//导航
        [self.dataItemArray addObject:@"2"];//分类
        [self.dataItemArray addObject:@"3"];//资讯
        
        self.tableView=[[UITableView alloc]initWithFrame:CGRectMake1(0, TOPNAVHEIGHT, 320, self.view.bounds.size.height-TOPNAVHEIGHT)];
        [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        self.tableView.separatorColor=[UIColor clearColor];
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
        [self.view addSubview:self.tableView];
        
        [self addRefreshViewControl];
        
        [self autoRefreshData];
        
    }
    return self;
}

//自动下载刷新
- (void)autoRefreshData{
    //自行创建下拉动画
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    //注意位移点的y值为负值
    self.tableView.contentOffset=CGPointMake(0.0, -200.0);
    [UIView commitAnimations];
    //改变refreshcontroller的状态
    [self.refreshControl beginRefreshing];
    //刷新数据和表格视图
    [self RefreshViewControlEventValueChanged];
}

//添加UIRefreshControl下拉刷新控件到UITableViewController的view中
- (void)addRefreshViewControl
{
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.refreshControl addTarget:self action:@selector(RefreshViewControlEventValueChanged) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
}

//刷新事件
- (void)RefreshViewControlEventValueChanged
{
    if (self.refreshControl.refreshing) {
        [self performSelector:@selector(handleData) withObject:nil afterDelay:2];
    }
}

- (void)handleData
{
    [self.refreshControl endRefreshing];
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *content=[self.dataItemArray objectAtIndex:[indexPath row]];
    if([@"1" isEqualToString:content]){
        //导航
        return 290;
    }else if([@"2" isEqualToString:content]){
        //分类
        return 234;
    }else{
        //资讯
        return 460;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *row=[self.dataItemArray objectAtIndex:[indexPath row]];
    if([@"1" isEqualToString:row]){
        static NSString *CHomeBannerCell = @"CHomeBannerCell";
        HomeBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:CHomeBannerCell];
        if (cell == nil) {
            cell = [[HomeBannerCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier: CHomeBannerCell];
        }
        return cell;
    }else if([@"2" isEqualToString:row]){
        static NSString *CHomeCategoryCell = @"CHomeCategoryCell";
        HomeCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CHomeCategoryCell];
        if (cell == nil) {
            cell = [[HomeCategoryCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier: CHomeCategoryCell];
        }
        return cell;
    }else{
        static NSString *CHomeInformationCell = @"CHomeInformationCell";
        HomeInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:CHomeInformationCell];
        if (cell == nil) {
            cell = [[HomeInformationCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier: CHomeInformationCell];
        }
        return cell;
    }
}

@end