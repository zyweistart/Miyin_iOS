//
//  Common.h
//  DLS
//
//  Created by Start on 3/6/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Common : NSObject

+ (NSData *)toJSONData:(id)theData;

+ (void)alert:(NSString*)message;

+ (UIImage*)createImageWithColor:(UIColor*)color;

@end
