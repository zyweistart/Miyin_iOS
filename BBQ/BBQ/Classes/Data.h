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

@property (strong,nonatomic) NSMutableArray *sett;
@property (strong,nonatomic) NSMutableDictionary *settValue;

+ (NSString*)getTemperatureValue:(int)v;

- (NSString*)getCf;
- (void)setCf:(NSString*)cf;
- (NSString*)getAlarm;
- (void)setAlarm:(NSString*)alarm;
- (NSString*)getLanguage;
- (void)setLanguage:(NSString*)language;

@end
