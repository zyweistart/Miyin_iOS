//
//  HomeViewController.h
//  DLS
//  首页
//  Created by Start on 3/2/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "BaseEGOTableViewPullRefreshViewController.h"

@interface HomeViewController : BaseEGOTableViewPullRefreshViewController

@property UIButton *button1;
@property UIButton *button2;
@property UIButton *button3;
@property UIButton *button4;

@property (strong,nonatomic) NSMutableArray *dataItemArray1;
@property (strong,nonatomic) NSMutableArray *dataItemArray2;
@property (strong,nonatomic) NSMutableArray *dataItemArray3;
@property (strong,nonatomic) NSMutableArray *dataItemArray4;

@end
