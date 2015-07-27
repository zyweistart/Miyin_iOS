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

- (void)LoginSuccessWithUserName:(NSString*)u Password:(NSString*)p Data:(NSDictionary*) d;

@property (strong,nonatomic) NSString *sex;
@property (strong,nonatomic) NSString *phone;
@property (strong,nonatomic) NSString *pwd;
@property (strong,nonatomic) NSString *nickName;
@property (strong,nonatomic) UIImage *head;
@property (strong,nonatomic) NSString *access_token;
@property (strong,nonatomic) NSString *recordmode;
@property (strong,nonatomic) NSDictionary *resultData;

- (NSString*)getUserName;
- (NSString*)getPassword;
- (BOOL)isAutoLogin;

- (BOOL)isLogin;
- (void)clear;

@end
