//
//  STProjectSiteViewController.h
//  ElectricianRun
//
//  Created by Start on 1/24/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STProjectSiteViewController : BaseUIViewController<HttpRequestDelegate>

@property (strong,nonatomic) HttpRequest *hRequest;

@end
