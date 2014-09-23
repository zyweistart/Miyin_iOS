//
//  STTaskManagerHandleViewController.h
//  ElectricianRun
//
//  Created by Start on 2/25/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseMJRefreshViewController.h"

@interface STTaskManagerHandleViewController : BaseMJRefreshViewController<HttpRequestDelegate>


@property (strong,nonatomic) HttpRequest *hRequest;

- (id)initWithTaskId:(NSString *)taskId gnid:(NSString *)g type:(NSInteger)t;

@end
