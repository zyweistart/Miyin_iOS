//
//  AppDelegate.m
//  GrillNow2
//
//  Created by Yang Shubo on 14-12-28.
//  Copyright (c) 2014年 com.efancy. All rights reserved.
//

#import "AppDelegate.h"
#import "MainPageSecondViewController.h"
#import "MainPageFirstViewController.h"
#import "DeviceSelecterViewController.h"
#import "DeviceDetailViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    /*
    NSUserDefaults *usdf = [[NSUserDefaults alloc] init];
    [usdf setObject:@"6" forKey:@"isFirst"];
    [usdf synchronize];
    NSString *str = [usdf objectForKey:@"isFirst"];
    NSLog(@"dd--%@",str);
    // 获取今天的系统日期
    NSDate *senddate=[NSDate date];
    NSCalendar * cal=[NSCalendar currentCalendar];
    NSUInteger unitFlags=NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit;
    NSDateComponents * conponent= [cal components:unitFlags fromDate:senddate];
    NSInteger day=[conponent day];
    NSString *taday = [NSString stringWithFormat:@"%ld",(long)day];
    NSLog(@"sss-%@",taday);
    
    int t = [taday intValue] - [str intValue];
    
    if (t <= 3 && t>=0) {
     */
        DeviceSelecterViewController* rootController = [[DeviceSelecterViewController alloc] init];
        UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:rootController];
        self.window.rootViewController = navController;
    /*
        // 提示框
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示:" message:[NSString stringWithFormat:@"您还有%d天试用期",(3-t)] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [av show];
     */
        [self.window makeKeyAndVisible];
    /*
    } else
    {
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示:" message:@"您的app试用已结束，谢谢！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [av show];
    }
   */
    
    // 注册本地通知
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationSettings *noteSetting =[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound
                                                                                   categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:noteSetting];
    }
    
    
    [[UIApplication sharedApplication] setIdleTimerDisabled: YES];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.

}
- (void)backgroundHandler {
    
    NSLog(@"### -->backgroundinghandler");
    
    UIApplication* app = [UIApplication sharedApplication];
    
    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        
        [app endBackgroundTask:bgTask];
        
        bgTask = UIBackgroundTaskInvalid;
        
    }];
    
    // Start the long-running task
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        while (1) {
            
            NSLog(@"counter:%ld", (unsigned long)counter++);
            
            sleep(1);
            
        }
        
    });
    
}
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    BOOL backgroundAccepted = [[UIApplication sharedApplication] setKeepAliveTimeout:600 handler:^{ [self backgroundHandler]; }];
    
    if (backgroundAccepted)
        
    {
        
        NSLog(@"backgrounding accepted 进入后台");
        
    }
    
    [self backgroundHandler];
    
}

-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler
{
    //在非本App界面时收到本地消息，下拉消息会有快捷回复的按钮，点击按钮后调用的方法，根据identifier来判断点击的哪个按钮，notification为消息内容
    NSLog(@"%@----%@",identifier,notification);
    completionHandler();//处理完消息，最后一定要调用这个代码块
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
