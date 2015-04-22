//
//  ElectricianDetailViewController.m
//  eClient
//
//  Created by Start on 4/13/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "ElectricianDetailViewController.h"
#import "SVButton.h"
#define TITLECOLOR [UIColor colorWithRed:(153/255.0) green:(153/255.0) blue:(153/255.0) alpha:1]
#define LINECOLOR [UIColor colorWithRed:(233/255.0) green:(233/255.0) blue:(233/255.0) alpha:1]

@interface ElectricianDetailViewController ()

@end

@implementation ElectricianDetailViewController

- (id)initWithParams:(NSMutableDictionary *)data{
    self=[super init];
    if(self){
        self.paramData=data;
        [self setTitle:@"电工详情"];
        [self buildTableViewWithView:self.view];
        //头
        UIView *topView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 123)];
        [self.tableView setTableHeaderView:topView];
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 0, 220, 40)];
        [lbl setText:[NSString stringWithFormat:@"电话:%@",[data objectForKey:@"mb2"]]];
        [lbl setTextColor:TITLECOLOR];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [topView addSubview:lbl];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(250, 0, 160, 40)];
        [lbl setText:[NSString stringWithFormat:@"接单:%@",[data objectForKey:@"GRAB_COUNT"]]];
        [lbl setTextColor:TITLECOLOR];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [topView addSubview:lbl];
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake1(10, 40, 300, 1)];
        [line setBackgroundColor:LINECOLOR];
        [topView addSubview:line];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 41, 200, 40)];
        [lbl setText:[NSString stringWithFormat:@"距离:%@",@"0米"]];
        [lbl setTextColor:TITLECOLOR];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [topView addSubview:lbl];
        line=[[UIView alloc]initWithFrame:CGRectMake1(10, 81, 300, 1)];
        [line setBackgroundColor:LINECOLOR];
        [topView addSubview:line];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 82, 100, 40)];
        [lbl setText:@"评价"];
        [lbl setTextColor:TITLECOLOR];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [topView addSubview:lbl];
        line=[[UIView alloc]initWithFrame:CGRectMake1(10, 122, 300, 1)];
        [line setBackgroundColor:LINECOLOR];
        [topView addSubview:line];
        //底
        UIView *bottomView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 40)];
        [self.tableView setTableFooterView:bottomView];
        SVButton *caButton=[[SVButton alloc]initWithFrame:CGRectMake1(10,5, 300, 30) Title:@"联系他" Type:3];
        [caButton addTarget:self action:@selector(call:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:caButton];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
        return CGHeight(45);
    }else{
//        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
        return CGHeight(300);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.dataItemArray count]>0){
        static NSString *cellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        NSDictionary *data =[self.dataItemArray objectAtIndex:[indexPath row]];
        [cell.textLabel setText:[data objectForKey:@"EVALUATE_NOTE"]];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
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

- (void)loadHttp
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[[User Instance]getUserName] forKey:@"imei"];
    [params setObject:[[User Instance]getPassword] forKey:@"authentication"];
    [params setObject:@"600203" forKey:@"GNID"];
    [params setObject:[self.paramData objectForKey:@"USER_ID"] forKey:@"QTKEY"];
    [params setObject:[self.paramData objectForKey:@"LONGITUDE"] forKey:@"QTKEY1"];
    [params setObject:[self.paramData objectForKey:@"LATITUDE"] forKey:@"QTVAL"];
    [params setObject:PAGESIZE forKey:@"QTPSIZE"];
    [params setObject:[NSString stringWithFormat:@"%ld",[self currentPage]]  forKey:@"QTPINDEX"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest handle:URL_appDistributeTasks requestParams:params];
}

- (void)call:(id)sender
{
    NSString *tel=[self.paramData objectForKey:@"mb2"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[NSString alloc] initWithFormat:@"tel://%@",tel]]];
}

@end
