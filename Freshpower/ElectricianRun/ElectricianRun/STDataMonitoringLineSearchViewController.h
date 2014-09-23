//
//  STDataMonitoringLineSearchViewController.h
//  ElectricianRun
//
//  Created by Start on 2/21/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STDataMonitoringLineViewController.h"

@interface STDataMonitoringLineSearchViewController : UIViewController<HttpRequestDelegate>

@property (strong,nonatomic) HttpRequest *hRequest;

@property (strong,nonatomic) NSDictionary *data;

- (void)reload;

@end
