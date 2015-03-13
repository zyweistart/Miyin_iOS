//
//  VIPViewController.m
//  DLS
//
//  Created by Start on 3/2/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "VIPViewController.h"
#import "ProjectCell.h"

#define LINECOLOR [UIColor colorWithRed:(226/255.0) green:(226/255.0) blue:(226/255.0) alpha:1]
#define TITLECOLOR [UIColor colorWithRed:(111/255.0) green:(111/255.0) blue:(111/255.0) alpha:1]
#define CATEGORYBGCOLOR [UIColor colorWithRed:(94/255.0) green:(144/255.0) blue:(237/255.0) alpha:1]
#define SEARCHTIPCOLOR [UIColor colorWithRed:(88/255.0) green:(130/255.0) blue:(216/255.0) alpha:1]

@interface VIPViewController ()

@end

@implementation VIPViewController {
    BOOL ISFIRSTINFLAG;
    CategoryView *categoryView;
}

- (id)init
{
    self=[super init];
    if(self){
        [self setTitle:@"VIP"];
        //搜索框架
        SearchView *searchView=[[SearchView alloc]initWithFrame:CGRectMake1(0, 0, 250, 30)];
        [searchView setController:self];
        [self navigationItem].titleView=searchView;
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
        //分类
        categoryView=[[CategoryView alloc]initWithFrame:CGRectMake1(0, 0, 320, 40) Title1:@"状态" Titlte2:@"类型" Title3:@"吨位" Title4:@"距离"];
        [categoryView setDelegate:self];
        [self.view addSubview:categoryView];
        //列表
        UIView *listView=[[UIView alloc]initWithFrame:CGRectMake1(0, 40, self.view.bounds.size.width, self.view.bounds.size.height-41)];
        [listView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.view addSubview:listView];
        [self buildTableViewWithView:listView];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(!ISFIRSTINFLAG){
        ISFIRSTINFLAG=YES;
        [categoryView setIndex:1];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.dataItemArray count]>0){
        return 80;
    }else{
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.dataItemArray count]>0){
        static NSString *CProjectCell = @"CProjectCell";
        ProjectCell *cell = [tableView dequeueReusableCellWithIdentifier:CProjectCell];
        if (cell == nil) {
            cell = [[ProjectCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier: CProjectCell];
        }
        [cell setData:[self.dataItemArray objectAtIndex:[indexPath row]]];
        return cell;
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

- (BOOL)CategoryViewChange:(long long)index
{
    if(!self.tableView.pullTableIsRefreshing) {
        self.tableView.pullTableIsRefreshing=YES;
        [self performSelector:@selector(refreshTable) withObject:nil afterDelay:1.0f];
        return YES;
    }else{
        //正在刷新中稍等
        return NO;
    }
}
//地图
- (void)goMap:(UIButton*)sender
{
    
}

- (void)loadHttp
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"1" forKey:@"Id"];
    [params setObject:[NSString stringWithFormat:@"%d",[self currentPage]] forKey:@"index"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest handle:@"GetListALL" requestParams:params];
}

@end
