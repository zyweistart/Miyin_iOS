//
//  ElectricityContrastViewController.m
//  eClient
//
//  Created by Start on 4/15/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "ElectricityContrastViewController.h"

#define HEADBGCOLOR [UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1]

@interface ElectricityContrastViewController ()

@end

@implementation ElectricityContrastViewController{
    NSMutableArray *headNumberArray;
    UIButton *bSwitchType;
    int type;
}

- (id)init
{
    self=[super init];
    if(self){
        headNumberArray=[[NSMutableArray alloc]init];
        [self setTitle:@"电量电费"];
        type=1;
        bSwitchType = [UIButton buttonWithType:UIButtonTypeCustom];
        [bSwitchType setFrame:CGRectMake1(0, 0, 50, 40)];
        [bSwitchType setTitle:@"按日" forState:UIControlStateNormal];
        [bSwitchType addTarget:self action:@selector(switchType:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *negativeSpacerRight = [[UIBarButtonItem alloc]
                                                initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                target:nil action:nil];
        negativeSpacerRight.width = -5;
        self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects: [[UIBarButtonItem alloc] initWithCustomView:bSwitchType],negativeSpacerRight, nil];
        [self buildTableViewWithView:self.view];
        UIImageView *headView=[[UIImageView alloc]initWithFrame:CGRectMake1(0, 0, 320, 40)];
        [headView setImage:[UIImage imageNamed:@"electricitybanner"]];
        [self.tableView setTableHeaderView:headView];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadHttp];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [headNumberArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

//设置区头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGHeight(30);
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *data=[headNumberArray objectAtIndex:section];
    UIView *head = [[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 30)];
    [head setBackgroundColor:HEADBGCOLOR];
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 0, 300, 30)];
    [lbl setText:[NSString stringWithFormat:@"%@电量",data]];
    [lbl setTextColor:[UIColor blackColor]];
    [lbl setFont:[UIFont systemFontOfSize:16]];
    [lbl setTextAlignment:NSTextAlignmentLeft];
    [head addSubview:lbl];
    return head;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CGHeight(45);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CMainCell = @"CMainCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CMainCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1  reuseIdentifier: CMainCell];
    }
    NSInteger section=[indexPath section];
    NSInteger row=[indexPath row];
    NSDictionary *data=[self.dataItemArray objectAtIndex:section];
    if(row==0){
        [cell.textLabel setText:@"尖峰电量"];
        [cell.detailTextLabel setText:[data objectForKey:@"PEAK_POWER"]];
    }else if(row==1){
        [cell.textLabel setText:@"高峰电量"];
        [cell.detailTextLabel setText:[data objectForKey:@"TIP_POWER"]];
    }else{
        [cell.textLabel setText:@"低谷电量"];
        [cell.detailTextLabel setText:[data objectForKey:@"VALLEY_POWER"]];
    }
    return cell;
}

- (void)loadHttp
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[[User Instance]getUserName] forKey:@"imei"];
    [params setObject:[[User Instance]getPassword] forKey:@"authentication"];
    [params setObject:[[[User Instance]getResultData]objectForKey:@"CP_ID"] forKey:@"QTCP"];
    self.hRequest=[[HttpRequest alloc]init];
    if(type==1){
        [params setObject:@"010501" forKey:@"GNID"];
        [self.hRequest setRequestCode:500];
    }else{
        [params setObject:@"010502" forKey:@"GNID"];
        [self.hRequest setRequestCode:501];
    }
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest handle:URL_appTaskingPower requestParams:params];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    [headNumberArray removeAllObjects];
    [self.dataItemArray removeAllObjects];
    if(reqCode==500){
        NSArray *table1=[[response resultJSON]objectForKey:@"table1"];
        NSArray *table2=[[response resultJSON]objectForKey:@"table2"];
        if(table1){
            NSDictionary *data=[table1 objectAtIndex:0];
            [headNumberArray addObject:[data objectForKey:@"REPORT_DAY"]];
            NSMutableDictionary *ds=[[NSMutableDictionary alloc]init];
            [ds setObject:[data objectForKey:@"PEAK_POWER"] forKey:@"PEAK_POWER"];
            [ds setObject:[data objectForKey:@"TIP_POWER"] forKey:@"TIP_POWER"];
            [ds setObject:[data objectForKey:@"VALLEY_POWER"] forKey:@"VALLEY_POWER"];
            [self.dataItemArray addObject:ds];
        }
        if(table2){
            NSDictionary *data=[table2 objectAtIndex:0];
            [headNumberArray addObject:[data objectForKey:@"REPORT_DAY"]];
            NSMutableDictionary *ds=[[NSMutableDictionary alloc]init];
            [ds setObject:[data objectForKey:@"PEAK_POWER"] forKey:@"PEAK_POWER"];
            [ds setObject:[data objectForKey:@"TIP_POWER"] forKey:@"TIP_POWER"];
            [ds setObject:[data objectForKey:@"VALLEY_POWER"] forKey:@"VALLEY_POWER"];
            [self.dataItemArray addObject:ds];
        }
        [self.tableView reloadData];
    }else if(reqCode==501){
        NSArray *table1=[[response resultJSON]objectForKey:@"table2"];
        NSArray *table2=[[response resultJSON]objectForKey:@"table3"];
        if(table1){
            NSDictionary *data=[table1 objectAtIndex:0];
            [headNumberArray addObject:[NSString stringWithFormat:@"%@月",[data objectForKey:@"REPORT_MONTH"]]];
            NSMutableDictionary *ds=[[NSMutableDictionary alloc]init];
            [ds setObject:[data objectForKey:@"PEAK_POWER"] forKey:@"PEAK_POWER"];
            [ds setObject:[data objectForKey:@"TIP_POWER"] forKey:@"TIP_POWER"];
            [ds setObject:[data objectForKey:@"VALLEY_POWER"] forKey:@"VALLEY_POWER"];
            [self.dataItemArray addObject:ds];
        }
        if(table2){
            NSDictionary *data=[table2 objectAtIndex:0];
            [headNumberArray addObject:[NSString stringWithFormat:@"%@月",[data objectForKey:@"REPORT_MONTH"]]];
            NSMutableDictionary *ds=[[NSMutableDictionary alloc]init];
            [ds setObject:[data objectForKey:@"PEAK_POWER"] forKey:@"PEAK_POWER"];
            [ds setObject:[data objectForKey:@"TIP_POWER"] forKey:@"TIP_POWER"];
            [ds setObject:[data objectForKey:@"VALLEY_POWER"] forKey:@"VALLEY_POWER"];
            [self.dataItemArray addObject:ds];
        }
        [self.tableView reloadData];
    }
}

- (void)switchType:(UIButton*)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"电量对比"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"按日", @"按月",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0){
        //按日
        type=1;
        [bSwitchType setTitle:@"按日" forState:UIControlStateNormal];
        [self loadHttp];
    }else if(buttonIndex==1){
        //按月
        type=2;
        [bSwitchType setTitle:@"按月" forState:UIControlStateNormal];
        [self loadHttp];
    }
}

@end