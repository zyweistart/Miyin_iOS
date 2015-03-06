//
//  EGOTableViewPullRefreshDemoViewController.h
//  EGOTableViewPullRefreshDemo
//
//  Created by Emre Berge Ergenekon on 9/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "PullTableView.h"

@interface BaseEGOTableViewPullRefreshViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate, PullTableViewDelegate>

@property (strong,nonatomic) PullTableView *tableView;
@property (strong,nonatomic) NSMutableArray *dataItemArray;

- (PullTableView *)buildTableViewWithView:(UIView*)view;

- (void)refreshTable;
- (void)loadMoreDataToTable;

@end
