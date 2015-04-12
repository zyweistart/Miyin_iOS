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

@interface VIPViewController ()

@end

@implementation VIPViewController {
    BOOL ISFIRSTINFLAG;
    CategoryView *categoryView;
    NSArray *searchData1,*searchData2,*searchData3,*searchData4;
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
        
        searchData1=[NSArray arrayWithObjects:
                     [NSDictionary dictionaryWithObjectsAndKeys:@"不限",MKEY,@"-1",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"新发布",MKEY,@"0",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"洽谈中",MKEY,@"1",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"已成交",MKEY,@"2",MVALUE, nil], nil];
        searchData2=[NSArray arrayWithObjects:
                     [NSDictionary dictionaryWithObjectsAndKeys:@"不限",MKEY,@"-1",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"汽车吊",MKEY,@"1",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"履带吊",MKEY,@"2",MVALUE, nil],nil];
        searchData3=[NSArray arrayWithObjects:
                     [NSDictionary dictionaryWithObjectsAndKeys:@"不限",MKEY,@"-1",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"8吨",MKEY,@"8",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"12吨",MKEY,@"12",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"25吨",MKEY,@"25",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"35吨",MKEY,@"35",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"50吨",MKEY,@"50",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"65吨",MKEY,@"65",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"70吨",MKEY,@"70",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"90吨",MKEY,@"90",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"100吨",MKEY,@"100",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"120吨",MKEY,@"120",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"130吨",MKEY,@"130",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"150吨",MKEY,@"150",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"180吨",MKEY,@"180",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"200吨",MKEY,@"200",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"220吨",MKEY,@"220",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"260吨",MKEY,@"260",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"300吨",MKEY,@"300",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"350吨",MKEY,@"350",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"400吨",MKEY,@"400",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"500吨",MKEY,@"500",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"600吨",MKEY,@"600",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"800吨",MKEY,@"800",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"1000吨",MKEY,@"1000",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"1200吨",MKEY,@"1200",MVALUE, nil],nil];
        searchData4=[NSArray arrayWithObjects:
                     [NSDictionary dictionaryWithObjectsAndKeys:@"不限",MKEY,@"-1",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"3KM",MKEY,@"1",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"5KM",MKEY,@"2",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"10KM",MKEY,@"3",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"20KM",MKEY,@"4",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"30KM",MKEY,@"5",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"50KM",MKEY,@"6",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"100KM",MKEY,@"7",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"150KM",MKEY,@"8",MVALUE, nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"200KM",MKEY,@"9",MVALUE, nil],nil];
        
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
        }
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
        int row=[indexPath row];
        NSDictionary *d=[self.dataItemArray objectAtIndex:row];
        [cell setData:d];
        return cell;
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.dataItemArray count]>0){
        NSLog(@"跳转");
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
    if(![[User Instance]isLogin]){
        [self presentViewControllerNav:[[LoginViewController alloc]init]];
        return;
    }
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

@end