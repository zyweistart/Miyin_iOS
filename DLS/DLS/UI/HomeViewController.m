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
        
        //搜索框
        UITextField *tfSearch=[[UITextField alloc]initWithFrame:CGRectMake1(60, 0, 120, 30)];
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
        static NSString *CMainCell = @"CHomeBannerCell";
        HomeBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:CMainCell];
        if (cell == nil) {
            cell = [[HomeBannerCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier: CMainCell];
        }
        return cell;
    }else if([@"2" isEqualToString:row]){
        static NSString *CMainCell = @"CHomeCategoryCell";
        HomeCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CMainCell];
        if (cell == nil) {
            cell = [[HomeCategoryCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier: CMainCell];
        }
        return cell;
    }else{
        static NSString *CMainCell = @"CHomeInformationCell";
        HomeInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:CMainCell];
        if (cell == nil) {
            cell = [[HomeInformationCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier: CMainCell];
        }
        return cell;
    }
}

@end