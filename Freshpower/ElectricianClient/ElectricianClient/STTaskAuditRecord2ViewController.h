//
//  STTaskAuditRecord2ViewController.h
//  ElectricianRun
//
//  Created by Start on 2/20/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseMJRefreshViewController.h"

@interface STTaskAuditRecord2ViewController : BaseMJRefreshViewController<HttpRequestDelegate>

- (id)initWithData:(NSDictionary *)data type:(NSInteger)t;

@property (strong,nonatomic) HttpRequest *hRequest;

@end
