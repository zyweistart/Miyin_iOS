//
//  HomeInformationCell.h
//  DLS
//
//  Created by Start on 3/4/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeInformationCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource>

@property UIButton *button1;
@property UIButton *button2;
@property UIButton *button3;
@property UIButton *button4;

@property UIRefreshControl *refreshControl1;
@property UIRefreshControl *refreshControl2;
@property UIRefreshControl *refreshControl3;
@property UIRefreshControl *refreshControl4;

@property UITableView *tableView1;
@property UITableView *tableView2;
@property UITableView *tableView3;
@property UITableView *tableView4;

@property (strong,nonatomic) NSMutableArray *dataItemArray1;
@property (strong,nonatomic) NSMutableArray *dataItemArray2;
@property (strong,nonatomic) NSMutableArray *dataItemArray3;
@property (strong,nonatomic) NSMutableArray *dataItemArray4;

@end
