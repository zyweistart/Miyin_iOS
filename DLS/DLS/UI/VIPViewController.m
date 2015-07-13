//
//  VIPViewController.m
//  DLS
//
//  Created by Start on 3/2/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "VIPViewController.h"
#import "LoginViewController.h"
#import "ProjectCell.h"
#import "QiuzuDetailViewController.h"
#import "RentalDetailViewController.h"

@interface VIPViewController ()

@end

@implementation VIPViewController {
    BOOL ISFIRSTINFLAG;
    CategoryView *categoryView;
    NSInteger pvs1,pvs2,pvs3,pvs4;
    int currentType;
}

- (id)init
{
    self=[super init];
    if(self){
        //搜索框架
        SearchView *searchView=[[SearchView alloc]initWithFrame:CGRectMake1(0, 0, 250, 30)];
        [searchView setController:self];
        [self navigationItem].titleView=searchView;
        //分类
        categoryView=[[CategoryView alloc]initWithFrame:CGRectMake1(0, 0, 320, 40) Title1:@"状态" Titlte2:@"类型" Title3:@"吨位" Title4:@"距离"];
        [categoryView setDelegate:self];
        
        [self buildTableViewWithView:self.view];
        [self.tableView setTableHeaderView:categoryView];
        
        self.pv1=[[SinglePickerView alloc]initWithFrame:self.view.bounds WithArray:[CommonData getStatus]];
        [self.pv1 setCode:1];
        [self.pv1 setDelegate:self];
        [self.view addSubview:self.pv1];
        
        self.pv2=[[SinglePickerView alloc]initWithFrame:self.view.bounds WithArray:[CommonData getType1]];
        [self.pv2 setCode:2];
        [self.pv2 setDelegate:self];
        [self.view addSubview:self.pv2];
        
        self.pv3=[[SinglePickerView alloc]initWithFrame:self.view.bounds WithArray:[CommonData getSearchTon]];
        [self.pv3 setCode:3];
        [self.pv3 setDelegate:self];
        [self.view addSubview:self.pv3];
        
        self.pv4=[[SinglePickerView alloc]initWithFrame:self.view.bounds WithArray:[CommonData getDistance]];
        [self.pv4 setCode:4];
        [self.pv4 setDelegate:self];
        [self.view addSubview:self.pv4];
        
    }
    return self;
}

- (id)initWithType:(int)type
{
    self=[self init];
    if(self){
        currentType=type;
        if(type==1||type==5){
            //汽车吊求租汽车吊出租
            [self.pv2.picker selectRow:1 inComponent:0 animated:YES];
            [self pickerViewDone:2];
        }else if(type==2||type==6){
            //履带吊求租，履带吊出租
            [self.pv2.picker selectRow:2 inComponent:0 animated:YES];
            [self pickerViewDone:2];
        }else if(type==3||type==7){
            //履带吊求租，履带吊出租
            [self.pv2.picker selectRow:3 inComponent:0 animated:YES];
            [self pickerViewDone:2];
        }
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self performSelector:@selector(appear) withObject:nil];
}

