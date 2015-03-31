//
//  EnterpriseDetailViewController.m
//  eClient
//
//  Created by Start on 3/31/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "EnterpriseDetailViewController.h"
#import "EnterpriseManagerViewController.h"
#import "EnterpriseHeightLowCell.h"

@interface EnterpriseDetailViewController ()

@end

@implementation EnterpriseDetailViewController{
    NSArray *companyArray,*heightArray,*lowArray;
    
}

- (id)initWithData:(NSDictionary*)data{
    self=[super init];
    if(self){
        self.data=data;
        [self setTitle:@"企业管理"];
        UIButton *bEdit = [UIButton buttonWithType:UIButtonTypeCustom];
        [bEdit setTitle:@"编辑" forState:UIControlStateNormal];
        [bEdit.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [bEdit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bEdit addTarget:self action:@selector(goEdit:) forControlEvents:UIControlEventTouchUpInside];
        bEdit.frame = CGRectMake(0, 0, 70, 30);
        bEdit.layer.cornerRadius = 5;
        bEdit.layer.masksToBounds = YES;
        UIBarButtonItem *negativeSpacerRight = [[UIBarButtonItem alloc]
                                                initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                target:nil action:nil];
        negativeSpacerRight.width = -20;
        self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacerRight, [[UIBarButtonItem alloc] initWithCustomView:bEdit], nil];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self get];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGHeight(30.0);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 30)];
    [frame setBackgroundColor:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1]];
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 5, 320, 20)];
    if(section==0){
        [lbl setText:@"企业信息"];
    }else if(section==1){
        [lbl setText:@"高压侧变压器信息"];
    }else{
        [lbl setText:@"低压侧变压器信息"];
    }
    [lbl setFont:[UIFont systemFontOfSize:14]];
    [lbl setTextColor:[UIColor blackColor]];
    [lbl setTextAlignment:NSTextAlignmentLeft];
    [frame addSubview:lbl];
    return frame;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section=[indexPath section];
    if(section==0){
        return CGHeight(45);
    }else if(section==1){
        return CGHeight(60);
    }else{
        return CGHeight(60);
    }
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0){
        return 2;
    }else if(section==1){
        return [heightArray count];
    }else{
        return [lowArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section=[indexPath section];
    NSInteger row=[indexPath row];
    if(section==0){
        static NSString *cellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        }
        NSDictionary *data=[companyArray objectAtIndex:0];
        if(row==0){
            [cell.textLabel setText:@"企业名称"];
            [cell.detailTextLabel setText:[data objectForKey:@"NAME"]];
        }else{
            [cell.textLabel setText:@"联系电话"];
            [cell.detailTextLabel setText:[data objectForKey:@"TEL"]];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }else{
        static NSString *cellIdentifier = @"EnterpriseHeightLowCell";
        EnterpriseHeightLowCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell) {
            cell = [[EnterpriseHeightLowCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        }
        if(section==1){
            [cell setData:[heightArray objectAtIndex:row]];
        }else{
            [cell setData:[lowArray objectAtIndex:row]];
        }
        return cell;
    }
}

- (void)get
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[[User Instance]getUserName] forKey:@"imei"];
    [params setObject:[[User Instance]getPassword] forKey:@"authentication"];
    [params setObject:[self.data objectForKey:@"CP_ID"] forKey:@"QTCP"];
    [params setObject:@"AC05" forKey:@"GNID"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest handle:URL_appTaskingFps requestParams:params];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if([response successFlag]){
        companyArray=[[response resultJSON]objectForKey:@"table1"];
        heightArray=[[response resultJSON] objectForKey:@"tablehigh"];
        lowArray=[[response resultJSON] objectForKey:@"tablelow"];
        [self buildTableViewWithView:self.view];
    }
}

- (void)goEdit:(id)sender
{
    EnterpriseManagerViewController *enterpriseManagerViewController=[[EnterpriseManagerViewController alloc]init];
    [enterpriseManagerViewController setCompanyArray:companyArray];
    [enterpriseManagerViewController setHeightArray:heightArray];
    [enterpriseManagerViewController setLowArray:lowArray];
    [self.navigationController pushViewController:enterpriseManagerViewController animated:YES];
}

@end