#import <Foundation/Foundation.h>

enum DateType{
    YYYYMMddHHmmss
};

@interface NSString (Utils)

- (NSString *)md5;

- (NSData *)base64Decode;
- (NSString *)base64Encode:(NSData*)data;

- (NSString *)URLEncodedString;
- (NSString *)URLDecodedString;

- (BOOL)isNotEmpty;

- (NSString *)dateStringFormat;
- (NSDate *)stringConvertDate;
- (NSString *)getDateLongTimeByYYYYMMddHHmmss;

@end
