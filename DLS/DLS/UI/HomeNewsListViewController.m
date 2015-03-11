//
//  HomeNewsListViewController.m
//  DLS
//
//  Created by Start on 3/11/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "HomeNewsListViewController.h"
#import "InformationCell.h"

#define BGCOLOR [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1]
#define LINEBGCOLOR [UIColor colorWithRed:(214/255.0) green:(214/255.0) blue:(214/255.0) alpha:1]
#define CATEGORYBGCOLOR [UIColor colorWithRed:(173/255.0) green:(176/255.0) blue:(181/255.0) alpha:1]

#define MAINTITLECOLOR [UIColor colorWithRed:(110/255.0) green:(139/255.0) blue:(205/255.0) alpha:1]
#define CHILDTITLECOLOR [UIColor colorWithRed:(158/255.0) green:(158/255.0) blue:(158/255.0) alpha:1]
#define TITLECOLOR [UIColor colorWithRed:(54/255.0) green:(54/255.0) blue:(54/255.0) alpha:1]

@interface HomeNewsListViewController ()

@end

@implementation HomeNewsListViewController{
    long long currentButtonIndex;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:BGCOLOR];
    // 注意：contentsize.height必须要大于bounds.size.height，否则不能滚动，也就无法回到父view
    self.scrollView.contentSize = CGSizeMake(320, 600);
    //主体
    UIView *mainFrame=[[UIView alloc]initWithFrame:CGRectMake1(0, 10, 320, 450)];
    [self.scrollView addSubview:mainFrame];
    //分类
    UIView *categoryFrame =[[UIView alloc] initWithFrame:CGRectMake1(10, 0, 300, 40)] ;
    [mainFrame addSubview:categoryFrame];
    //资讯主体
    UIView *informationFrame =[[UIView alloc] initWithFrame:CGRectMake1(0, 40, 320, 400)] ;
    [mainFrame addSubview:informationFrame];
    
    self.button1=[[UIButton alloc]initWithFrame:CGRectMake1(0, 0, 75, 40)];
    [[self.button1 titleLabel]setFont:[UIFont systemFontOfSize:14]];
    [self.button1 setTitle:@"最新出租" forState:UIControlStateNormal];
    self.button1.tag=1;
    [self.button1 addTarget:self action:@selector(switchCategory:) forControlEvents:UIControlEventTouchDown];
    [categoryFrame addSubview:self.button1];
    self.button2=[[UIButton alloc]initWithFrame:CGRectMake1(75, 0, 75, 40)];
    [[self.button2 titleLabel]setFont:[UIFont systemFontOfSize:14]];
    [self.button2 setTitle:@"最新求租" forState:UIControlStateNormal];
    self.button2.tag=2;
    [self.button2 addTarget:self action:@selector(switchCategory:) forControlEvents:UIControlEventTouchDown];
    [categoryFrame addSubview:self.button2];
    self.button3=[[UIButton alloc]initWithFrame:CGRectMake1(150, 0, 75, 40)];
    [[self.button3 titleLabel]setFont:[UIFont systemFontOfSize:14]];
    [self.button3 setTitle:@"中标结果" forState:UIControlStateNormal];
    self.button3.tag=3;
    [self.button3 addTarget:self action:@selector(switchCategory:) forControlEvents:UIControlEventTouchDown];
    [categoryFrame addSubview:self.button3];
    self.button4=[[UIButton alloc]initWithFrame:CGRectMake1(225, 0, 75, 40)];
    [[self.button4 titleLabel]setFont:[UIFont systemFontOfSize:14]];
    [self.button4 setTitle:@"行业资讯" forState:UIControlStateNormal];
    self.button4.tag=4;
    [self.button4 addTarget:self action:@selector(switchCategory:) forControlEvents:UIControlEventTouchDown];
    [categoryFrame addSubview:self.button4];
    
    //表视图、下拉刷新
    self.tableView1=[[UITableView alloc]initWithFrame:informationFrame.bounds];
    self.refreshControl1 = [[UIRefreshControl alloc]init];
    self.tableView2=[[UITableView alloc]initWithFrame:informationFrame.bounds];
    self.refreshControl2 = [[UIRefreshControl alloc]init];
    self.tableView3=[[UITableView alloc]initWithFrame:informationFrame.bounds];
    self.refreshControl3 = [[UIRefreshControl alloc]init];
    self.tableView4=[[UITableView alloc]initWithFrame:informationFrame.bounds];
    self.refreshControl4 = [[UIRefreshControl alloc]init];
    
    [self addTableView:self.tableView1 RefreshViewControl:self.refreshControl1 Frame:informationFrame];
    [self addTableView:self.tableView2 RefreshViewControl:self.refreshControl2 Frame:informationFrame];
    [self addTableView:self.tableView3 RefreshViewControl:self.refreshControl3 Frame:informationFrame];
    [self addTableView:self.tableView4 RefreshViewControl:self.refreshControl4 Frame:informationFrame];
    
    //默认展示页面
    currentButtonIndex=1;
    [self showHiddenCategory];
}

