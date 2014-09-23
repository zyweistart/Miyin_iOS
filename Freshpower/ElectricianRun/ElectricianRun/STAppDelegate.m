//
//  STAppDelegate.m
//  ElectricianRun
//
//  Created by Start on 1/24/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STAppDelegate.h"
#import "STGuideViewController.h"
#import "STAlarmManagerViewController.h"

#define REQUESTCODEUPDATELOCATION 58374

@implementation STAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [WXApi registerApp:WEIXINREGISTERAPP];
    
    //让设备知道我们想要收到推送通知
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
    //显示ViewController
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController=[[STGuideViewController alloc]init];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //应用关闭的情况下接收到消息推送
    NSDictionary *aps = [[launchOptions objectForKey:@"UIApplicationLaunchOptionsRemoteNotificationKey"] objectForKey:@"aps"];
    [self notication:aps];
    
    return YES;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    //应用在后台或前台开启的状态下接收到消息推送
    [self notication:[userInfo objectForKey:@"aps"]];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    if([Common getCacheByBool:@"enabled_preference_gps"]){
        if(self.locationGetter==nil){
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"位置上传"
                                  message:@"应用每一分钟会上传你的位置信息至服务端该功能会耗费你一定的电量，是否继续?"
                                  delegate:self
                                  cancelButtonTitle:@"不在提醒"
                                  otherButtonTitles:@"继续", nil];
            alert.tag=2;
            [alert show];
        }
        if(self.updateLocationTimer==nil){
            self.updateLocationTimer = [NSTimer scheduledTimerWithTimeInterval:REFRESHNUM2 target:self selector:@selector(updateLocation) userInfo:nil repeats:YES];
        }
    }else{
        if(self.locationGetter!=nil){
            [self.locationGetter stopUpdates];
            self.locationGetter=nil;
        }
        if(self.updateLocationTimer!=nil){
            [self.updateLocationTimer invalidate];
            self.updateLocationTimer=nil;
        }
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    if([Common getCacheByBool:@"enabled_preference_gps"]){
//        BOOL backgroundAccepted = [[UIApplication sharedApplication] setKeepAliveTimeout:600 handler:^{
//            [self backgroundHandler];
//        }];
//        if (backgroundAccepted){
//          NSLog(@"backgrounding accepted");
//        }
        [self backgroundHandler];
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    //获取deviceToken需上传至服务端
    NSString *dt=[[deviceToken description] stringByReplacingOccurrencesOfString:@" " withString:@""];
    if([dt length]>2){
        [Common setCache:DEVICETOKEN data:[dt substringWithRange:NSMakeRange(1,[dt length]-2)]];
    }
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WXApi handleOpenURL:url delegate:self];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    if(self.locationGetter!=nil){
        [self.locationGetter stopUpdates];
        self.locationGetter=nil;
    }
}

- (void)updateLocation
{
    if(self.locationGetter!=nil){
        
        if(![HttpRequest isNetworkConnection]){
            return;
        }
        
        CLLocation *location=self.locationGetter.currentLocation;
        
        if(location){
            
            if([Account isLogin]){
                
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
                NSString *date=[formatter stringFromDate:[NSDate date]];
                
                NSMutableDictionary *p=[[NSMutableDictionary alloc]init];
                [p setObject:[Account getUserName] forKey:@"imei"];
                [p setObject:[Account getPassword] forKey:@"authentication"];
                [p setObject:[[NSNumber alloc]initWithDouble:fabs(self.locationGetter.currentLocation.coordinate.latitude)] forKey:@"latitude"];
                [p setObject:[[NSNumber alloc]initWithDouble:fabs(self.locationGetter.currentLocation.coordinate.longitude)] forKey:@"longitude"];
                [p setObject:[NSString stringWithFormat:@"%.2f",fabs(location.speed)] forKey:@"speed"];//为速度
                [p setObject:[NSString stringWithFormat:@"%.2f",fabs(location.course)] forKey:@"direction"];//为速度方向
                [p setObject:@"E" forKey:@"longitudeEW"];//为东西经,值为”E”或“W”,其中”E”代表东经，”W”代表西经
                [p setObject:@"N" forKey:@"latitudeNS"];//为南北纬，值为“N”或“S”,其中”N”代表北纬，”S”代表南纬
                [p setObject:date forKey:@"gpsTime"];//为GPS时间，URL编码处理后的数据
                [p setObject:[Common NSNullConvertEmptyString:[Common getCache:DEVICETOKEN]] forKey:@"key"];//为国际移动设备身份码
                
                self.hRequest=[[HttpRequest alloc]init:nil delegate:self responseCode:REQUESTCODEUPDATELOCATION];
                [self.hRequest setIsShowMessage:NO];
                [self.hRequest setIsReachableViaWiFiMessage:NO];
                [self.hRequest start:URLsendLocationInfo params:p];
//                NSString *content=[NSString stringWithFormat:@"latitude:%@,longitude:%@",[p objectForKey:@"latitude"],[p objectForKey:@"longitude"]];
//                NSLog(@"%@",content);
//                [Common writeFile:content];
            }
        }
    }
}

