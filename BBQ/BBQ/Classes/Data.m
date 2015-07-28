//
//  Data.m
//  BBQ
//
//  Created by Start on 15/7/28.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "Data.h"

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
