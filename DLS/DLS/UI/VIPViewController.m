//
//  VIPViewController.m
//  DLS
//
//  Created by Start on 3/2/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "VIPViewController.h"
#import "ProjectCell.h"

@interface VIPViewController ()

@end

@implementation VIPViewController {
    BOOL ISFIRSTINFLAG;
    CategoryView *categoryView;
    NSArray *searchData1,*searchData2,*searchData3,*searchData4;
    NSInteger pvs1,pvs2,pvs3,pvs4;
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
        
        [self buildTableViewWithView:self.view];
        [self.tableView setTableHeaderView:categoryView];
        
        searchData1=[NSArray arrayWithObjects:@"汽车吊",@"履带吊", nil];
        searchData2=[NSArray arrayWithObjects:@"出租",@"求租", nil];
        searchData3=[NSArray arrayWithObjects:@"8吨",@"12吨",@"20吨",@"25吨",@"30吨", nil];
        searchData4=[NSArray arrayWithObjects:@"1KM",@"2KM",@"3KM",@"4KM",@"5KM", nil];
        
        self.pv1=[[SinglePickerView alloc]initWithFrame:self.view.bounds WithArray:searchData1];
        [self.pv1 setCode:1];
        [self.pv1 setDelegate:self];
        [self.view addSubview:self.pv1];
        
        self.pv2=[[SinglePickerView alloc]initWithFrame:self.view.bounds WithArray:searchData2];
        [self.pv2 setCode:2];
        [self.pv2 setDelegate:self];
        [self.view addSubview:self.pv2];
        
        self.pv3=[[SinglePickerView alloc]initWithFrame:self.view.bounds WithArray:searchData3];
        [self.pv3 setCode:3];
        [self.pv3 setDelegate:self];
        [self.view addSubview:self.pv3];
        
        self.pv4=[[SinglePickerView alloc]initWithFrame:self.view.bounds WithArray:searchData4];
        [self.pv4 setCode:4];
        [self.pv4 setDelegate:self];
        [self.view addSubview:self.pv4];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(!ISFIRSTINFLAG){
        [categoryView setIndex:1];
        if(!self.tableView.pullTableIsRefreshing) {
            self.tableView.pullTableIsRefreshing=YES;
            [self performSelector:@selector(refreshTable) withObject:nil afterDelay:1.0f];
        }
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.dataItemArray count]>0){
        
    }
}

- (BOOL)CategoryViewChange:(long long)index
{
    if(!ISFIRSTINFLAG){
        ISFIRSTINFLAG=YES;
    }else{
        [self.pv1 setHidden:index==1?NO:YES];
        [self.pv2 setHidden:index==2?NO:YES];
        [self.pv3 setHidden:index==3?NO:YES];
        [self.pv4 setHidden:index==4?NO:YES];
    }
    return YES;
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

- (void)pickerViewDone:(int)code
{
    if(code==1){
        pvs1=[self.pv1.picker selectedRowInComponent:0];
        NSString *value=[self.pv1.pickerArray objectAtIndex:pvs1];
        [categoryView.button1 setTitle:value forState:UIControlStateNormal];
    }else if(code==2){
        pvs2=[self.pv2.picker selectedRowInComponent:0];
        NSString *value=[self.pv2.pickerArray objectAtIndex:pvs2];
        [categoryView.button2 setTitle:value forState:UIControlStateNormal];
    }else if(code==3){
        pvs3=[self.pv3.picker selectedRowInComponent:0];
        NSString *value=[self.pv3.pickerArray objectAtIndex:pvs3];
        [categoryView.button3 setTitle:value forState:UIControlStateNormal];
    }else if(code==4){
        pvs4=[self.pv4.picker selectedRowInComponent:0];
        NSString *value=[self.pv4.pickerArray objectAtIndex:pvs4];
        [categoryView.button4 setTitle:value forState:UIControlStateNormal];
    }
    //刷新
    if(!self.tableView.pullTableIsRefreshing) {
        self.tableView.pullTableIsRefreshing=YES;
        [self performSelector:@selector(refreshTable) withObject:nil afterDelay:1.0f];
    }
}

@end