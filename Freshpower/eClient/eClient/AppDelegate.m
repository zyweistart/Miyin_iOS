//
//  AppDelegate.m
//  eClient
//
//  Created by Start on 3/20/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "AppDelegate.h"
#import "STGuideViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    if(ScreenHeight > 480){
        myDelegate.autoSizeScaleX = ScreenWidth/320;
        myDelegate.autoSizeScaleY = ScreenHeight/568;
    }else{
        myDelegate.autoSizeScaleX = 1.0;
        myDelegate.autoSizeScaleY = 1.0;
    }
    //显示系统托盘
    [application setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController=[[STGuideViewController alloc]init];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
