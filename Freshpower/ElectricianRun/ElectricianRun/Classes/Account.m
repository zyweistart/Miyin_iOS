//
//  Account.m
//  ElectricianRun
//
//  Created by Start on 3/2/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "Account.h"
#import "NSString+Utils.h"

@implementation Account

+ (void)LoginSuccessWithUserName:(NSString*)u Password:(NSString*)p Data:(NSDictionary*) d
{
    [Common setCacheByBool:ISACCOUNTLOGIN data:YES];
    [Common setCache:ACCOUNTUSERNAME data:u];
    //转大写并用MD5签名
    [Common setCache:ACCOUNTPASSWORD data:[[p uppercaseString] md5]];
    [Common setCache:ACCOUNTRESULTDATA data:d];
}

+ (void)clear
{
    [Common setCacheByBool:ISACCOUNTLOGIN data:NO];
    [Common setCache:ACCOUNTUSERNAME data:@""];
    [Common setCache:ACCOUNTPASSWORD data:@""];
    [Common setCache:ACCOUNTRESULTDATA data:nil];
}

+ (BOOL)isLogin
{
    if([Common getCacheByBool:ISACCOUNTLOGIN]){
        return YES;
    }else{
        return NO;
    }
}

+ (NSString*)getUserName
{
    NSString *userName=[Common getCache:ACCOUNTUSERNAME];
    if(userName){
        return userName;
    }
    return @"";
}

+ (NSString*)getPassword
{
    NSString *passWord=[Common getCache:ACCOUNTPASSWORD];
    if(passWord){
        return passWord;
    }
    return @"";
}

+ (NSDictionary*)getResultData
{
    NSDictionary *data=[Common getCache:ACCOUNTRESULTDATA];
    if(data){
        return data;
    }
    return nil;
}

+ (BOOL)isAuth:(NSString*)name
{
    if([Account isLogin]){
        NSDictionary *data=[Account getResultData];
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

@end
