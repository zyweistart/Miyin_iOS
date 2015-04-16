//
//  InspectionManagerCell.h
//  eClient
//
//  Created by weizhenyao on 15/3/23.
//  Copyright (c) 2015年 freshpower. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResultDelegate.h"
#import "SVCheckbox.h"
#import "SVButton.h"

@interface InspectionManagerCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource,ResultDelegate,HttpViewDelegate>

@property (strong,nonatomic) HttpRequest *hRequest;

@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *dataItemArray;

@property SVButton *pSend;
@property SVButton *pSetting;

@property UILabel *lblName;

@property BaseViewController *controller;

- (void)setData:(NSMutableDictionary*)data;

@end
