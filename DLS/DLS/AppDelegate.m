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

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //显示系统托盘
    [application setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    HomeViewController *homeViewController =[[HomeViewController alloc]init];
    [[homeViewController tabBarItem] setImage:[[UIImage imageNamed:@"ic_home_n"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[homeViewController tabBarItem] setSelectedImage:[[UIImage imageNamed:@"ic_home_p"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[homeViewController tabBarItem] setTitleTextAttributes:[NSDictionary
                                                              dictionaryWithObjectsAndKeys: TAB_N_TEXTCOLOR,
                                                              NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [[homeViewController tabBarItem] setTitleTextAttributes:[NSDictionary
                                                              dictionaryWithObjectsAndKeys: TAB_P_TEXTCOLOR,
                                                              NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [[homeViewController tabBarItem]setTitle:@"首页"];
    UINavigationController *nearbyViewControllerNav = [[UINavigationController alloc] initWithRootViewController:[[NearbyViewController alloc]init]];
    [[nearbyViewControllerNav tabBarItem] setImage:[[UIImage imageNamed:@"ic_nearby_n"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[nearbyViewControllerNav tabBarItem] setSelectedImage:[[UIImage imageNamed:@"ic_nearby_p"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[nearbyViewControllerNav tabBarItem] setTitleTextAttributes:[NSDictionary
                                                              dictionaryWithObjectsAndKeys: TAB_N_TEXTCOLOR,
                                                              NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [[nearbyViewControllerNav tabBarItem] setTitleTextAttributes:[NSDictionary
                                                              dictionaryWithObjectsAndKeys: TAB_P_TEXTCOLOR,
                                                              NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [[nearbyViewControllerNav tabBarItem]setTitle:@"附近"];
    UINavigationController *vipViewControllerNav = [[UINavigationController alloc] initWithRootViewController:[[VIPViewController alloc]init]];
    [[vipViewControllerNav tabBarItem] setImage:[[UIImage imageNamed:@"ic_vip_n"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[vipViewControllerNav tabBarItem] setSelectedImage:[[UIImage imageNamed:@"ic_vip_p"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[vipViewControllerNav tabBarItem] setTitleTextAttributes:[NSDictionary
                                                              dictionaryWithObjectsAndKeys: TAB_N_TEXTCOLOR,
                                                              NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [[vipViewControllerNav tabBarItem] setTitleTextAttributes:[NSDictionary
                                                              dictionaryWithObjectsAndKeys: TAB_P_TEXTCOLOR,
                                                              NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    [[vipViewControllerNav tabBarItem]setTitle:@"VIP"];
    UINavigationController *myViewControllerNav = [[UINavigationController alloc] initWithRootViewController:[[MyViewController alloc]init]];
    [[myViewControllerNav tabBarItem] setImage:[[UIImage imageNamed:@"ic_my_n"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[myViewControllerNav tabBarItem] setSelectedImage:[[UIImage imageNamed:@"ic_my_p"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[myViewControllerNav tabBarItem] setTitleTextAttributes:[NSDictionary
                                                                dictionaryWithObjectsAndKeys: TAB_N_TEXTCOLOR,
                                                                NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [[myViewControllerNav tabBarItem] setTitleTextAttributes:[NSDictionary
                                                                dictionaryWithObjectsAndKeys: TAB_P_TEXTCOLOR,
                                                              NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [[myViewControllerNav tabBarItem]setTitle:@"我的"];
    
    
    UITabBarController *_tabBarController = [[UITabBarController alloc] init];
    [[_tabBarController tabBar] setBackgroundImage:[[UIImage alloc] init]];
//    _tabBarController.delegate = self;
    _tabBarController.viewControllers = [NSArray arrayWithObjects:
                                         homeViewController,
                                         nearbyViewControllerNav,
                                         vipViewControllerNav,
                                         myViewControllerNav,
                                         nil];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//    [[UINavigationBar appearance] setBarTintColor:[UIColor orangeColor]];
//    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    self.window.rootViewController=_tabBarController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
