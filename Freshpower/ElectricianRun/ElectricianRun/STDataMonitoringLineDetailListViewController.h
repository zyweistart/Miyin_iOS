//
//  STDataMonitoringLineDetailListViewController.h
//  ElectricianRun
//
//  Created by Start on 1/25/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseMJRefreshViewController.h"

@interface STDataMonitoringLineDetailListViewController : BaseMJRefreshViewController

- (id)initWithData:(NSDictionary *)d lastMonthSearch:(BOOL)flag;

@property (strong,nonatomic) NSString *startDay;
@property (strong,nonatomic) NSString *endDay;

@end