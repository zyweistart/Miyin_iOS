//
//  User.m
//  DLS
//
//  Created by Start on 3/13/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "User.h"

@implementation User

static User * instance = nil;
+ (User *) Instance {
    @synchronized(self){
        if(nil == instance){
            instance=[self new];
        }
    }
    return instance;
}

- (void)LoginSuccessWithUserName:(NSString*)u Password:(NSString*)p Data:(NSMutableDictionary*) d
{
    [Common setCache:ACCOUNTUSERNAME data:u];
    [Common setCache:ACCOUNTPASSWORD data:p];
    [Common setCacheByBool:ISACCOUNTAUTOLOGIN data:YES];
    self.accessToken=[d objectForKey:@"access_token"];
    self.resultData=[[NSMutableDictionary alloc]initWithDictionary:[d objectForKey:@"userInfo"]];
}

- (NSString*)getUserName
{
    NSString *userName=[Common getCache:ACCOUNTUSERNAME];
    if(userName){
        return userName;
    }
    return @"";
}

- (NSString*)getPassword
{
    NSString *passWord=[Common getCache:ACCOUNTPASSWORD];
    if(passWord){
        return passWord;
    }
    return @"";
}

- (BOOL)isLogin
{
    if(self.accessToken==nil||[@"" isEqualToString:self.accessToken]){
        return NO;
    }else{
        return YES;
    }
//    if([Common getCacheByBool:ISACCOUNTAUTOLOGIN]){
//        return YES;
//    }else{
//        return NO;
//    }
}

- (void)clear
{
    [Common setCache:ACCOUNTUSERNAME data:@""];
    [Common setCache:ACCOUNTPASSWORD data:@""];
    [Common setCacheByBool:ISACCOUNTAUTOLOGIN data:NO];
    self.accessToken=nil;
    self.resultData=nil;
}

@end
