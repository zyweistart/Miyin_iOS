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

#define ACCOUNTCPNAMEDATA @"ACCOUNTCPNAMEDATA"
#define ACCOUNTCPNAMEIDDATA @"ACCOUNTCPNAMEIDDATA"
#define ACCOUNTROLETYPEDATA @"ACCOUNTROLETYPEDATA"

@interface User : NSObject

+ (User *) Instance;

- (void)LoginSuccessWithUserName:(NSString*)u Password:(NSString*)p Data:(NSMutableDictionary*) d;

- (BOOL)isLogin;
- (NSString*)getUserName;
- (NSString*)getPassword;

- (void)setCPName:(NSString*)name;
- (void)setCPNameId:(NSString*)nameId;
- (void)setRoleType:(NSString*)roleType;
- (NSString*)getCPName;
- (NSString*)getCPNameId;
- (NSString*)getRoleType;


- (NSMutableDictionary*)getResultData;
- (BOOL)isAuth:(NSString*)name;

- (void)clear;

@end
