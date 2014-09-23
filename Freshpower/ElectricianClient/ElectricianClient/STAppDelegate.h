//
//  STAppDelegate.h
//  ElectricianClient
//
//  Created by Start on 3/24/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"

@interface STAppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
