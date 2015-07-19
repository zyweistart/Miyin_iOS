//
//  MemberViewController.m
//  ZMCY
//
//  Created by Start on 15/7/19.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "MemberViewController.h"

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
        [bClose setFrame:CGRectMake1(10, 30, 30, 30)];
        [bClose setImage:[UIImage imageNamed:@"back_white"] forState:UIControlStateNormal];
        [bClose setImage:[UIImage imageNamed:@"back_black"] forState:UIControlStateHighlighted];
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
        [personalFrame addSubview:bHead];
        iUserNameImage=[[UIImageView alloc]initWithFrame:CGRectMake1(10, 0, 60, 60)];
        iUserNameImage.layer.cornerRadius=iUserNameImage.bounds.size.width/2;
        iUserNameImage.layer.masksToBounds = YES;
        [iUserNameImage setBackgroundColor:DEFAULTITLECOLOR(241)];
        [iUserNameImage setUserInteractionEnabled:YES];
//        [iUserNameImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editPortrait:)]];
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

@end
