//
//  Tools.m
//  BLECollection
//
//  Created by rfstar on 13-12-24.
//  Copyright (c) 2013年 rfstar. All rights reserved.
//

#import "Tools.h"

@implementation Tools

+(UIDeviceResolution)currentResolution
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        if ([[UIScreen mainScreen] respondsToSelector: @selector(scale)]) {
            CGSize result = [[UIScreen mainScreen] bounds].size;
//            NSLog(@" size height :  %f",result.height);
            result = CGSizeMake(result.width * [UIScreen mainScreen].scale, result.height * [UIScreen mainScreen].scale);
//                 NSLog(@" size height :  %f",result.height);
            if(result.height == 480)
            {
                return UIDevice_iPhone3G;
            }else if(result.height == 960){
                return UIDevice_iPhone4s;
            }else if(result.height == 1136){
                return UIDevice_iPhone5;
            }
        }
    }else{
         
    }
    return UIDevice_iPhone5;
}
#pragma mark - 颜色转换 IOS中十六进制的颜色转换为UIColor
+ (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

//十六进制的字符串To String
+ (NSString *)stringFromHexString:(NSString *)hexString {
    
//    for(NSString * toRemove in [NSArray arrayWithObjects:@" ",@"\r", nil])
//        hexString = [hexString stringByReplacingOccurrencesOfString:toRemove withString:@""];
    
    // The hex codes should all be two characters.
    if (([hexString length] % 2) != 0)
        return nil;
    
    NSMutableString *string = [NSMutableString string];
    
    for (NSInteger i = 0; i < [hexString length]; i += 2) {
        
        NSString *hex = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSInteger decimalValue = 0;
        sscanf([hex UTF8String], "%x", &decimalValue);
        [string appendFormat:@"%c", decimalValue];
    }
    return string;
}
//string  To   相应的ascii字符串
+(NSString *)asccistringFromString:(NSString *)string
{
    NSString *str = @"123456789ABCDEFG";
    const char *s = [str cStringUsingEncoding:NSASCIIStringEncoding];
    size_t len = strlen(s);
    
    NSMutableString *asciiCodes = [NSMutableString string];
    for (int i = 0; i < len; i++) {
        [asciiCodes appendFormat:@"%02x ", (int)s[i]];
    }
    return asciiCodes;
}

//string To十六进制字符串
+ (NSString *)stringToHex:(NSString *)string
{

    NSString * hexStr = [NSString stringWithFormat:@"%@",
                         [NSData dataWithBytes:[string cStringUsingEncoding:NSUTF8StringEncoding]
                                        length:strlen([string cStringUsingEncoding:NSUTF8StringEncoding])]];
    
    for(NSString * toRemove in [NSArray arrayWithObjects:@"<", @">", nil])
        hexStr = [hexStr stringByReplacingOccurrencesOfString:toRemove withString:@""];
    return hexStr;
}

//向字符串中添加空格 每8个字符后面一个空格
+(NSString *)stringAppendSpace:(NSString *)string
{
    if(![string isEqualToString:@""])
    {
        NSMutableString *spaceString = [[NSMutableString alloc]init];
        if(string.length > 8)  //字符串个数大于8时
        {
            NSMutableArray *spaceIndexs = [NSMutableArray new];
            for (int index = 0; index < string.length; index++) {
                NSString *tmpStr = [string substringWithRange:NSMakeRange(index, 1)];
                if ([tmpStr isEqualToString:@" "]) {
                    [spaceIndexs addObject:[NSNumber numberWithInt:index]];
                }
            }
           
            int lastIndex = [[spaceIndexs lastObject] integerValue]+1;
            [spaceString appendString:[string substringWithRange:NSMakeRange(0, lastIndex)]];
            NSMutableString   *newStr =[NSMutableString stringWithString:[string substringFromIndex:lastIndex]];
            if(newStr.length == 8)
            {
                [newStr appendString:@" "];
            }
            [spaceString appendString:newStr];
            return spaceString;
        }else if(string.length == 8){  //字符串个数为8时，添加空格
            [spaceString appendString:string];
            [spaceString appendString:@" "];
            return spaceString;
        }
    }
    return  string;
}
//如果数据是奇数刚在尾部追加零
+(NSString *)stringAppendZero:(NSString *)string
{
    if(![string isEqualToString:@""])
    {
        NSMutableString *ZeroString = [[NSMutableString alloc]init];
        [ZeroString appendString:string];
        if(string.length > 8)
        {
            NSMutableArray *spaceIndexs = [NSMutableArray new];
            for (int index = 0; index < string.length; index++) {
                NSString *tmpStr = [string substringWithRange:NSMakeRange(index, 1)];
                if ([tmpStr isEqualToString:@" "]) {
                    [spaceIndexs addObject:[NSNumber numberWithInt:index]];
                }
            }
            int lastIndex = [[spaceIndexs lastObject] integerValue]+1;
            NSMutableString   *newStr =[NSMutableString stringWithString:[string substringFromIndex:lastIndex]];
            if(newStr.length%2 == 1)
            {
                [ZeroString insertString:@"0" atIndex:ZeroString.length-1];
            }
           
        }else if(string.length < 8){
            if(string.length%2 == 1)
            {
                [ZeroString insertString:@"0" atIndex:ZeroString.length-1];
            }
        }
        return ZeroString;
    }
    return string;
}
+(NSString *)stringRemoveLast:(NSString *)string
{
    if (![string isEqualToString:@""]) {
        NSMutableString   *mutableString = [NSMutableString new];
        [mutableString appendString:string];
        [mutableString deleteCharactersInRange:NSMakeRange(mutableString.length-1, 1)];
        return mutableString;
    }
    return @"";
}
@end
