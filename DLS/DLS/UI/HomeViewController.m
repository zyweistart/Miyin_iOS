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
#import "LocationViewController.h"
#import "MessageViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ListViewController.h"

#define SEARCHTIPCOLOR [UIColor colorWithRed:(88/255.0) green:(130/255.0) blue:(216/255.0) alpha:1]

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)init{
    self=[super init];
    if(self){
        //定位信息
        NSString *lTitle=@"杭州";
        CGSize titleSize = [lTitle sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15.0f],NSFontAttributeName, nil]];
        UIButton *location = [UIButton buttonWithType:UIButtonTypeCustom];
        [location setTitle:lTitle forState:UIControlStateNormal];
        [location.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [location setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [location addTarget:self action:@selector(goLocation:) forControlEvents:UIControlEventTouchUpInside];
        location.frame = CGRectMake(0, 0, titleSize.width, 30);
        UIBarButtonItem *negativeSpacerLeft = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacerLeft.width = -10;
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects: negativeSpacerLeft,[[UIBarButtonItem alloc] initWithCustomView:location],nil];
        
        //搜索框架
        UIView *vSearchFramework=[[UIView alloc]initWithFrame:CGRectMake1(0, 25, 250, 30)];
        vSearchFramework.userInteractionEnabled=YES;
        vSearchFramework.layer.cornerRadius = 15;
        vSearchFramework.layer.masksToBounds = YES;
        [vSearchFramework setBackgroundColor:[UIColor colorWithRed:(33/255.0) green:(67/255.0) blue:(131/255.0) alpha:1]];
        [vSearchFramework addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goSearch:)]];
        [self navigationItem].titleView=vSearchFramework;
        //搜索图标
        UIImageView *iconSearch=[[UIImageView alloc]initWithFrame:CGRectMake1(10, 6, 18, 18)];
        [iconSearch setImage:[UIImage imageNamed:@"search"]];
        [vSearchFramework addSubview:iconSearch];
        //搜索框
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(38, 0, 152, 30)];
        [lbl setText:@"输入搜索信息"];
        [lbl setTextColor:SEARCHTIPCOLOR];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [vSearchFramework addSubview:lbl];
        
        //右消息按钮
        UIButton *btnMessage = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnMessage setBackgroundImage:[UIImage imageNamed:@"message1"]forState:UIControlStateNormal];
        [btnMessage addTarget:self action:@selector(goMessage:) forControlEvents:UIControlEventTouchUpInside];
        btnMessage.frame = CGRectMake(0, 0, 24, 20);
        UIBarButtonItem *negativeSpacerRight = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacerRight.width = -5;
        self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacerRight, [[UIBarButtonItem alloc] initWithCustomView:btnMessage], nil];
        
        self.tableView=[[UITableView alloc]initWithFrame:self.view.bounds];
        [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        self.tableView.separatorColor=[UIColor clearColor];
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
        [self.view addSubview:self.tableView];
        //添加UIRefreshControl下拉刷新控件到UITableViewController的view中
        self.refreshControl = [[UIRefreshControl alloc]init];
        [self.refreshControl addTarget:self action:@selector(RefreshViewControlEventValueChanged) forControlEvents:UIControlEventValueChanged];
        [self.tableView addSubview:self.refreshControl];
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([indexPath row]==0){
        //导航
        return 290;
    }else if([indexPath row]==1){
        //分类
        return 234;
    }else{
        //资讯
        return 450;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([indexPath row]==0){
        static NSString *CHomeBannerCell = @"CHomeBannerCell";
        HomeBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:CHomeBannerCell];
        if (cell == nil) {
            cell = [[HomeBannerCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier: CHomeBannerCell];
        }
        [cell setController:self];
        return cell;
    }else if([indexPath row]==1){
        static NSString *CHomeCategoryCell = @"CHomeCategoryCell";
        HomeCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CHomeCategoryCell];
        if (cell == nil) {
            cell = [[HomeCategoryCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier: CHomeCategoryCell];
        }
        [cell setController:self];
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
//定位
- (void)goLocation:(UIButton*)sender
{
    [self presentViewController:[[LocationViewController alloc]init]];
}
//搜索
- (void)goSearch:(id)sender
{
    [self.navigationController pushViewController:[[ListViewController alloc]initWithTitle:@"出租列表" Type:2] animated:YES];
}
//消息
- (void)goMessage:(UIButton*)sender
{
    [self presentViewController:[[MessageViewController alloc]init]];
}

- (void)presentViewController:(UIViewController*)viewController
{
    UINavigationController *myViewControllerNav = [[UINavigationController alloc] initWithRootViewController:viewController];
    [[myViewControllerNav navigationBar]setBarTintColor:NAVBG];
    [[myViewControllerNav navigationBar]setBarStyle:UIBarStyleBlackTranslucent];
    [self presentViewController:myViewControllerNav animated:YES completion:nil];
}

@end