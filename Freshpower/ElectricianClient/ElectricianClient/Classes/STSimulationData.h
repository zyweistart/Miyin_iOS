//
//  STSimulationData.h
//  ElectricianClient
//
//  Created by Start on 3/28/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STSimulationData : NSObject

+ (NSMutableArray *)getRandomChargeData;

+ (NSMutableArray *)getElectricityData;

+ (NSMutableArray*)getOutScale;

//随机产生进行系数的数组
+ (NSMutableArray*)getInScale;

+ (double)getBeforeAveragePrice;

+ (NSString *)getSimpleLineName:(int)index;

+ (NSString *)getLineName:(int)index;

+ (NSString *)getChildLineName:(int)index;

@end
