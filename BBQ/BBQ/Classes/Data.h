//
//  Data.h
//  BBQ
//
//  Created by Start on 15/7/28.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CHARTKEY @"CHARTKEY"
#define CHARTDATA @"CHARTDATA"
#define CHARTTIMER @"CHARTTIMER"
#define CHARTCURVALUE @"CHARTCURVALUE"
#define CHARTSETVALUE @"CHARTSETVALUE"

#import "TabBarFrameViewController.h"

@interface Data : NSObject

+ (Data *) Instance;

@property BOOL isDemo;
@property (strong,nonatomic) NSMutableDictionary *sett;
@property (strong,nonatomic) NSMutableArray *currentTValue;
@property (strong,nonatomic) NSMutableDictionary *settValue;
@property (strong,nonatomic) NSMutableDictionary *chartData;
@property (strong,nonatomic) TabBarFrameViewController *mTabBarFrameViewController;

+ (NSString*)getTemperatureValue:(NSString*)v;

- (NSString*)getAutoConnected;
- (void)setAutoConnected:(NSString*)uuid;
- (NSString*)getCf;
- (void)setCf:(NSString*)cf;
- (NSString*)getAlarm;
- (void)setAlarm:(NSString*)alarm;
//- (NSString*)getLanguage;
//- (void)setLanguage:(NSString*)language;

@end
