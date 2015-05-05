//
//  HomeViewController.m
//  DLS
//
//  Created by Start on 3/2/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeBannerView.h"
#import "HomeCategoryView.h"
#import "InformationCell.h"
#import "LocationViewController.h"
#import "PublishQiuzuViewController.h"
#import "ListViewController.h"
#import "NewsDetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ProjectCell.h"
#import "QiuzuDetailViewController.h"
#import "RentalDetailViewController.h"

#define SEARCHTIPCOLOR [UIColor colorWithRed:(88/255.0) green:(130/255.0) blue:(216/255.0) alpha:1]
#define BGCOLOR [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1]
#define LINEBGCOLOR [UIColor colorWithRed:(214/255.0) green:(214/255.0) blue:(214/255.0) alpha:1]
#define CATEGORYBGCOLOR [UIColor colorWithRed:(173/255.0) green:(176/255.0) blue:(181/255.0) alpha:1]

#define MAINTITLECOLOR [UIColor colorWithRed:(110/255.0) green:(139/255.0) blue:(205/255.0) alpha:1]
#define CHILDTITLECOLOR [UIColor colorWithRed:(158/255.0) green:(158/255.0) blue:(158/255.0) alpha:1]
#define TITLECOLOR [UIColor colorWithRed:(54/255.0) green:(54/255.0) blue:(54/255.0) alpha:1]

@interface HomeViewController ()

@end

@implementation HomeViewController{
    BOOL isFirstRefresh;
    long long currentButtonIndex;
}

- (id)init{
    self=[super init];
    if(self){
        //搜索框架
        UIView *vSearchFramework=[[UIView alloc]initWithFrame:CGRectMake1(0, 25, 250, 30)];
        vSearchFramework.userInteractionEnabled=YES;
        vSearchFramework.layer.cornerRadius = 15;
        vSearchFramework.layer.masksToBounds = YES;
        [vSearchFramework setBackgroundColor:[UIColor colorWithRed:(33/255.0) green:(67/255.0) blue:(131/255.0) alpha:1]];
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
        //发布求租
        UIButton *bPublish = [UIButton buttonWithType:UIButtonTypeCustom];
        [bPublish setTitle:@"发布求租" forState:UIControlStateNormal];
        [bPublish.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [bPublish setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bPublish addTarget:self action:@selector(goPublish:) forControlEvents:UIControlEventTouchUpInside];
        bPublish.frame = CGRectMake(0, 0, 70, 30);
        bPublish.layer.cornerRadius = 5;
        bPublish.layer.masksToBounds = YES;
        [bPublish setBackgroundColor:[UIColor colorWithRed:(52/255.0) green:(177/255.0) blue:(59/255.0) alpha:1]];
        UIBarButtonItem *negativeSpacerRight = [[UIBarButtonItem alloc]
                                                initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                target:nil action:nil];
        negativeSpacerRight.width = -10;
        self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacerRight, [[UIBarButtonItem alloc] initWithCustomView:bPublish], nil];
        
        [self buildTableViewWithView:self.view];
        [self.tableView setBackgroundColor:BGCOLOR];
        UIView *header=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 330)];
        [self.tableView setTableHeaderView:header];
        HomeBannerView *banner=[[HomeBannerView alloc]initWithFrame:CGRectMake(0, 0, 320, 320)];
        [banner setController:self];
        [header addSubview:banner];
        //空格
        UIView *spaceFrame=[[UIView alloc]initWithFrame:CGRectMake1(0, 320, 320, 10)];
        [spaceFrame setBackgroundColor:BGCOLOR];
        [header addSubview:spaceFrame];
        //功能
        HomeCategoryView *category=[[HomeCategoryView alloc]initWithFrame:CGRectMake(0, 310, 320, 226)];
        [category setController:self];
//        [header addSubview:category];
        //空格
        spaceFrame=[[UIView alloc]initWithFrame:CGRectMake1(0, 312, 320, 10)];
        [spaceFrame setBackgroundColor:BGCOLOR];
