//
//  STAggregatorEntInfoViewController.h
//  ElectricianRun
//
//  Created by Start on 2/21/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STAggregatorEntInfoViewController : UIViewController<HttpRequestDelegate>

@property (strong,nonatomic) NSString *SID;
@property (strong,nonatomic) HttpRequest *hRequest;

- (id)initWithSID:(NSString*)sid;

@end