//
//  AppDelegate.h
//  BBQ
//
//  Created by Start on 15/7/27.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TIBLECBStandand.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property float autoSizeScaleX;
@property float autoSizeScaleY;

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) TIBLECBStandand *bleManager;

@end

