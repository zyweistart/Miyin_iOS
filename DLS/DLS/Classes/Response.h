//
//  ACResponse.h
//  ACyulu
//
//  Created by Start on 12-12-6.
//  Copyright (c) 2012年 ancun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Response : NSObject

@property BOOL successFlag;
@property (strong,nonatomic) NSString *code;
@property (strong,nonatomic) NSString *msg;
@property (strong,nonatomic) NSData *data;
@property (strong,nonatomic) NSString *responseString;
@property (strong,nonatomic) NSDictionary *resultJSON;

+ (Response*)toData:(NSString*)repsonseString;

@end