//
//  STTaskManagerConsumptionViewController.h
//  ElectricianRun
//
//  Created by Start on 2/25/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STTaskManagerConsumptionViewController : UIViewController<HttpRequestDelegate>

@property (strong,nonatomic) HttpRequest *hRequest;

- (id)initWithData:(NSDictionary *)data taskId:(NSString *)taskId gnid:(NSString *)g type:(NSInteger)t;


- (void)reloadTableViewDataSource;

@end
