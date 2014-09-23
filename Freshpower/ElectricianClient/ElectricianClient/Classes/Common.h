//
//  Common.h
//  ElectricianRun
//
//  Created by Start on 2/10/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Common : NSObject

+ (id)getCache:(NSString *)key;

+ (void)setCache:(NSString *)key data:(id)data;

+ (BOOL)getCacheByBool:(NSString *)key;

+ (void)setCacheByBool:(NSString *)key data:(BOOL)data;

+ (void)alert:(NSString *)message;

+ (void)actionSheet:(id<UIActionSheetDelegate>)delegate message:(NSString *)message tag:(NSInteger)tag;

+ (NSString *)NSNullConvertEmptyString:(id)value;

+ (void)AsynchronousDownloadWithUrl:(NSString *)u FileName:(NSString *)fName image:(UIImageView*)img;

+ (void)share:(UIViewController*)controller;

+ (BOOL)isValidateEmail:(NSString *)email;

+ (NSData *)toJSONData:(id)theData;

+ (NSString *)getRandom;

@end
