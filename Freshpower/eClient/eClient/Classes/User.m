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
            [instance setIsLogin:NO];
        }
    }
    return instance;
}

@end
