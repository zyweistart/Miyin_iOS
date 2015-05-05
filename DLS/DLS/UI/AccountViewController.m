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

@implementation AccountViewController

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
    }
    return self;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    if([indexPath row]==0){
        cell.textLabel.text = @"用户名";
    }else if([indexPath row]==1){
        cell.textLabel.text = @"姓名";
    }else if([indexPath row]==2){
        cell.textLabel.text = @"身份证";
    }else{
        cell.textLabel.text = @"个人角色";
    }
    cell.detailTextLabel.text=[NSString stringWithFormat:@"%@", [self.dataItemArray objectAtIndex:indexPath.row]];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row=[indexPath row];
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
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"个人角色" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert  setAlertViewStyle:UIAlertViewStylePlainTextInput];
        alert.tag=3;
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSUInteger tag=[alertView tag];
    if(buttonIndex==1){
        NSString *content=[[alertView textFieldAtIndex:0] text];
        if([@"" isEqualToString:content]){
            return;
        }
        if(tag==1){
            //姓名
            
        }else if(tag==2){
            //身份证
            
        }else if(tag==3){
            //个人角色
            
        }
    }
    
}

@end
