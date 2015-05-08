//
//  IntegralViewController.m
//  DLS
//
//  Created by Start on 3/10/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "IntegralViewController.h"
#import "IntegralVCell.h"

@interface IntegralViewController ()

@end

@implementation IntegralViewController

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"积分"];
        //返回
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]
                                               initWithTitle:@"返回"
                                               style:UIBarButtonItemStyleBordered
                                               target:self
                                               action:@selector(goBack:)];
        
        UIView *topFrame=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 70)];
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 0, 65, 40)];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setText:@"当前积分:"];
        [lbl setTextAlignment:NSTextAlignmentLeft];
        [lbl setTextColor:[UIColor blackColor]];
        [topFrame addSubview:lbl];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(75, 0, 200, 40)];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setText:[NSString stringWithFormat:@"%@",[[[User Instance]resultData] objectForKey:@"userMoney"]]];
        [lbl setTextAlignment:NSTextAlignmentLeft];
        [lbl setTextColor:[UIColor redColor]];
        [topFrame addSubview:lbl];
        
        UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(0, 40, 320, 30)];
        [frame setBackgroundColor:[UIColor grayColor]];
        [topFrame addSubview:frame];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(0, 0, 110, 30)];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setText:@"时间"];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [lbl setTextColor:[UIColor blackColor]];
        [frame addSubview:lbl];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(110, 0, 100, 30)];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setText:@"积分明细"];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [lbl setTextColor:[UIColor blackColor]];
        [frame addSubview:lbl];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake1(210, 0, 110, 30)];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setText:@"数量"];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [lbl setTextColor:[UIColor blackColor]];
        [frame addSubview:lbl];
        [self buildTableViewWithView:self.view];
        [self.tableView setTableHeaderView:topFrame];
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
        return CGHeight(45);
    }else{
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.dataItemArray count]>0){
        static NSString *cellIdentifier = @"Cell";
        IntegralVCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell) {
            cell = [[IntegralVCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        NSDictionary *data=[self.dataItemArray objectAtIndex:[indexPath row]];
        NSString *CreateDate=[Common convertTime:[data objectForKey:@"CreateDate"]];
        NSString *whyTxt=[Common getString:[data objectForKey:@"whyTxt"]];
        NSString *BOrPay=[Common getString:[data objectForKey:@"BOrPay"]];
        NSLog(@"%@",data);
        [cell.lbl1 setText:CreateDate];
        [cell.lbl2 setText:whyTxt];
        [cell.lbl3 setText:BOrPay];
        return cell;
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

- (void)loadHttp
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"33" forKey:@"Id"];
    [params setObject:[[User Instance]accessToken] forKey:@"access_token"];
    [params setObject:[NSString stringWithFormat:@"%ld",[self currentPage]] forKey:@"index"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest handle:@"GetListALL" requestParams:params];
}

@end
