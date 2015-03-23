//
//  aViewController.m
//  test
//
//  Created by apple on 14-6-9.
//  Copyright (c) 2014年 zhuhuaxi. All rights reserved.
//

#import "aViewController.h"
#import "MyTableViewCell.h"
#import "DetialView.h"
#import "Model.h"

@interface aViewController ()

@end

@implementation aViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //所有的总数据数组 数组套数组 最里面是model 下边创建的仅仅是测试数组
    _array = [[NSMutableArray alloc]initWithCapacity:0];
    for (int i = 0; i < 3; i++) {
        NSMutableArray *arr=[[NSMutableArray alloc]initWithCapacity:0];
        for (int j = 0; j < 6; j++) {
            Model*model=[[Model alloc]init];
            model.str1 =[NSString stringWithFormat:@"张三%d",i];
            model.str2 = [NSString stringWithFormat:@"aaaa%d",j];
            model.isExpand = NO;
            [arr addObject:model];
        }
        [_array addObject:arr];
    }
    //表数据源数组
    _CurrentArray = [[NSMutableArray alloc]initWithCapacity:0];
    for (int i = 0; i<_array.count; i++) {
        [_CurrentArray addObject:@[]];
    }
    //创建表
    [self buildTableViewWithView:self.view];
}

#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _CurrentArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *cellIdentifier = @"Cell";
    MyTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[MyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    } else {
        if (cell.model) {
            if (cell.model != [[_CurrentArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]) {
                cell.model = [[_CurrentArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
                if (cell.model.isExpand==NO) {
                    cell.model=nil;
                }
            }
        } else {
            cell.model = [[_CurrentArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            if (cell.model.isExpand==NO) {
                cell.model=nil;
            }
        }
    }
    [cell layoutSubviews];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_CurrentArray objectAtIndex:section]count];
}

//点击单元格 展开、收缩 model信息
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyTableViewCell*cell=(MyTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    Model*model=[[_array objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    model.isExpand = !model.isExpand;
    if (cell.model) {
        cell.model=nil;
    } else {
        cell.model=model;
    }
    [cell layoutSubviews];
    [tableView reloadData];
}

//设置区头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

//判断model是否被展示 来控制单元格高度
//可以在自定义view中 写+号方法计算 以下因没具体数据是省略写法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Model*model=[[_array objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    if (!model.isExpand){
        return   44;
    } else {
        return  124;
    }
}

//自定义区头 把区头model 创建的view写这里
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView*view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 44)];
    view.backgroundColor = [UIColor yellowColor];
    UIButton*btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 44,44);
    btn.backgroundColor=[UIColor redColor];
    btn.tag = section;
    [btn addTarget:self action:@selector(expand:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    return view;
}

#pragma mark - ActionMethord
//点击区头按钮 修改数据源数组 展开区
- (void)expand:(UIButton*)btn
{
    if([[_CurrentArray objectAtIndex:btn.tag] isEqualToArray:@[]]){
        [_CurrentArray replaceObjectAtIndex:btn.tag withObject:[_array objectAtIndex:btn.tag]];
    } else {
        [_CurrentArray replaceObjectAtIndex:btn.tag withObject:@[]];
    }
    [self.tableView reloadData];
}

@end
