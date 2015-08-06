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

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]) {
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }
    application.applicationIconBadgeNumber = 0;
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
//    //让app支持接受远程控制事件后台播放音乐
//    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    self.bleManager = [[TIBLECBStandand alloc]init];
    [self.bleManager controlSetup:1];
    
    AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if(ScreenHeight > 480){
        myDelegate.autoSizeScaleX = ScreenWidth/320;
        myDelegate.autoSizeScaleY = ScreenHeight/568;
    }else{
        myDelegate.autoSizeScaleX = 1.0;
        myDelegate.autoSizeScaleY = 1.0;
    }
    //默认为前台
    self.isApplicationBackground=YES;
    [application setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance]setBarTintColor:NAVBG];
    [[UINavigationBar appearance]setBarStyle:UIBarStyleBlackTranslucent];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UINavigationController *frameViewControllerNav=[[UINavigationController alloc]initWithRootViewController:[[ConnectViewController alloc]init]];
    self.window.rootViewController=frameViewControllerNav;
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    application.applicationIconBadgeNumber = 0;
    NSDictionary *ui=notification.userInfo;
    if([@"alarm" isEqualToString:[ui objectForKey:@"type"]]){
        if([[Data Instance]mTabBarFrameViewController]){
            [[[Data Instance]mTabBarFrameViewController]playAlarm];
        }
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    application.applicationIconBadgeNumber = 0;
}

- (void)sendData:(NSString*)message
{
    if([[Data Instance]isDemo]){
        return;
    }
    message=[NSString stringWithFormat:@"%@\r\n",message];
    int length = (int)message.length;
    Byte messageByte[length];
    for (int index = 0; index < length; index++) {
        //生成和字符串长度相同的字节数据
        messageByte[index] = 0x00;
    }
    NSString *tmpString;
    for(int index = 0; index<length ; index++) {
        tmpString = [message substringWithRange:NSMakeRange(index, 1)];
        if([tmpString isEqualToString:@" "]) {
            messageByte[index] = 0x20;
        } else {
            sscanf([tmpString cStringUsingEncoding:NSASCIIStringEncoding],"%c",&messageByte[index]);
        }
    }
    char lengthChar = 0 ;
    int  p = 0 ;
    //蓝牙数据通道 可写入的数据为20个字节
    while (length>0) {
        if (length>20) {
            lengthChar = 20 ;
        } else if (length>0){
            lengthChar = length;
        } else {
            return;
        }
        NSData *data = [[NSData alloc]initWithBytes:&messageByte[p] length:lengthChar];
//        NSLog(@" data %@",data);
        [self.bleManager writeValue:0xFFE5 characteristicUUID:0xFFE9 p:self.bleManager.activePeripheral data:data];
        length -= lengthChar ;
        p += lengthChar;
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // 进入后台
    self.isApplicationBackground=NO;
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // 回到前台
    self.isApplicationBackground=YES;
}

//- (void)applicationDidEnterBackground:(UIApplication *)application
//{
//    BOOL backgroundAccepted = [[UIApplication sharedApplication] setKeepAliveTimeout:600 handler:^{
//        [self backgroundHandler];
//    }];
//    if (backgroundAccepted) {
//    }
//    [self backgroundHandler];
//}
//
//- (void)backgroundHandler {
//    UIApplication* app = [UIApplication sharedApplication];
//    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
//        [app endBackgroundTask:bgTask];
//        bgTask = UIBackgroundTaskInvalid;
//    }];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        while (1) {
//            sleep(1);
//        }
//    });
//}

@end