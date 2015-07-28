//
//  Data.h
//  BBQ
//
//  Created by Start on 15/7/28.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Data : NSObject

+ (Data *) Instance;

@property (strong,nonatomic) NSString *cf;
@property (strong,nonatomic) NSMutableArray *sett;

+ (NSString*)getTemperatureValue:(int)v;

@end
