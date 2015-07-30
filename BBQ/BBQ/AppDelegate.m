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
//    UINavigationController *frameViewControllerNav=[[UINavigationController alloc]initWithRootViewController:[[ConnectViewController alloc]init]];
    self.window.rootViewController=[[ConnectViewController alloc]init];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.bleManager = [[TIBLECBStandand alloc]init];
    [self.bleManager controlSetup:1];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    [self.window makeKeyAndVisible];
    
    return YES;
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

@end