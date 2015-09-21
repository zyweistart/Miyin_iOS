//
//  AppDelegate.h
//  GrillNow2
//
//  Created by Yang Shubo on 14-12-28.
//  Copyright (c) 2014年 com.efancy. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UIBackgroundTaskIdentifier bgTask;
    
    NSUInteger counter;
}
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,assign) int isNot;
//@property(nonatomic,strong)NSMutableData *downLoadData;
@end
