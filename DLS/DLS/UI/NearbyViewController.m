//
//  NearbyViewController.m
//  DLS
//
//  Created by Start on 3/2/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "NearbyViewController.h"

#define LINECOLOR [UIColor colorWithRed:(226/255.0) green:(226/255.0) blue:(226/255.0) alpha:1]
#define TITLECOLOR [UIColor colorWithRed:(111/255.0) green:(111/255.0) blue:(111/255.0) alpha:1]
#define CATEGORYBGCOLOR [UIColor colorWithRed:(94/255.0) green:(144/255.0) blue:(237/255.0) alpha:1]
#define SEARCHTIPCOLOR [UIColor colorWithRed:(88/255.0) green:(130/255.0) blue:(216/255.0) alpha:1]

@interface NearbyViewController ()

@end

@implementation NearbyViewController{
    long long currentButtonIndex;
}

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"附近"];
        //搜索框架
        UIView *vSearchFramework=[[UIView alloc]initWithFrame:CGRectMake1(0, 25, 250, 30)];
        vSearchFramework.userInteractionEnabled=YES;
        vSearchFramework.layer.cornerRadius = 5;
        vSearchFramework.layer.masksToBounds = YES;
        [vSearchFramework setBackgroundColor:[UIColor whiteColor]];
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
        UIButton *btnMap = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnMap setBackgroundImage:[UIImage imageNamed:@"map"]forState:UIControlStateNormal];
        [btnMap addTarget:self action:@selector(goMap:) forControlEvents:UIControlEventTouchUpInside];
        btnMap.frame = CGRectMake(0, 0, 24, 20);
        UIBarButtonItem *negativeSpacerRight = [[UIBarButtonItem alloc]
                                                initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                target:nil action:nil];
        negativeSpacerRight.width = -5;
        self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacerRight, [[UIBarButtonItem alloc] initWithCustomView:btnMap], nil];
        
        UIView *categoryFrame=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 41)];
        [self.view addSubview:categoryFrame];
        self.button1=[[UIButton alloc]initWithFrame:CGRectMake1(0, 0, 79, 40)];
        [[self.button1 titleLabel]setFont:[UIFont systemFontOfSize:14]];
        [self.button1 setTitle:@"状态" forState:UIControlStateNormal];
        self.button1.tag=1;
        [self.button1 addTarget:self action:@selector(switchCategory:) forControlEvents:UIControlEventTouchDown];
        [categoryFrame addSubview:self.button1];
        self.button2=[[UIButton alloc]initWithFrame:CGRectMake1(80, 0, 79, 40)];
        [[self.button2 titleLabel]setFont:[UIFont systemFontOfSize:14]];
        [self.button2 setTitle:@"类型" forState:UIControlStateNormal];
        self.button2.tag=2;
        [self.button2 addTarget:self action:@selector(switchCategory:) forControlEvents:UIControlEventTouchDown];
        [categoryFrame addSubview:self.button2];
        self.button3=[[UIButton alloc]initWithFrame:CGRectMake1(160, 0, 79, 40)];
        [[self.button3 titleLabel]setFont:[UIFont systemFontOfSize:14]];
        [self.button3 setTitle:@"吨位" forState:UIControlStateNormal];
        self.button3.tag=3;
        [self.button3 addTarget:self action:@selector(switchCategory:) forControlEvents:UIControlEventTouchDown];
        [categoryFrame addSubview:self.button3];
        self.button4=[[UIButton alloc]initWithFrame:CGRectMake1(240, 0, 80, 40)];
        [[self.button4 titleLabel]setFont:[UIFont systemFontOfSize:14]];
        [self.button4 setTitle:@"距离" forState:UIControlStateNormal];
        self.button4.tag=4;
        [self.button4 addTarget:self action:@selector(switchCategory:) forControlEvents:UIControlEventTouchDown];
        UIView *line1=[[UIView alloc]initWithFrame:CGRectMake1(79, 0, 1, 40)];
        [line1 setBackgroundColor:LINECOLOR];
        [categoryFrame addSubview:line1];
        UIView *line2=[[UIView alloc]initWithFrame:CGRectMake1(159, 0, 1, 40)];
        [line2 setBackgroundColor:LINECOLOR];
        [categoryFrame addSubview:line2];
        UIView *line3=[[UIView alloc]initWithFrame:CGRectMake1(239, 0, 1, 40)];
        [line3 setBackgroundColor:LINECOLOR];
        [categoryFrame addSubview:line3];
        UIView *line4=[[UIView alloc]initWithFrame:CGRectMake1(0, 40, 320, 1)];
        [line4 setBackgroundColor:LINECOLOR];
        [categoryFrame addSubview:line4];
        [categoryFrame addSubview:self.button4];
        //表视图
        self.tableView=[[UITableView alloc]initWithFrame:CGRectMake1(0, 41, self.view.bounds.size.width, self.view.bounds.size.height-41)];
        [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
        [self.view addSubview:self.tableView];
        //添加UIRefreshControl下拉刷新控件到UITableViewController的view中
        self.refreshControl = [[UIRefreshControl alloc]init];
        [self.refreshControl addTarget:self action:@selector(RefreshViewControlEventValueChanged) forControlEvents:UIControlEventValueChanged];
        [self.tableView addSubview:self.refreshControl];
        [self autoRefreshData];
        
        currentButtonIndex=1;
        [self showHiddenCategory];
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
    return 62;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CMainCell = @"CMainCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CMainCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier: CMainCell];
    }
    cell.textLabel.text = @"jfdsjalkfj";
    return cell;
}

- (void)switchCategory:(UIButton*)sender {
    currentButtonIndex=sender.tag;
    [self showHiddenCategory];
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
}
//搜索
- (void)goSearch:(id)sender
{
}
//地图
- (void)goMap:(UIButton*)sender
{
}

@end
