//
//  User.h
//  DLS
//
//  Created by Start on 3/13/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property BOOL isLogin;
@property NSMutableDictionary *info;

+ (User *) Instance;

@end
