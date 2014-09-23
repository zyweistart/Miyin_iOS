//
//  STViewUserListViewController.h
//  ElectricianRun
//
//  Created by Start on 3/4/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseMJRefreshViewController.h"
#import "STTaskAuditMapViewController.h"

@interface STViewUserListViewController : BaseMJRefreshViewController

@property (strong,nonatomic) STTaskAuditMapViewController<SearchDelegate> *delegate;

- (id)initWithTimeType:(int)type;

@end
