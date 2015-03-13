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

+ (void)alert:(NSString*)message
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"信息"
                          message:message
                          delegate:nil
                          cancelButtonTitle:@"确定"
                          otherButtonTitles:nil, nil];
    [alert show];
}

+ (UIImage*)createImageWithColor:(UIColor*)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
