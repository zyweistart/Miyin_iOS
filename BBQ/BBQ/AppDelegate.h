//
//  AppDelegate.h
//  BBQ
//
//  Created by Start on 15/7/27.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TIBLECBStandand.h"
#import <AVFoundation/AVFoundation.h>

typedef struct _CHAR{
    char buff[1000];
}CHAR_STRUCT;

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    UIBackgroundTaskIdentifier bgTask;
}

@property float autoSizeScaleX;
@property float autoSizeScaleY;

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) TIBLECBStandand *bleManager;

- (void)sendData:(NSString*)message;

@end

