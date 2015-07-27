#import <Foundation/Foundation.h>

@interface Response : NSObject

@property BOOL successFlag;
@property (strong,nonatomic) NSString *code;
@property (strong,nonatomic) NSString *message;
@property (strong,nonatomic) NSData *data;
@property (strong,nonatomic) NSString *responseString;
@property (strong,nonatomic) NSDictionary *resultJSON;

+ (Response*)toData:(NSString*)repsonseString;

@end