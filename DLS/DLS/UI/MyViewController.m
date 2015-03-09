//
//  MyViewController.m
//  DLS
//
//  Created by Start on 3/2/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "MyViewController.h"
#import "MyCZViewController.h"
#import "MyQZViewController.h"
#import "MySBXSViewController.h"
#import "MySBWXViewController.h"
#import "MyBJXSViewController.h"
#import "MyVIPGCViewController.h"
#import "MyZPXXViewController.h"
#import "MyQZYPViewController.h"
#import "MyHelpCenterViewController.h"

#import "UIButton+TitleImage.h"

#define LINEBGCOLOR [UIColor colorWithRed:(167/255.0) green:(183/255.0) blue:(216/255.0) alpha:0.5]

static CGFloat kImageOriginHight = 200.f;

@interface MyViewController ()

@end

@implementation MyViewController

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"我的"];
        self.dataItemArray=[[NSMutableArray alloc]init];
        [self.dataItemArray addObject:[NSArray arrayWithObjects:@"我的出租",@"我的求租",@"设备销售",@"设备维修",@"配件销售",@"VIP工程", nil]];
        [self.dataItemArray addObject:[NSArray arrayWithObjects:@"招聘信息",@"我的求职", nil]];
        [self.dataItemArray addObject:[NSArray arrayWithObjects:@"帮助中心",@"得力手客服中心", nil]];

        self.tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
        [self.view addSubview:self.tableView];
        
        self.expandZoomImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, kImageOriginHight)];
        [self.expandZoomImageView setImage:[UIImage imageNamed:@"personalbg"]];
        self.tableView.contentInset = UIEdgeInsetsMake(kImageOriginHight, 0, 0, 0);
        [self.tableView addSubview:self.expandZoomImageView];
        
        UIView *personalFrame=[[UIView alloc]initWithFrame:CGRectMake1(0, kImageOriginHight-170, 320, 160)];
        [self.expandZoomImageView addSubview:personalFrame];
        //设置
        UIButton *btnSetting = [[UIButton alloc]initWithFrame:CGRectMake1(280, 0, 20, 20)];
        [btnSetting setBackgroundImage:[UIImage imageNamed:@"setting"]forState:UIControlStateNormal];
        [btnSetting addTarget:self action:@selector(goSetting:) forControlEvents:UIControlEventTouchUpInside];
        [personalFrame addSubview:btnSetting];
        //头像
        UIButton *bHead=[[UIButton alloc]initWithFrame:CGRectMake1(120, 20, 80, 80)];
        [bHead setTitle:@"我是得力手" forImage:[UIImage imageNamed:@"头像"]];
        [bHead.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [personalFrame addSubview:bHead];
        //底部功能
        UIView *bottomFrame=[[UIView alloc]initWithFrame:CGRectMake1(0, 120, 320, 40)];
        [personalFrame addSubview:bottomFrame];
        UIButton *bCollection=[[UIButton alloc]initWithFrame:CGRectMake1(0, 0, 79, 40)];
        [bCollection setTitle:@"收藏" forImage:[UIImage imageNamed:@"collection"]];
        [bottomFrame addSubview:bCollection];
        UIButton *bAccount=[[UIButton alloc]initWithFrame:CGRectMake1(80, 0, 79, 40)];
        [bAccount setTitle:@"账号" forImage:[UIImage imageNamed:@"account"]];
        [bottomFrame addSubview:bAccount];
        UIButton *bIntegral=[[UIButton alloc]initWithFrame:CGRectMake1(160, 0, 80, 40)];
        [bIntegral setTitle:@"积分" forImage:[UIImage imageNamed:@"integral"]];
        [bottomFrame addSubview:bIntegral];
        UIButton *bMessage=[[UIButton alloc]initWithFrame:CGRectMake1(240, 0, 80, 40)];
        [bMessage setTitle:@"消息" forImage:[UIImage imageNamed:@"message"]];
        [bottomFrame addSubview:bMessage];
        //竖线
        UIView *line1=[[UIView alloc]initWithFrame:CGRectMake1(79, 0, 1, 40)];
        [line1 setBackgroundColor:LINEBGCOLOR];
        [bottomFrame addSubview:line1];
        UIView *line2=[[UIView alloc]initWithFrame:CGRectMake1(159, 0, 1, 40)];
        [line2 setBackgroundColor:LINEBGCOLOR];
        [bottomFrame addSubview:line2];
        UIView *line3=[[UIView alloc]initWithFrame:CGRectMake1(239, 0, 1, 40)];
        [line3 setBackgroundColor:LINEBGCOLOR];
        [bottomFrame addSubview:line3];
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
    self.expandZoomImageView.frame = CGRectMake(0, -kImageOriginHight, self.tableView.frame.size.width, kImageOriginHight);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat yOffset  = scrollView.contentOffset.y;
    if (yOffset < -kImageOriginHight) {
        CGRect f = self.expandZoomImageView.frame;
        f.origin.y = yOffset;
        f.size.height =  -yOffset;
        self.expandZoomImageView.frame = f;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataItemArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.dataItemArray objectAtIndex:section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CMainCell = @"CMainCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CMainCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier: CMainCell];
    }
    NSString *content=[[self.dataItemArray objectAtIndex:[indexPath section]]objectAtIndex:[indexPath row]];
    [cell.imageView setImage:[UIImage imageNamed:content]];
    cell.textLabel.text = content;
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section=[indexPath section];
    NSInteger row=[indexPath row];
    if(section==0){
        if(row==0){
            [self.navigationController pushViewController:[[MyCZViewController alloc]init] animated:YES];
        }else if(row==1){
            [self.navigationController pushViewController:[[MyQZViewController alloc]init] animated:YES];
        }else if(row==2){
            [self.navigationController pushViewController:[[MySBXSViewController alloc]init] animated:YES];
        }else if(row==3){
            [self.navigationController pushViewController:[[MySBWXViewController alloc]init] animated:YES];
        }else if(row==4){
            [self.navigationController pushViewController:[[MyBJXSViewController alloc]init] animated:YES];
        }else if(row==5){
            [self.navigationController pushViewController:[[MyVIPGCViewController alloc]init] animated:YES];
        }
    }else if(section==1){
        if(row==0){
            [self.navigationController pushViewController:[[MyZPXXViewController alloc]init] animated:YES];
        }else if(row==1){
            [self.navigationController pushViewController:[[MyQZYPViewController alloc]init] animated:YES];
        }
    }else{
        if(row==0){
            [self.navigationController pushViewController:[[MyHelpCenterViewController alloc]init] animated:YES];
        }else if(row==1){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[NSString alloc] initWithFormat:@"tel://%@",@"057187071527"]]];
        }
    }
}

- (void)goSetting:(UIButton*)sender
{
    NSLog(@"设置");
}

@end
