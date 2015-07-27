//
//  MemberViewController.m
//  ZMCY
//
//  Created by Start on 15/7/19.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "MemberViewController.h"
#import "FollowViewController.h"
#import "CollectionViewController.h"
#import "LoginViewController.h"
#import "SettingViewController.h"

static CGFloat kImageOriginHight = 220.f;

@interface MemberViewController ()

@end

@implementation MemberViewController{
    UIView *bHead;
    UIView *personalFrame;
    UILabel *lblUserName;
    UIImageView *iUserNameImage;
}

- (id)init
{
    self=[super init];
    if(self){
        [self cTitle:@"会员"];
        [self.dataItemArray addObject:@"签到"];
        [self.dataItemArray addObject:@"收藏"];
        [self.dataItemArray addObject:@"关注"];
        [self.dataItemArray addObject:@"设置"];
        //
        UIButton *bClose = [[UIButton alloc]init];
        [bClose setFrame:CGRectMake1(10, 30, 60, 30)];
        [bClose setImage:[UIImage imageNamed:@"back_white"] forState:UIControlStateNormal];
        [bClose setImage:[UIImage imageNamed:@"back_black"] forState:UIControlStateHighlighted];
        [bClose setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [bClose addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
        [self buildTableViewWithView:self.view];
        self.expandZoomImageView=[[UIImageView alloc]initWithFrame:CGRectMake1(0, 0, 320, kImageOriginHight)];
        [self.expandZoomImageView setImage:[UIImage imageNamed:@"personalbg"]];
        [self.expandZoomImageView setUserInteractionEnabled:YES];
        [self.expandZoomImageView addSubview:bClose];
        self.tableView.contentInset = UIEdgeInsetsMake(CGHeight(kImageOriginHight), 0, 0, 0);
        [self.tableView addSubview:self.expandZoomImageView];
        
        personalFrame=[[UIView alloc]initWithFrame:CGRectMake1(0, kImageOriginHight-170, 320, 160)];
        [self.expandZoomImageView addSubview:personalFrame];
        //头像
        bHead=[[UIView alloc]initWithFrame:CGRectMake1(120, 20, 80, 90)];
        [bHead setUserInteractionEnabled:YES];
        [bHead addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goLogin:)]];
        [personalFrame addSubview:bHead];
        iUserNameImage=[[UIImageView alloc]initWithFrame:CGRectMake1(10, 0, 60, 60)];
        iUserNameImage.layer.cornerRadius=iUserNameImage.bounds.size.width/2;
        iUserNameImage.layer.masksToBounds = YES;
        [iUserNameImage setBackgroundColor:DEFAULTITLECOLOR(241)];
        [iUserNameImage setUserInteractionEnabled:YES];
        [bHead addSubview:iUserNameImage];
        lblUserName=[[UILabel alloc]initWithFrame:CGRectMake1(0, 70,80,20)];
        [lblUserName setFont:[UIFont systemFontOfSize:14]];
        [lblUserName setTextColor:[UIColor whiteColor]];
        [lblUserName setTextAlignment:NSTextAlignmentCenter];
        [lblUserName setUserInteractionEnabled:YES];
        [lblUserName setText:@"点击登陆"];
        [bHead addSubview:lblUserName];
        //底部功能
        UIView *bottomFrame=[[UIView alloc]initWithFrame:CGRectMake1(40, 140, 240, 20)];
        [personalFrame addSubview:bottomFrame];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.expandZoomImageView.frame = CGRectMake(0, -CGHeight(kImageOriginHight), self.tableView.frame.size.width, CGHeight(kImageOriginHight));
    [self loginStatus];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat yOffset  = scrollView.contentOffset.y;
    if (yOffset < -CGHeight(kImageOriginHight)) {
        CGRect f = self.expandZoomImageView.frame;
        f.origin.y = yOffset;
        f.size.height =  -yOffset;
        self.expandZoomImageView.frame = f;
        [personalFrame setFrame:CGRectMake(0, f.size.height-CGHeight(170), CGWidth(320), CGHeight(160))];
    }
}

- (void)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"SAMPLECell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSString *text=[self.dataItemArray objectAtIndex:[indexPath row]];
    cell.textLabel.text = text;
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row=[indexPath row];
    if(row==0){
        if([[User Instance]isLogin]){
            NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
            [params setObject:[[User Instance]access_token] forKey:@"access_token"];
            self.hRequest=[[HttpRequest alloc]init];
            [self.hRequest setDelegate:self];
            [self.hRequest setController:self];
            [self.hRequest setRequestCode:500];
            [self.hRequest handle:@"UserSingIn" requestParams:params];
        }else{
            [self.navigationController pushViewController:[[LoginViewController alloc]init] animated:YES];
        }
    }else if(row==1){
        if([[User Instance]isLogin]){
            [self.navigationController pushViewController:[[CollectionViewController alloc]init] animated:YES];
        }else{
            [self.navigationController pushViewController:[[LoginViewController alloc]init] animated:YES];
        }
    }else if(row==2){
        if([[User Instance]isLogin]){
            [self.navigationController pushViewController:[[FollowViewController alloc]init] animated:YES];
        }else{
            [self.navigationController pushViewController:[[LoginViewController alloc]init] animated:YES];
        }
    }else if(row==3){
        if([[User Instance]isLogin]){
            [self.navigationController pushViewController:[[SettingViewController alloc]init] animated:YES];
        }else{
            [self.navigationController pushViewController:[[LoginViewController alloc]init] animated:YES];
        }
    }
}

- (void)goLogin:(id)sender
{
    if([[User Instance]isLogin]){
        [[User Instance]clear];
        [self loginStatus];
    }else{
        [self.navigationController pushViewController:[[LoginViewController alloc]init] animated:YES];
    }
}

- (void)loginStatus
{
    if([[User Instance]isLogin]){
        [lblUserName setText:@"退出登陆"];
    }else{
        [lblUserName setText:@"点击登陆"];
    }
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if([response successFlag]){
        if(reqCode==500){
            NSLog(@"%@",[response responseString]);
        }
    }
}

@end
