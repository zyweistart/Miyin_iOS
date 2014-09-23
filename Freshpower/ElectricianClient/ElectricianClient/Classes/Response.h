//
//  Response.h
//  ElectricianRun
//
//  Created by Start on 2/9/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Response : NSObject


@property (strong,nonatomic) NSData *resultData;
@property (strong,nonatomic) NSString *responseString;
@property (strong,nonatomic) NSDictionary *resultJSON;

@end
