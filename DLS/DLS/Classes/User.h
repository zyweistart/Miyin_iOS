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

@interface User : NSObject

+ (User *) Instance;

- (void)LoginSuccessWithUserName:(NSString*)u Password:(NSString*)p Data:(NSMutableDictionary*) d;

@property (strong,nonatomic) NSString *accessToken;
@property (strong,nonatomic) NSMutableDictionary *resultData;

- (BOOL)isLogin;
- (NSString*)getUserName;
- (NSString*)getPassword;

- (void)clear;

@end