- (void)requestFinishedByResponse:(Response*)response responseCode:(int)repCode
{
    if(repCode==REQUESTCODEUPDATELOCATION){
    }
}

- (void)requestFailed:(int)repCode didFailWithError:(NSError *)error
{
    if(repCode==REQUESTCODEUPDATELOCATION){
    }
}

- (void)backgroundHandler {
    
    UIApplication *app = [UIApplication sharedApplication];
    __block UIBackgroundTaskIdentifier bgTask;
    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask != UIBackgroundTaskInvalid) {
                
                bgTask = UIBackgroundTaskInvalid;
            }
        });
    }];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask != UIBackgroundTaskInvalid) {
                bgTask = UIBackgroundTaskInvalid;
            }
        });
    });
    
}

- (void)notication:(NSDictionary*)aps
{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    if(aps!=nil){
        NSString *type=[aps objectForKey:@"type"];
        if([@"03" isEqualToString:type]||[@"04" isEqualToString:type]){
            NSString *title=@"功率因数报警消息";
            if([@"03" isEqualToString:type]){
                title=@"需量报警消息";
            }
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:title
                                  message:[aps objectForKey:@"alert"]
                                  delegate:nil
                                  cancelButtonTitle:@"确定"
                                  otherButtonTitles:nil, nil];
            alert.tag=1;
            [alert show];
        }else if([@"01" isEqualToString:type]||[@"02" isEqualToString:type]){
            //报警消息推送
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"报警消息"
                                  message:[aps objectForKey:@"alert"]
                                  delegate:self
                                  cancelButtonTitle:@"确定"
                                  otherButtonTitles:nil, nil];
            alert.tag=1;
            [alert show];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==1){
        if(buttonIndex==0){
//            [Common alert:@"请进入我管辖的变电站->报警管理查看详细信息"];
            if([Account isAuth:@"ELEC_ALARM"]){
                //报警管理
                STAlarmManagerViewController *alarmManagerViewController=[[STAlarmManagerViewController alloc]init];
                UINavigationController *alarmManagerViewControllerNav = [[UINavigationController alloc] initWithRootViewController:alarmManagerViewController];
                [self.window.rootViewController presentViewController:alarmManagerViewControllerNav animated:YES completion:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:Notification_TabClick_STAlarmManagerViewController object:@"load"];
            }
        }
    }else if(alertView.tag==2){
        if(buttonIndex==1){
            NSString *devicetoken=[Common getCache:DEVICETOKEN];
            if(devicetoken==nil||[@"" isEqualToString:devicetoken]){
                //随机产生一个唯一码
                [Common setCache:DEVICETOKEN data:[Common getRandom]];
            }
            self.locationGetter=[[LocationGetter alloc]init];
            [self.locationGetter startUpdates];
        }else if(buttonIndex==0){
            [Common alert:@"想重新开启可选择(设置->e电工运行版)把GPS选项勾选上"];
            [Common setCacheByBool:@"enabled_preference_gps" data:NO];
        }
    }
    
}

@end
