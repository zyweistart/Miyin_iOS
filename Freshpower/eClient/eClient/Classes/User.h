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
@property (strong,nonatomic) NSDictionary *info;
@property (strong,nonatomic) NSString *userName;
@property (strong,nonatomic) NSString *passWord;

+ (User *) Instance;

@end
