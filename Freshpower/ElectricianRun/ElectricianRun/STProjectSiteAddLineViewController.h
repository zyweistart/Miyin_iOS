//
//  STProjectSiteAddLineViewController.h
//  ElectricianRun
//
//  Created by Start on 2/25/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STProjectSiteAddLineViewController : UIViewController<HttpRequestDelegate>

- (id)initWithData:(NSDictionary *)data;

@property (strong,nonatomic) HttpRequest *hRequest;

@end
