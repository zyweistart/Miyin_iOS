//
//  NSString+Utils.m
//  ElectricianRun
//
//  Created by Start on 2/9/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "NSString+Utils.h"

#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Utils)


- (NSString*)md5{
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

@end
