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

- (void)LoginSuccessWithUserName:(NSString*)u Password:(NSString*)p Data:(NSDictionary*) d
{
    [Common setCache:ACCOUNTUSERNAME data:u];
    [Common setCache:ACCOUNTPASSWORD data:p];
    [Common setCacheByBool:ISACCOUNTAUTOLOGIN data:YES];
    [Common setCache:ACCOUNTRESULTDATA data:d];
}

- (BOOL)isLogin
{
    if([Common getCacheByBool:ISACCOUNTAUTOLOGIN]){
        return YES;
    }else{
        return NO;
    }
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

- (NSDictionary*)getResultData
{
    NSDictionary *data=[Common getCache:ACCOUNTRESULTDATA];
    if(data){
        return data;
    }
    return nil;
}

- (BOOL)isAuth:(NSString*)name
{
    if([self isLogin]){
        NSDictionary *data=[self getResultData];
        if(data!=nil){
            NSMutableArray *ARR=[data objectForKey:@"Perm"];
            if(ARR!=nil){
                for(NSDictionary *d in ARR){
                    if([name isEqualToString:[d objectForKey:@"BP_CODE"]]){
                        return YES;
                    }
                }
            }
        }
    }
    return NO;
}

- (void)clear
{
    [Common setCache:ACCOUNTUSERNAME data:@""];
    [Common setCache:ACCOUNTPASSWORD data:@""];
    [Common setCacheByBool:ISACCOUNTAUTOLOGIN data:NO];
    [Common setCache:ACCOUNTRESULTDATA data:nil];
}

@end
