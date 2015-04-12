//
//  Common.h
//  DLS
//
//  Created by Start on 3/6/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Common : NSObject

+ (id)getCache:(NSString *)key;

+ (void)setCache:(NSString *)key data:(id)data;

+ (BOOL)getCacheByBool:(NSString *)key;

+ (void)setCacheByBool:(NSString *)key data:(BOOL)data;

+ (NSData *)toJSONData:(id)theData;

+ (void)alert:(NSString*)message;

+ (UIImage*)createImageWithColor:(UIColor*)color;

@end
