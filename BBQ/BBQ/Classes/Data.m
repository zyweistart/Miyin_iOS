//
//  Data.m
//  BBQ
//
//  Created by Start on 15/7/28.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "Data.h"


#define SETTINGCF @"SETTINGCF"
#define SETTINGALARM @"SETTINGALARM"
#define AUTOCONNECTEDUUID @"AUTOCONNECTEDUUID"

@implementation Data

static Data * instance = nil;
+ (Data *) Instance {
    @synchronized(self){
        if(nil == instance){
            instance=[self new];
            instance.sett=[NSMutableDictionary new];
            instance.settValue=[NSMutableDictionary new];
            instance.chartData=[NSMutableDictionary new];
        }
    }
    return instance;
}

- (void)clear
{
    [self.sett removeAllObjects];
    [self.settValue removeAllObjects];
    [self.chartData removeAllObjects];
}

- (void)setAutoConnected:(NSString*)uuid
{
    [Common setCache:AUTOCONNECTEDUUID data:uuid];
}

- (NSString*)getAutoConnected
{
    NSString *cf=[Common getCache:AUTOCONNECTEDUUID];
    if(cf){
        return cf;
    }
    return @"";
}

- (void)setCf:(NSString*)cf
{
    [Common setCache:SETTINGCF data:cf];
}

- (NSString*)getCf
{
    NSString *cf=[Common getCache:SETTINGCF];
    if(cf){
        return cf;
    }
    return @"";
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

//获取当前温度
+ (NSString*)getTemperatureValue:(NSString*)v
{
    if([@"f" isEqualToString:[[Data Instance]getCf]]){
        CGFloat fValue=[v floatValue]*9/5+32;
        NSString *value=[NSString stringWithFormat:@"%lf",fValue+DECIMALPOINT];
        return [NSString stringWithFormat:@"%d°F",[value intValue]];
    }else{
        NSString *value=[NSString stringWithFormat:@"%lf",[v floatValue]+DECIMALPOINT];
        return [NSString stringWithFormat:@"%d°C",[value intValue]];
    }
}

@end
