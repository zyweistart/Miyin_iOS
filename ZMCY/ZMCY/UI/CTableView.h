//
//  CTableView.h
//  ZMCY
//
//  Created by Start on 15/7/21.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullTableView.h"
#import "Response.h"

#define PAGESIZE 8

@interface CTableView : UIView <UITableViewDataSource,UITableViewDelegate, PullTableViewDelegate>

@property BOOL isFirstRefresh;
@property NSInteger currentPage;
@property (strong,nonatomic) PullTableView *tableView;
@property (strong,nonatomic) NSMutableArray *dataItemArray;

- (void)refreshTable;
- (void)loadMoreDataToTable;
- (void)loadDone;
- (void)loadHttp;

@end
