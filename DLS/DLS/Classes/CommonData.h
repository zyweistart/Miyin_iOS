//
//  CommonData.h
//  DLS
//
//  Created by Start on 5/18/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import <Foundation/Foundation.h>
#define MKEY @"KEY"
#define MVALUE @"MVALUE"

@interface CommonData : NSObject
//状态
+ (NSArray*)getStatus;
//类型
+ (NSArray*)getType1;
+ (NSArray*)getType2;
//吨
+ (NSArray*)getSearchTon;
+ (NSArray*)getSearchTon2;
//距离
+ (NSArray*)getDistance;
+ (NSArray*)getDistance2;
//性别
+ (NSArray*)getSex;
//职位
+ (NSArray*)getJob;
//学历
+ (NSArray*)getEducation;
//年限
+ (NSArray*)getYears;
//薪资
+ (NSArray*)getSalary;
//区域
+ (NSArray*)getRegion;
//角色
+ (NSArray*)getRole;
+ (int)getValueIndex:(NSArray*)array Key:(NSString*)key;
+ (NSString*)getValueArray:(NSArray*)array Key:(NSString*)key;

@end
