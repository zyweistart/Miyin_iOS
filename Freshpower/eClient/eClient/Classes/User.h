//
//  User.h
//  DLS
//
//  Created by Start on 3/13/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import <Foundation/Foundation.h>
#define ACCOUNTUSERNAME @"ACCOUNTUSERNAME"
#define ACCOUNTPASSWORD @"ACCOUNTPASSWORD"
#define ISACCOUNTAUTOLOGIN @"ISACCOUNTLOGIN"
#define ACCOUNTRESULTDATA @"ACCOUNTRESULTDATA"

@interface User : NSObject

+ (User *) Instance;

- (void)LoginSuccessWithUserName:(NSString*)u Password:(NSString*)p Data:(NSMutableDictionary*) d;

- (BOOL)isLogin;
- (NSString*)getUserName;
- (NSString*)getPassword;
- (NSMutableDictionary*)getResultData;
- (BOOL)isAuth:(NSString*)name;

- (void)clear;

@end
