//
//  Common.m
//  DLS
//
//  Created by Start on 3/6/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "Common.h"

@implementation Common

+ (NSData *)toJSONData:(id)theData
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:NSJSONWritingPrettyPrinted error:&error];
    if ([jsonData length] > 0 && error == nil){
        return jsonData;
    }else{
        return nil;
    }
}

@end