//        [header addSubview:spaceFrame];
        
        currentButtonIndex=1;
        self.currentPage1=0;
        self.currentPage2=0;
        self.currentPage3=0;
        self.currentPage4=0;
        self.dataItemArray1=[[NSMutableArray alloc]init];
        self.dataItemArray2=[[NSMutableArray alloc]init];
        self.dataItemArray3=[[NSMutableArray alloc]init];
        self.dataItemArray4=[[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    if(!isFirstRefresh){
//        if(!self.tableView.pullTableIsRefreshing) {
//            isFirstRefresh=YES;
//            self.tableView.pullTableIsRefreshing=YES;
//            [self performSelector:@selector(refreshTable) withObject:nil afterDelay:1.0f];
//        }
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGHeight(40.0);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //分类
    UIView *categoryFrame =[[UIView alloc] initWithFrame:CGRectMake1(0, 0, 320, 40)] ;
    [categoryFrame setBackgroundColor:BGCOLOR];
    self.button1=[[UIButton alloc]initWithFrame:CGRectMake1(10, 0, 150, 40)];
    [[self.button1 titleLabel]setFont:[UIFont systemFontOfSize:14]];
    [self.button1 setTitle:@"最新求租" forState:UIControlStateNormal];
    self.button1.tag=1;
    [self.button1 addTarget:self action:@selector(switchCategory:) forControlEvents:UIControlEventTouchDown];
    [categoryFrame addSubview:self.button1];
    self.button2=[[UIButton alloc]initWithFrame:CGRectMake1(160, 0, 150, 40)];
    [[self.button2 titleLabel]setFont:[UIFont systemFontOfSize:14]];
    [self.button2 setTitle:@"最新出租" forState:UIControlStateNormal];
    self.button2.tag=2;
    [self.button2 addTarget:self action:@selector(switchCategory:) forControlEvents:UIControlEventTouchDown];
    [categoryFrame addSubview:self.button2];
    self.button3=[[UIButton alloc]initWithFrame:CGRectMake1(160, 0, 75, 40)];
    [[self.button3 titleLabel]setFont:[UIFont systemFontOfSize:14]];
    [self.button3 setTitle:@"中标结果" forState:UIControlStateNormal];
    self.button3.tag=3;
    [self.button3 addTarget:self action:@selector(switchCategory:) forControlEvents:UIControlEventTouchDown];
//    [categoryFrame addSubview:self.button3];
    self.button4=[[UIButton alloc]initWithFrame:CGRectMake1(235, 0, 75, 40)];
    [[self.button4 titleLabel]setFont:[UIFont systemFontOfSize:14]];
    [self.button4 setTitle:@"行业资讯" forState:UIControlStateNormal];
    self.button4.tag=4;
    [self.button4 addTarget:self action:@selector(switchCategory:) forControlEvents:UIControlEventTouchDown];
//    [categoryFrame addSubview:self.button4];
    
    [self showCategoryStatus];

    return categoryFrame;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[self dataItemArray] count]>0){
        return CGHeight(85);
    }else{
        return CGHeight(45);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[self dataItemArray] count]>0){
        if(currentButtonIndex==1||currentButtonIndex==2){
            static NSString *CProjectCell = @"CProjectCell";
            ProjectCell *cell = [tableView dequeueReusableCellWithIdentifier:CProjectCell];
            if (cell == nil) {
                cell = [[ProjectCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier: CProjectCell];
            }
            int row=[indexPath row];
            NSDictionary *d=[self.dataItemArray objectAtIndex:row];
            [cell setData:d];
            if(currentButtonIndex==2){
                [cell.status setHidden:YES];
            }else{
                [cell.status setHidden:NO];
            }
            return cell;
        }else{
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
    }else{
        static NSString *cellIdentifier = @"SAMPLECell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        [cell setBackgroundColor:BGCOLOR];
        [cell.textLabel setFont:[UIFont systemFontOfSize:13]];
        [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
        cell.textLabel.text = @"继续拖动加载更多~";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if(currentButtonIndex==1){
            self.currentPage1=0;
        }else if(currentButtonIndex==2){
            self.currentPage2=0;
        }else if(currentButtonIndex==3){
            self.currentPage3=0;
        }else{
            self.currentPage4=0;
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[self dataItemArray]count]>0){
        NSDictionary *data=[self.dataItemArray objectAtIndex:[indexPath row]];
        if(currentButtonIndex==1){
            [self.navigationController pushViewController:[[QiuzuDetailViewController alloc]initWithDictionary:data] animated:YES];
        }else if(currentButtonIndex==2){
            [self.navigationController pushViewController:[[RentalDetailViewController alloc]initWithDictionary:data] animated:YES];
        }else if(currentButtonIndex==3){
        }else{
            [self.navigationController pushViewController:[[NewsDetailViewController alloc]initWithDictionary:nil] animated:YES];
        }
    }
}

- (void)switchCategory:(UIButton*)sender
{
    if(!self.tableView.pullTableIsRefreshing&&!self.tableView.pullTableIsLoadingMore) {
        currentButtonIndex=sender.tag;
        [self showCategoryStatus];
        [self.tableView reloadData];
        //暂无数据则刷新列表
        if([[self dataItemArray] count]==0){
            if(!self.tableView.pullTableIsLoadingMore) {
                self.tableView.pullTableIsLoadingMore=YES;
                [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:1.0f];
            }
        }
    }
}

- (void)showCategoryStatus
{
    [self.button1 setTitleColor:currentButtonIndex==1?[UIColor whiteColor]:TITLECOLOR forState:UIControlStateNormal];
    [self.button1 setBackgroundColor:currentButtonIndex==1?CATEGORYBGCOLOR:[UIColor whiteColor]];
    [self.button2 setTitleColor:currentButtonIndex==2?[UIColor whiteColor]:TITLECOLOR forState:UIControlStateNormal];
    [self.button2 setBackgroundColor:currentButtonIndex==2?CATEGORYBGCOLOR:[UIColor whiteColor]];
    [self.button3 setTitleColor:currentButtonIndex==3?[UIColor whiteColor]:TITLECOLOR forState:UIControlStateNormal];
    [self.button3 setBackgroundColor:currentButtonIndex==3?CATEGORYBGCOLOR:[UIColor whiteColor]];
    [self.button4 setTitleColor:currentButtonIndex==4?[UIColor whiteColor]:TITLECOLOR forState:UIControlStateNormal];
    [self.button4 setBackgroundColor:currentButtonIndex==4?CATEGORYBGCOLOR:[UIColor whiteColor]];
}

//定位
- (void)goLocation:(UIButton*)sender
{
    [self presentViewControllerNav:[[LocationViewController alloc]init]];
}
//搜索
- (void)goSearch:(id)sender
{
//    [self presentViewControllerNav:[[ListViewController alloc]initWithTitle:@"出租列表" Type:2]];
}
//发布求租
- (void)goPublish:(UIButton*)sender
{
    [self.navigationController pushViewController:[[PublishQiuzuViewController alloc]init] animated:YES];
}

//头部下拉刷新
- (void)refreshTable
{
    [self performSelector:@selector(loadDone) withObject:nil afterDelay:1.0f];
}
//加载更多咨询数据
- (void)loadMoreDataToTable
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    if(currentButtonIndex==1){
        self.currentPage1++;
        [params setObject:@"1" forKey:@"Id"];
    }else if(currentButtonIndex==2){
        self.currentPage2++;
        [params setObject:@"3" forKey:@"Id"];
    }else if(currentButtonIndex==3){
        self.currentPage3++;
        [params setObject:@"1" forKey:@"Id"];
    }else{
        self.currentPage4++;
        [params setObject:@"1" forKey:@"Id"];
    }
    [params setObject:[NSString stringWithFormat:@"%d",self.currentPage] forKey:@"index"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest handle:@"GetListALL" requestParams:params];
}

- (int)currentPage
{
    if(currentButtonIndex==1){
        return self.currentPage1;
    }else if(currentButtonIndex==2){
        return self.currentPage2;
    }else if(currentButtonIndex==3){
        return self.currentPage3;
    }else{
        return self.currentPage4;
    }
}

- (NSMutableArray *)dataItemArray
{
    if(currentButtonIndex==1){
        return self.dataItemArray1;
    }else if(currentButtonIndex==2){
        return self.dataItemArray2;
    }else if(currentButtonIndex==3){
        return self.dataItemArray3;
    }else{
        return self.dataItemArray4;
    }
}

@end