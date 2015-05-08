//
//  SearchViewController.m
//  DLS
//
//  Created by Start on 5/8/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "SearchViewController.h"
#import "ProjectCell.h"
#import "QiuzuDetailViewController.h"
#import "RentalDetailViewController.h"

#define SEARCHTIPCOLOR [UIColor colorWithRed:(88/255.0) green:(130/255.0) blue:(216/255.0) alpha:1]

@interface SearchViewController ()

@end

@implementation SearchViewController{
    UITextField *tfSearch;
}

- (id)init{
    self=[super init];
    if(self){
        UIView *vSearchFramework=[[UIView alloc]initWithFrame:CGRectMake1(0, 25, 250, 30)];
        vSearchFramework.layer.cornerRadius = 5;
        vSearchFramework.layer.masksToBounds = YES;
        [vSearchFramework setBackgroundColor:[UIColor whiteColor]];
        //搜索图标
        UIImageView *iconSearch=[[UIImageView alloc]initWithFrame:CGRectMake1(10, 6, 18, 18)];
        [iconSearch setImage:[UIImage imageNamed:@"search"]];
        [vSearchFramework addSubview:iconSearch];
        //搜索框
        tfSearch=[[UITextField alloc]initWithFrame:CGRectMake1(38, 0, 152, 30)];
        [tfSearch setPlaceholder:@"输入搜索信息"];
        [tfSearch setTextColor:SEARCHTIPCOLOR];
        [tfSearch setFont:[UIFont systemFontOfSize:14]];
        [vSearchFramework addSubview:tfSearch];
        [self navigationItem].titleView=vSearchFramework;
        //搜索
        UIButton *bSearch = [UIButton buttonWithType:UIButtonTypeCustom];
        [bSearch setTitle:@"搜索" forState:UIControlStateNormal];
        [bSearch.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [bSearch setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bSearch addTarget:self action:@selector(goSearch:) forControlEvents:UIControlEventTouchUpInside];
        bSearch.frame = CGRectMake(0, 0, 70, 30);
        bSearch.layer.cornerRadius = 5;
        bSearch.layer.masksToBounds = YES;
        [bSearch setBackgroundColor:[UIColor colorWithRed:(52/255.0) green:(177/255.0) blue:(59/255.0) alpha:1]];
        UIBarButtonItem *negativeSpacerRight = [[UIBarButtonItem alloc]
                                                initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                target:nil action:nil];
        negativeSpacerRight.width = -10;
        self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacerRight, [[UIBarButtonItem alloc] initWithCustomView:bSearch], nil];
        
        [self buildTableViewWithView:self.view];
    }
    return self;
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
        [[cell status]setHidden:YES];
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

- (void)loadHttp
{
    NSString *searchContent=[tfSearch text];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"35" forKey:@"Id"];
    [params setObject:[NSString stringWithFormat:@"%ld",[self currentPage]] forKey:@"index"];
    NSMutableDictionary *search=[[NSMutableDictionary alloc]init];
    [search setObject:searchContent forKey:@"keyword"];
    [params setObject:search forKey:@"search"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest handle:@"GetListALL" requestParams:params];
}

- (void)goSearch:(id)sender
{
    [tfSearch resignFirstResponder];
    if(!self.tableView.pullTableIsRefreshing) {
        self.tableView.pullTableIsRefreshing=YES;
        [self performSelector:@selector(refreshTable) withObject:nil afterDelay:1.0f];
    }
}

@end