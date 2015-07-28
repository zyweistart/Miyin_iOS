//
//  AppDelegate.m
//  BBQ
//
//  Created by Start on 15/7/27.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "AppDelegate.h"
#import "ConnectViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //计算各屏幕XY大小
    AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if(ScreenHeight > 480){
        myDelegate.autoSizeScaleX = ScreenWidth/320;
        myDelegate.autoSizeScaleY = ScreenHeight/568;
    }else{
        myDelegate.autoSizeScaleX = 1.0;
        myDelegate.autoSizeScaleY = 1.0;
    }
    //状态栏
    [application setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance]setBarTintColor:NAVBG];
    [[UINavigationBar appearance]setBarStyle:UIBarStyleBlackTranslucent];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UINavigationController *frameViewControllerNav=[[UINavigationController alloc]initWithRootViewController:[[ConnectViewController alloc]init]];
    self.window.rootViewController=frameViewControllerNav;
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.bleManager = [[TIBLECBStandand alloc]init];
    [self.bleManager controlSetup:1];
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end