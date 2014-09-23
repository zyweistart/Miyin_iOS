//
//  STFeedbackViewController.h
//  ElectricianRun
//
//  Created by Start on 3/3/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STFeedbackViewController : BaseUIViewController<HttpRequestDelegate>

@property (strong,nonatomic) HttpRequest *hRequest;

@end
