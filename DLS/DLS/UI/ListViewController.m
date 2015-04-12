//
//  ListViewController.m
//  DLS
//
//  Created by Start on 3/5/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "ListViewController.h"
#import "ProjectCell.h"
#import "ProjectDCell.h"
#import "InformationCell.h"
#import "NewsDetailViewController.h"
#import "RecruitmentDetailViewController.h"

@interface ListViewController ()

@end

@implementation ListViewController{
    NSDictionary *idsData;
}

- (id)initWithTitle:(NSString*)title Type:(NSInteger)type
{
    self=[super init];
    if(self){
        self.type=type;
        [self setTitle:title];
        [self buildTableViewWithView:self.view];
        idsData=[NSDictionary dictionaryWithObjectsAndKeys:
              @"1",@"1",//汽车吊求租-
              @"1",@"2",//履带吊求租-
              @"4",@"3",//VIP独家项目
              @"1",@"4",//工程信息-
              @"1",@"5",//汽车吊出租-
              @"1",@"6",//履带吊出租-
              @"5",@"7",//招标公告
              @"6",@"8",//招聘信息
              @"9",@"9",//大件运输
              @"11",@"10",//吊车配件
              @"10",@"11",//维修企业
              @"12",@"12",//二手吊车
              @"1",@"13",//其他设备-
              @"1",@"14",//项目预告-
              @"8",@"15",//超重机制造商
              @"14",@"16",//企业大全
                 nil];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if([[self dataItemArray]count]==0){
        if(!self.tableView.pullTableIsRefreshing) {
            self.tableView.pullTableIsRefreshing=YES;
            [self performSelector:@selector(refreshTable) withObject:nil afterDelay:1.0f];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.dataItemArray count]>0){
        if(self.type==7){
            return CGHeight(80);
        }else if(self.type==8){
            return CGHeight(70);
        }else{
            return CGHeight(80);
        }
    }else{
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.dataItemArray count]>0){
        if(self.type==7){
            //招标公告
            static NSString *cellIdentifier = @"CInformationCell";
            InformationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if(!cell) {
                cell = [[InformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            [cell setData:[self.dataItemArray objectAtIndex:[indexPath row]]];
            return cell;
        }else if(self.type==8){
            //招聘信息
            static NSString *cellIdentifier = @"CProjectDCell";
            ProjectDCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if(!cell) {
                cell = [[ProjectDCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            [cell setData:[self.dataItemArray objectAtIndex:[indexPath row]]];
            return cell;
        }else{
            static NSString *cellIdentifier = @"CProjectCell";
            ProjectCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (cell == nil) {
                cell = [[ProjectCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier: cellIdentifier];
            }
            [cell setData:[self.dataItemArray objectAtIndex:[indexPath row]]];
            return cell;
        }
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.dataItemArray count]>0){
        if(self.type==7){
            //招标公告
            [self.navigationController pushViewController:[[NewsDetailViewController alloc]initWithDictionary:nil] animated:YES];
        }else if(self.type==8){
            //招聘详情
            [self.navigationController pushViewController:[[RecruitmentDetailViewController alloc]initWithDictionary:nil] animated:YES];
        }else{
            
        }
    }
}

- (void)loadHttp
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[idsData objectForKey:[NSString stringWithFormat:@"%d",self.type]] forKey:@"Id"];
    [params setObject:[NSString stringWithFormat:@"%d",self.currentPage] forKey:@"index"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest handle:@"GetListALL" requestParams:params];
}

@end