- (void)switchCategory:(UIButton*)sender {
    currentButtonIndex=sender.tag;
    [self showHiddenCategory];
    //展示数据
    if(currentButtonIndex==1){
        [self.tableView1 reloadData];
    }else if(currentButtonIndex==2){
        [self.tableView2 reloadData];
    }else if(currentButtonIndex==3){
        [self.tableView3 reloadData];
    }else{
        [self.tableView4 reloadData];
    }
}

- (void)showHiddenCategory{
    [self.button1 setTitleColor:currentButtonIndex==1?[UIColor whiteColor]:TITLECOLOR forState:UIControlStateNormal];
    [self.button1 setBackgroundColor:currentButtonIndex==1?CATEGORYBGCOLOR:[UIColor whiteColor]];
    [self.button2 setTitleColor:currentButtonIndex==2?[UIColor whiteColor]:TITLECOLOR forState:UIControlStateNormal];
    [self.button2 setBackgroundColor:currentButtonIndex==2?CATEGORYBGCOLOR:[UIColor whiteColor]];
    [self.button3 setTitleColor:currentButtonIndex==3?[UIColor whiteColor]:TITLECOLOR forState:UIControlStateNormal];
    [self.button3 setBackgroundColor:currentButtonIndex==3?CATEGORYBGCOLOR:[UIColor whiteColor]];
    [self.button4 setTitleColor:currentButtonIndex==4?[UIColor whiteColor]:TITLECOLOR forState:UIControlStateNormal];
    [self.button4 setBackgroundColor:currentButtonIndex==4?CATEGORYBGCOLOR:[UIColor whiteColor]];
    [self.tableView1 setHidden:currentButtonIndex==1?NO:YES];
    [self.tableView2 setHidden:currentButtonIndex==2?NO:YES];
    [self.tableView3 setHidden:currentButtonIndex==3?NO:YES];
    [self.tableView4 setHidden:currentButtonIndex==4?NO:YES];
}

- (void)addTableView:(UITableView*)tableView RefreshViewControl:(UIRefreshControl*)refreshControl Frame:(UIView*)frame
{
    [tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    //    tableView.separatorColor=[UIColor clearColor];
    [tableView setBackgroundColor:[UIColor clearColor]];
    [frame addSubview:tableView];
    [refreshControl addTarget:self action:@selector(RefreshViewControlEventValueChanged) forControlEvents:UIControlEventValueChanged];
    [tableView addSubview:refreshControl];
}

//刷新事件
- (void)RefreshViewControlEventValueChanged
{
    if(currentButtonIndex==1){
        if (self.refreshControl1.refreshing) {
            [self performSelector:@selector(handleData) withObject:nil afterDelay:2];
        }
    }else if(currentButtonIndex==2){
        if (self.refreshControl2.refreshing) {
            [self performSelector:@selector(handleData) withObject:nil afterDelay:2];
        }
    }else if(currentButtonIndex==3){
        if (self.refreshControl3.refreshing) {
            [self performSelector:@selector(handleData) withObject:nil afterDelay:2];
        }
    }else{
        if (self.refreshControl4.refreshing) {
            [self performSelector:@selector(handleData) withObject:nil afterDelay:2];
        }
    }
}

- (void)handleData
{
    if(currentButtonIndex==1){
        [self.refreshControl1 endRefreshing];
        [self.tableView1 reloadData];
    }else if(currentButtonIndex==2){
        [self.refreshControl2 endRefreshing];
        [self.tableView2 reloadData];
    }else if(currentButtonIndex==3){
        [self.refreshControl3 endRefreshing];
        [self.tableView3 reloadData];
    }else{
        [self.refreshControl4 endRefreshing];
        [self.tableView4 reloadData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    if(currentButtonIndex==1){
    //        return [self.dataItemArray1 count];
    //    }else if(currentButtonIndex==2){
    //        return [self.dataItemArray1 count];
    //    }else if(currentButtonIndex==3){
    //        return [self.dataItemArray1 count];
    //    }else{
    //        return [self.dataItemArray1 count];
    //    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CELL = @"CInformationCell";
    InformationCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL];
    if (cell == nil) {
        cell = [[InformationCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier: CELL];
    }
    [cell.childTitle setText:@"这是子标题这是子标题这是子标题这是子标题这是子标题这是子标题这是子标题这是子标题这是子标题这是子标题这是子标题这是子标题这是子标题这是子标题"];
    if(currentButtonIndex==1){
        [cell.image setImage:[UIImage imageNamed:@"category1"]];
        [cell.mainTitle setText:@"这是主标题11"];
    }else if(currentButtonIndex==2){
        [cell.image setImage:[UIImage imageNamed:@"category2"]];
        [cell.mainTitle setText:@"这是主标题22"];
    }else if(currentButtonIndex==3){
        [cell.image setImage:[UIImage imageNamed:@"category3"]];
        [cell.mainTitle setText:@"这是主标题33"];
    }else{
        [cell.image setImage:[UIImage imageNamed:@"category4"]];
        [cell.mainTitle setText:@"这是主标题44"];
    }
    return cell;
}

@end
