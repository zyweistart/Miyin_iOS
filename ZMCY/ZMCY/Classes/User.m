//
//  User.m
//  DLS
//
//  Created by Start on 3/13/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "User.h"
#import "Common.h"

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

- (void)LoginSuccessWithUserName:(NSString*)u Password:(NSString*)p Data:(NSDictionary*) d
{
    [Common setCache:ACCOUNTUSERNAME data:u];
    [Common setCache:ACCOUNTPASSWORD data:p];
    [Common setCacheByBool:ISACCOUNTAUTOLOGIN data:YES];
    self.access_token=[NSString stringWithFormat:@"%@",[d objectForKey:@"access_token"]];
    self.resultData=[d objectForKey:@"userInfo"];
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

- (BOOL)isAutoLogin
{
    return [Common getCacheByBool:ISACCOUNTAUTOLOGIN];
}

- (BOOL)isLogin
{
    if(self.access_token==nil||[@"" isEqualToString:self.access_token]){
        return NO;
    }else{
        return YES;
    }
}

- (void)clear
{
    self.access_token=nil;
    self.resultData=nil;
    [Common setCache:ACCOUNTUSERNAME data:@""];
    [Common setCache:ACCOUNTPASSWORD data:@""];
    [Common setCacheByBool:ISACCOUNTAUTOLOGIN data:NO];
}

@end
