//
//  ElectricianManagerViewController.m
//  eClient
//  企业电工管理
//  Created by Start on 3/21/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "ElectricianManagerViewController.h"
#import "LoginViewController.h"
#import "EDGManagerCell.h"
#import "EDGButtonCell.h"

#define HEADBGCOLOR [UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1]

@interface ElectricianManagerViewController ()

@end

@implementation ElectricianManagerViewController{
    NSMutableArray *_array;
    NSMutableArray *_arrayData;
    NSIndexPath *tmpIndexPath;
}

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"企业电工管理"];
        _array = [[NSMutableArray alloc]initWithCapacity:0];
        _arrayData = [[NSMutableArray alloc]initWithCapacity:0];
        [self buildTableViewWithView:self.view];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if([[User Instance]isLogin]){
        if(!self.tableView.pullTableIsRefreshing) {
            self.tableView.pullTableIsRefreshing=YES;
            [self performSelector:@selector(refreshTable) withObject:nil afterDelay:1.0f];
        }
    }else{
        [self.navigationController pushViewController:[[LoginViewController alloc]init] animated:YES];
    }
}

#pragma mark - tableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataItemArray count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.dataItemArray objectAtIndex:section]count];
}

//设置区头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGHeight(40);
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSDictionary *data=[_arrayData objectAtIndex:section];
    UIView *head = [[UIView alloc]initWithFrame:CGRectMake1(0, 0, 300, 40)];
    [head setBackgroundColor:HEADBGCOLOR];
    UIButton *bTitle = [[UIButton alloc]initWithFrame:CGRectMake1(10, 0, 300, 40)];
    bTitle.tag = section;
    if([[self.dataItemArray objectAtIndex:section] isEqualToArray:@[]]){
        [bTitle setImage:[UIImage imageNamed:@"jt2up"] forState:UIControlStateNormal];
    } else {
        [bTitle setImage:[UIImage imageNamed:@"jt2"] forState:UIControlStateNormal];
    }
    [bTitle setTitle:[data objectForKey:@"NAME"] forState:UIControlStateNormal];
    [bTitle.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [bTitle setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bTitle setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)];
    [bTitle setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 10.0, 0.0, 0.0)];
    [bTitle setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [bTitle addTarget:self action:@selector(expand:) forControlEvents:UIControlEventTouchUpInside];
    [head addSubview:bTitle];
    return head;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section=[indexPath section];
    NSInteger row=[indexPath row];
    NSArray *array=[self.dataItemArray objectAtIndex:section];
    NSInteger count=[array count];
    if(row<count-1){
        return CGHeight(45);
    }else{
        return CGHeight(40);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section=[indexPath section];
    NSInteger row=[indexPath row];
    NSArray *array=[self.dataItemArray objectAtIndex:section];
    NSInteger count=[array count];
    if(row<count-1){
        static NSString *CEDGManagerCell = @"EDGManagerCell";
        EDGManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:CEDGManagerCell];
        if(!cell) {
            cell = [[EDGManagerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CEDGManagerCell];
        }
        NSDictionary *data= [[self.dataItemArray objectAtIndex:section]objectAtIndex:row];
        [cell.textLabel setText:[data objectForKey:@"NAME"]];
        return cell;
    }else{
        static NSString *CEDGManagerCell = @"EDGButtonCell";
        EDGButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:CEDGManagerCell];
        if(!cell) {
            cell = [[EDGButtonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CEDGManagerCell];
        }
        [cell setData:[_arrayData objectAtIndex:section]];
        [cell setController:self];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//要求委托方的编辑风格在表视图的一个特定的位置。
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section=[indexPath section];
    NSInteger row=[indexPath row];
    NSArray *array=[self.dataItemArray objectAtIndex:section];
    NSInteger count=[array count];
    //默认没有编辑风格
    UITableViewCellEditingStyle result = UITableViewCellEditingStyleNone;
    if(row<count-1){
        if ([tableView isEqual:self.tableView]) {
            //设置编辑风格为删除风格
            result = UITableViewCellEditingStyleDelete;
        }
    }
    return result;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    tmpIndexPath=indexPath;
    NSInteger section=[indexPath section];
    NSInteger row=[indexPath row];
    NSMutableArray *array=[self.dataItemArray objectAtIndex:section];
    //请求数据源提交的插入或删除指定行接收者。
    if(editingStyle ==UITableViewCellEditingStyleDelete){
        //如果编辑样式为删除样式
        if(row<[array count]){
            [self deleteHttp];
        }
    }
}

- (void)loadHttp
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[[User Instance]getUserName] forKey:@"imei"];
    [params setObject:[[User Instance]getPassword] forKey:@"authentication"];
    [params setObject:@"AC16" forKey:@"GNID"];
    [params setObject:PAGESIZE forKey:@"QTPSIZE"];
    [params setObject:[NSString stringWithFormat:@"%d",[self currentPage]]  forKey:@"QTPINDEX"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest handle:URL_appTaskingFps requestParams:params];
}

- (void)deleteHttp
{
    NSInteger section=[tmpIndexPath section];
    NSInteger row=[tmpIndexPath row];
    NSMutableArray *array=[self.dataItemArray objectAtIndex:section];
    NSDictionary *data=[array objectAtIndex:row];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[[User Instance]getUserName] forKey:@"imei"];
    [params setObject:[[User Instance]getPassword] forKey:@"authentication"];
    [params setObject:@"AC15" forKey:@"GNID"];
    [params setObject:[data objectForKey:@"CP_ID"] forKey:@"QTCP"];
    [params setObject:[data objectForKey:@"USER_ID"]  forKey:@"QTUSER"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:501];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest handle:URL_appTaskingFps requestParams:params];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if(reqCode==500){
        
        if([response successFlag]){
            NSDictionary *rData=[[response resultJSON] objectForKey:@"Results"];
            if(rData){
                //当前页
                self.currentPage=[[NSString stringWithFormat:@"%@",[rData objectForKey:@"PageIndex"]] intValue];
            }
            //获取数据列表
            if([self currentPage]==1){
                [_array removeAllObjects];
                [_arrayData removeAllObjects];
                [self.dataItemArray removeAllObjects];
            }
            NSArray *tData=[[response resultJSON] objectForKey:@"table1"];
            if(tData){
                //获取数据列表
                for(id data in tData){
                    [self.dataItemArray addObject:@[]];
                    [_array addObject:[data objectForKey:@"TASK_USER"]];
                }
                [_arrayData addObjectsFromArray:tData];
            }
        }
        [self loadDone];
    }else if(reqCode==501){
        NSInteger section=[tmpIndexPath section];
        NSInteger row=[tmpIndexPath row];
        NSMutableArray *array=[self.dataItemArray objectAtIndex:section];
        //如果编辑样式为删除样式
        if(row<[array count]){
            //移除数据源的数据
            [array removeObjectAtIndex:row];
            //移除tableView中的数据
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:tmpIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
        }
    }
}

//点击头按钮，修改数据源数组,展开区
- (void)expand:(UIButton*)sender
{
    if([[self.dataItemArray objectAtIndex:sender.tag] isEqualToArray:@[]]){
        NSMutableArray *arr=[NSMutableArray arrayWithArray:[_array objectAtIndex:sender.tag]];
        [arr addObject:@[]];
        [self.dataItemArray replaceObjectAtIndex:sender.tag withObject:arr];
    } else {
        [self.dataItemArray replaceObjectAtIndex:sender.tag withObject:@[]];
    }
    [self.tableView reloadData];
}

@end