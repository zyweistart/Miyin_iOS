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
        [self.dataItemArray addObject:[[[User Instance]resultData]objectForKey:@"Name"]];
        [self.dataItemArray addObject:[[[User Instance]resultData]objectForKey:@"userName"]];
        [self.dataItemArray addObject:[[[User Instance]resultData]objectForKey:@"address1"]];
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
    }else{
        cell.textLabel.text = @"身份证";
    }
    cell.detailTextLabel.text=[NSString stringWithFormat:@"%@", [self.dataItemArray objectAtIndex:indexPath.row]];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

@end
