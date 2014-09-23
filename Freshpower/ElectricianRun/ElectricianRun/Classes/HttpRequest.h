//
//  HttpRequest.h
//  ElectricianRun
//
//  Created by Start on 2/9/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Response.h"

@protocol HttpRequestDelegate

@optional
- (void)requestFinishedByResponse:(Response*)response responseCode:(int)repCode;
- (void)requestFailed:(int)repCode didFailWithError:(NSError *)error;

@end

@interface HttpRequest : NSObject<UIActionSheetDelegate,NSURLConnectionDataDelegate>

//请求编号
@property int responseCode;
//是否显示提示信息
@property BOOL isShowMessage;
//是否为文件下载
@property BOOL isFileDownload;
//是否使用移动网络提示
@property BOOL isReachableViaWiFiMessage;
@property BOOL isBodySubmit;
@property BOOL isShowNetConnectionMessage;
//请求时的提示信息
@property (strong,nonatomic) NSString *message;
//当前请求的控制器
@property (strong,nonatomic) UIViewController *controller;
//代理对象
@property (strong,nonatomic) NSObject<HttpRequestDelegate> *delegate;
@property (strong,nonatomic) NSMutableData *resultData;

//是否已连接网络
+ (BOOL)isNetworkConnection;

- (id)init:(UIViewController*)controler delegate:(NSObject<HttpRequestDelegate>*)delegate responseCode:(int)repCode;

- (void)start:(NSString*)URL params:(NSMutableDictionary*)p;

@end
