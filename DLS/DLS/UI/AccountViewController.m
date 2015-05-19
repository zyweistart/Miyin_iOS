//
//  AccountViewController.m
//  DLS
//
//  Created by Start on 3/5/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "AccountViewController.h"
#import "LoginViewController.h"

@interface AccountViewController ()

@end

@implementation AccountViewController{
    NSString *content;
    NSInteger pvv1;
}

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"账号"];
        //返回
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]
                                               initWithTitle:@"返回"
                                               style:UIBarButtonItemStyleBordered
                                               target:self
                                               action:@selector(goBack:)];
        self.dataItemArray=[[NSMutableArray alloc]init];
        [self.dataItemArray addObject:[[[User Instance]resultData]objectForKey:@"userName"]];
        [self.dataItemArray addObject:[[[User Instance]resultData]objectForKey:@"Name"]];
        [self.dataItemArray addObject:[[[User Instance]resultData]objectForKey:@"shenfenzheng"]];
        [self.dataItemArray addObject:[[[User Instance]resultData]objectForKey:@"per_roles"]];
        [self buildTableViewWithView:self.view];
        
        self.pv1=[[SinglePickerView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-260, 320, 260) WithArray:[CommonData getRole]];
        [self.pv1 setCode:1];
        [self.pv1 setDelegate:self];
        [self.view addSubview:self.pv1];
    }
    return self;
}

- (void)loadTableData{
    [self.dataItemArray removeAllObjects];
    [self.dataItemArray addObject:[[[User Instance]resultData]objectForKey:@"userName"]];
    [self.dataItemArray addObject:[[[User Instance]resultData]objectForKey:@"Name"]];
    [self.dataItemArray addObject:[[[User Instance]resultData]objectForKey:@"shenfenzheng"]];
    [self.dataItemArray addObject:[[[User Instance]resultData]objectForKey:@"per_roles"]];
    [self.tableView reloadData];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    NSString *vContent=[self.dataItemArray objectAtIndex:indexPath.row];
    if([indexPath row]==0){
        cell.textLabel.text = @"用户名";
        cell.detailTextLabel.text=[NSString stringWithFormat:@"%@",vContent];
    }else if([indexPath row]==1){
        cell.textLabel.text = @"姓名";
        cell.detailTextLabel.text=[NSString stringWithFormat:@"%@",vContent];
    }else if([indexPath row]==2){
        cell.textLabel.text = @"身份证";
        cell.detailTextLabel.text=[NSString stringWithFormat:@"%@",vContent];
    }else{
        cell.textLabel.text = @"个人角色";
        NSString *role=[CommonData getValueArray:[CommonData getRole] Key:vContent];
        cell.detailTextLabel.text=[NSString stringWithFormat:@"%@",role];
    }
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row=[indexPath row];
    [self.pv1 setHidden:row==3?NO:YES];
    if(row==1){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"姓名" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert  setAlertViewStyle:UIAlertViewStylePlainTextInput];
        alert.tag=1;
        [alert show];
    }else if(row==2){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"身份证" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert  setAlertViewStyle:UIAlertViewStylePlainTextInput];
        alert.tag=2;
        [alert show];
    }else if(row==3){
//        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"个人角色" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [alert  setAlertViewStyle:UIAlertViewStylePlainTextInput];
//        alert.tag=3;
//        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSUInteger tag=[alertView tag];
    if(buttonIndex==1){
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        [params setObject:[[User Instance]accessToken] forKey:@"access_token"];
        self.hRequest=[[HttpRequest alloc]init];
        content=[[alertView textFieldAtIndex:0] text];
        if([@"" isEqualToString:content]){
            return;
        }
        if(tag==1){
            //姓名
            [params setObject:content forKey:@"Name"];
            [self.hRequest setRequestCode:500];
        }else if(tag==2){
            //身份证
            [params setObject:content forKey:@"shenfenzheng"];
            [self.hRequest setRequestCode:501];
        }else if(tag==3){
            //个人角色
            [params setObject:content forKey:@"per_roles"];
            [self.hRequest setRequestCode:502];
        }
        [self.hRequest setDelegate:self];
        [self.hRequest setController:self];
        [self.hRequest setIsShowMessage:YES];
        [self.hRequest handle:@"UpdateUser" requestParams:params];
    }
    
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if([response successFlag]){
        if(reqCode==500){
            [[[User Instance]resultData] setObject:content forKey:@"Name"];
        }else if(reqCode==501){
            [[[User Instance]resultData] setObject:content forKey:@"shenfenzheng"];
        }else if(reqCode==502){
            [[[User Instance]resultData] setObject:content forKey:@"per_roles"];
        }
        [self loadTableData];
    }
}

- (void)pickerViewDone:(int)code
{
    if(code==1){
        pvv1=[self.pv1.picker selectedRowInComponent:0];
        NSDictionary *d=[self.pv1.pickerArray objectAtIndex:pvv1];
        content=[d objectForKey:MVALUE];
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        [params setObject:[[User Instance]accessToken] forKey:@"access_token"];
        [params setObject:content forKey:@"per_roles"];
        self.hRequest=[[HttpRequest alloc]init];
        [self.hRequest setRequestCode:502];
        [self.hRequest setDelegate:self];
        [self.hRequest setController:self];
        [self.hRequest setIsShowMessage:YES];
        [self.hRequest handle:@"UpdateUser" requestParams:params];
    }
}

@end