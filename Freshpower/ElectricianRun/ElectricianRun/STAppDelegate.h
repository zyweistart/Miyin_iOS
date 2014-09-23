//
//  STAppDelegate.h
//  ElectricianRun
//
//  Created by Start on 1/24/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"
#import "LocationGetter.h"

@interface STAppDelegate : UIResponder <UIApplicationDelegate,HttpRequestDelegate,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong,nonatomic) HttpRequest *hRequest;
@property (strong,nonatomic) LocationGetter *locationGetter;

@property NSTimer *updateLocationTimer;

@end
