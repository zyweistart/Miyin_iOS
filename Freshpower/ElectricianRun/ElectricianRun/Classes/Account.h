//
//  Account.h
//  ElectricianRun
//
//  Created by Start on 3/2/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Common.h"

@interface Account : NSObject

+ (void)LoginSuccessWithUserName:(NSString*)u Password:(NSString*)p Data:(NSDictionary*) d;

+ (void)clear;

+ (BOOL)isLogin;

+ (NSString*)getUserName;

+ (NSString*)getPassword;

+ (NSDictionary*)getResultData;

+ (BOOL)isAuth:(NSString*)name;

@end
