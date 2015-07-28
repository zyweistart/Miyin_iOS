//
//  Data.m
//  BBQ
//
//  Created by Start on 15/7/28.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "Data.h"


#define SETTINGALARM @"SETTINGALARM"
#define SETTINGLANGUAGE @"SETTINGLANGUAGE"

@implementation Data

static Data * instance = nil;
+ (Data *) Instance {
    @synchronized(self){
        if(nil == instance){
            instance=[self new];
            instance.sett=[[NSMutableArray alloc]init];
            instance.settValue=[NSMutableDictionary new];
        }
    }
    return instance;
}

- (void)setAlarm:(NSString*)alarm
{
    [Common setCache:SETTINGALARM data:alarm];
}

- (NSString*)getAlarm
{
    NSString *alarm=[Common getCache:SETTINGALARM];
    if(alarm){
        return alarm;
    }
    return @"";
}

- (void)setLanguage:(NSString*)language
{
    [Common setCache:SETTINGLANGUAGE data:language];
}

- (NSString*)getLanguage
{
    NSString *language=[Common getCache:SETTINGLANGUAGE];
    if(language){
        return language;
    }
    return @"";
}

//获取当前温度
+ (NSString*)getTemperatureValue:(int)v
{
    if([@"f" isEqualToString:[[Data Instance]cf]]){
        return [NSString stringWithFormat:@"%d°F",v];
    }else{
        return [NSString stringWithFormat:@"%d°C",v];
    }
}

@end
