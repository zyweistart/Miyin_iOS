//
//  STTaskAuditBuildDetailViewController.h
//  ElectricianRun
//
//  Created by Start on 2/20/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STTaskAuditBuildDetailViewController : UIViewController<HttpRequestDelegate>

@property (strong,nonatomic) NSString *cpId;
@property (strong,nonatomic) NSString *contractId;
@property (strong,nonatomic) NSString *siteId;

@property (strong,nonatomic) HttpRequest *hRequest;

- (void)reloadUser;
- (void)reloadModel;

@end
