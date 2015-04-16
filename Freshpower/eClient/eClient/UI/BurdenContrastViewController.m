//
//  BurdenContrastViewController.m
//  eClient
//
//  Created by Start on 4/15/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "BurdenContrastViewController.h"

@interface BurdenContrastViewController ()

@end

@implementation BurdenContrastViewController{
    UIButton *bSwitchType;
    int type;
}

- (id)init
{
    self=[super init];
    if(self){
        [self setTitle:@"企业负荷"];
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
        [headView setImage:[UIImage imageNamed:@"burdenbanner"]];
        [self.tableView setTableHeaderView:headView];
    }
    return self;
}

- (void)switchType:(UIButton*)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"查询"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"按日",@"按周", @"按月",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0){
        //按日
        type=1;
        [bSwitchType setTitle:@"按日" forState:UIControlStateNormal];
    }else if(buttonIndex==1){
        //按周
        type=2;
        [bSwitchType setTitle:@"按周" forState:UIControlStateNormal];
    }else if(buttonIndex==2){
        //按月
        type=3;
        [bSwitchType setTitle:@"按月" forState:UIControlStateNormal];
    }
}

@end
