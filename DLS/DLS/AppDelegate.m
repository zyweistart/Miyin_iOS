//
//  AppDelegate.m
//  DLS
//
//  Created by Start on 3/2/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "NearbyViewController.h"
#import "VIPViewController.h"
#import "MyViewController.h"

#define TAB_N_TEXTCOLOR [UIColor colorWithRed:(99/255.0) green:(111/255.0) blue:(125/255.0) alpha:1]
#define TAB_P_TEXTCOLOR [UIColor colorWithRed:(46/255.0) green:(92/255.0) blue:(178/255.0) alpha:1]

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
    
    UINavigationController *homeViewControllerNav = [[UINavigationController alloc] initWithRootViewController:[[HomeViewController alloc]init]];
    [[homeViewControllerNav tabBarItem] setImage:[[UIImage imageNamed:@"ic_home_n"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[homeViewControllerNav tabBarItem] setSelectedImage:[[UIImage imageNamed:@"ic_home_p"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[homeViewControllerNav tabBarItem] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: TAB_N_TEXTCOLOR,NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [[homeViewControllerNav tabBarItem] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: TAB_P_TEXTCOLOR,NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [[homeViewControllerNav tabBarItem]setTitle:@"首页"];
    [[homeViewControllerNav navigationBar]setBarTintColor:NAVBG];
    [[homeViewControllerNav navigationBar]setBarStyle:UIBarStyleBlackTranslucent];
    UINavigationController *nearbyViewControllerNav = [[UINavigationController alloc] initWithRootViewController:[[NearbyViewController alloc]init]];
    [[nearbyViewControllerNav tabBarItem] setImage:[[UIImage imageNamed:@"ic_nearby_n"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[nearbyViewControllerNav tabBarItem] setSelectedImage:[[UIImage imageNamed:@"ic_nearby_p"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[nearbyViewControllerNav tabBarItem] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: TAB_N_TEXTCOLOR,NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [[nearbyViewControllerNav tabBarItem] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: TAB_P_TEXTCOLOR,NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [[nearbyViewControllerNav tabBarItem]setTitle:@"附近"];
    [[nearbyViewControllerNav navigationBar]setBarTintColor:NAVBG];
    [[nearbyViewControllerNav navigationBar]setBarStyle:UIBarStyleBlackTranslucent];
    UINavigationController *vipViewControllerNav = [[UINavigationController alloc] initWithRootViewController:[[VIPViewController alloc]init]];
    [[vipViewControllerNav tabBarItem] setImage:[[UIImage imageNamed:@"ic_vip_n"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[vipViewControllerNav tabBarItem] setSelectedImage:[[UIImage imageNamed:@"ic_vip_p"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[vipViewControllerNav tabBarItem] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: TAB_N_TEXTCOLOR,NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [[vipViewControllerNav tabBarItem] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: TAB_P_TEXTCOLOR,NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [[vipViewControllerNav tabBarItem]setTitle:@"VIP"];
    [[vipViewControllerNav navigationBar]setBarTintColor:NAVBG];
    [[vipViewControllerNav navigationBar]setBarStyle:UIBarStyleBlackTranslucent];
//    UINavigationController *myViewControllerNav = [[UINavigationController alloc] initWithRootViewController:[[MyViewController alloc]init]];
    MyViewController *myViewControllerNav=[[MyViewController alloc]init];
    [[myViewControllerNav tabBarItem] setImage:[[UIImage imageNamed:@"ic_my_n"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[myViewControllerNav tabBarItem] setSelectedImage:[[UIImage imageNamed:@"ic_my_p"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[myViewControllerNav tabBarItem] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: TAB_N_TEXTCOLOR,NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [[myViewControllerNav tabBarItem] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: TAB_P_TEXTCOLOR,NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [[myViewControllerNav tabBarItem]setTitle:@"我的"];
//    [[myViewControllerNav navigationBar]setBarTintColor:NAVBG];
//    [[myViewControllerNav navigationBar]setBarStyle:UIBarStyleBlackTranslucent];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    UITabBarController *_tabBarController = [[UITabBarController alloc] init];
    [[_tabBarController tabBar] setBackgroundImage:[[UIImage alloc] init]];
//    _tabBarController.delegate = self;
    _tabBarController.viewControllers = [NSArray arrayWithObjects:
                                         homeViewControllerNav,
                                         nearbyViewControllerNav,
                                         vipViewControllerNav,
                                         myViewControllerNav,
                                         nil];
    
    self.window.rootViewController=_tabBarController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