- (void)appear
{
    if(currentType==1||currentType==5||currentType==2||currentType==6||currentType==3||currentType==7){
        if(!ISFIRSTINFLAG){
            [categoryView setIndex:1];
            if(!self.tableView.pullTableIsRefreshing) {
                self.tableView.pullTableIsRefreshing=YES;
                [self performSelector:@selector(refreshTable) withObject:nil afterDelay:1.0f];
            }
        }
    }else{
        if(![[User Instance]isLogin]){
            //            [self presentViewControllerNav:[[LoginViewController alloc]init]];
        }else{
            if(!ISFIRSTINFLAG){
                [categoryView setIndex:1];
                if(!self.tableView.pullTableIsRefreshing) {
                    self.tableView.pullTableIsRefreshing=YES;
                    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:1.0f];
                }
            }
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.dataItemArray count]>0){
        return CGHeight(85);
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
        NSUInteger row=[indexPath row];
        NSDictionary *d=[self.dataItemArray objectAtIndex:row];
        [cell setData:d];
        if(currentType==1||currentType==5||currentType==2||currentType==6||currentType==3||currentType==7){
            [[cell status]setHidden:NO];
        }else{
            [[cell status]setHidden:YES];
        }
        return cell;
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.dataItemArray count]>0){
        NSDictionary *data=[self.dataItemArray objectAtIndex:[indexPath row]];
        NSString *ClassId=[NSString stringWithFormat:@"%@",[data objectForKey:@"ClassId"]];
        if([@"41" isEqualToString:ClassId]){
            //出租
            [self.navigationController pushViewController:[[QiuzuDetailViewController alloc]initWithDictionary:data] animated:YES];
        }else if([@"42" isEqualToString:ClassId]){
            //求租
            [self.navigationController pushViewController:[[RentalDetailViewController alloc]initWithDictionary:data] animated:YES];
        }else if([@"44" isEqualToString:ClassId]){
            //VIP
            [self.navigationController pushViewController:[[QiuzuDetailViewController alloc]initWithDictionary:data] animated:YES];
        }
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

- (void)loadHttp
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    NSMutableDictionary *search=[[NSMutableDictionary alloc]init];
    if(pvs1>0){
        NSDictionary *d=[self.pv1.pickerArray objectAtIndex:pvs1];
        [search setObject:[d objectForKey:MVALUE] forKey:@"status"];
    }
    if(pvs2>0){
        NSDictionary *d=[self.pv2.pickerArray objectAtIndex:pvs2];
        [search setObject:[d objectForKey:MVALUE] forKey:@"xlValue"];
    }
    if(pvs3>0){
        NSDictionary *d=[self.pv3.pickerArray objectAtIndex:pvs3];
        [search setObject:[d objectForKey:MVALUE] forKey:@"weight"];
    }
    if(pvs4>0){
        NSDictionary *d=[self.pv4.pickerArray objectAtIndex:pvs4];
        [search setObject:[d objectForKey:MVALUE] forKey:@"distance"];
    }
    [params setObject:search forKey:@"search"];
    if(currentType==1){
        //汽车吊求租
        [params setObject:@"1" forKey:@"Id"];
    }else if(currentType==5){
        //汽车吊出租
        [params setObject:@"3" forKey:@"Id"];
    }else if(currentType==2){
        //履带吊求租
        [params setObject:@"1" forKey:@"Id"];
    }else if(currentType==6){
        //履带吊出租
        [params setObject:@"3" forKey:@"Id"];
    }else if(currentType==3){
        //塔吊求租
        [params setObject:@"1" forKey:@"Id"];
    }else if(currentType==7){
        //塔吊出租
        [params setObject:@"3" forKey:@"Id"];
    }else{
        //VIP工程
        [params setObject:@"4" forKey:@"Id"];
        [params setObject:[[User Instance]accessToken] forKey:@"access_token"];
    }
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
        NSDictionary *d=[self.pv1.pickerArray objectAtIndex:pvs1];
        [categoryView.button1 setTitle:[d objectForKey:MKEY] forState:UIControlStateNormal];
    }else if(code==2){
        pvs2=[self.pv2.picker selectedRowInComponent:0];
        NSDictionary *d=[self.pv2.pickerArray objectAtIndex:pvs2];
        [categoryView.button2 setTitle:[d objectForKey:MKEY] forState:UIControlStateNormal];
    }else if(code==3){
        pvs3=[self.pv3.picker selectedRowInComponent:0];
        NSDictionary *d=[self.pv3.pickerArray objectAtIndex:pvs3];
        [categoryView.button3 setTitle:[d objectForKey:MKEY] forState:UIControlStateNormal];
    }else if(code==4){
        pvs4=[self.pv4.picker selectedRowInComponent:0];
        NSDictionary *d=[self.pv4.pickerArray objectAtIndex:pvs4];
        [categoryView.button4 setTitle:[d objectForKey:MKEY] forState:UIControlStateNormal];
    }
    //刷新
    if(!self.tableView.pullTableIsRefreshing) {
        self.tableView.pullTableIsRefreshing=YES;
        [self performSelector:@selector(refreshTable) withObject:nil afterDelay:1.0f];
    }
}

- (void)lookDetail:(id)sender
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[[User Instance]accessToken] forKey:@"access_token"];
    [params setObject:@"35" forKey:@"classId"];
    [params setObject:@"35" forKey:@"Id"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    //BuyInfo
    [self.hRequest handle:@"CheckPayUserMoney" requestParams:params];
}

@end