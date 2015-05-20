//
//  CommonData.m
//  DLS
//
//  Created by Start on 5/18/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "CommonData.h"

@implementation CommonData

+ (NSArray*)getStatus
{
    return [NSArray arrayWithObjects:
            [NSDictionary dictionaryWithObjectsAndKeys:@"不限",MKEY,@"-1",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"新发布",MKEY,@"1",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"洽谈中",MKEY,@"2",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"已成交",MKEY,@"3",MVALUE, nil], nil];
}

+ (NSArray*)getType1
{
    return [NSArray arrayWithObjects:
            [NSDictionary dictionaryWithObjectsAndKeys:@"不限",MKEY,@"-1",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"汽车吊",MKEY,@"1",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"履带吊",MKEY,@"2",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"塔吊",MKEY,@"3",MVALUE, nil],nil];
}
//类型
+ (NSArray*)getType2
{
    return [NSArray arrayWithObjects:
            [NSDictionary dictionaryWithObjectsAndKeys:@"汽车吊",MKEY,@"1",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"履带吊",MKEY,@"2",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"塔吊",MKEY,@"3",MVALUE, nil], nil];
}
//吨
+ (NSArray*)getSearchTon
{
    return [NSArray arrayWithObjects:
            [NSDictionary dictionaryWithObjectsAndKeys:@"不限",MKEY,@"-1",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"8吨",MKEY,@"8",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"12吨",MKEY,@"12",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"25吨",MKEY,@"25",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"35吨",MKEY,@"35",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"50吨",MKEY,@"50",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"65吨",MKEY,@"65",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"70吨",MKEY,@"70",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"90吨",MKEY,@"90",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"100吨",MKEY,@"100",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"120吨",MKEY,@"120",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"130吨",MKEY,@"130",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"150吨",MKEY,@"150",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"180吨",MKEY,@"180",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"200吨",MKEY,@"200",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"220吨",MKEY,@"220",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"260吨",MKEY,@"260",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"300吨",MKEY,@"300",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"350吨",MKEY,@"350",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"400吨",MKEY,@"400",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"500吨",MKEY,@"500",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"600吨",MKEY,@"600",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"800吨",MKEY,@"800",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"1000吨",MKEY,@"1000",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"1200吨",MKEY,@"1200",MVALUE, nil],nil];
}
//吨
+ (NSArray*)getSearchTon2
{
    return [NSArray arrayWithObjects:
            [NSDictionary dictionaryWithObjectsAndKeys:@"8吨",MKEY,@"8",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"12吨",MKEY,@"12",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"25吨",MKEY,@"25",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"35吨",MKEY,@"35",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"50吨",MKEY,@"50",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"65吨",MKEY,@"65",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"70吨",MKEY,@"70",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"90吨",MKEY,@"90",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"100吨",MKEY,@"100",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"120吨",MKEY,@"120",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"130吨",MKEY,@"130",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"150吨",MKEY,@"150",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"180吨",MKEY,@"180",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"200吨",MKEY,@"200",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"220吨",MKEY,@"220",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"260吨",MKEY,@"260",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"300吨",MKEY,@"300",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"350吨",MKEY,@"350",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"400吨",MKEY,@"400",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"500吨",MKEY,@"500",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"600吨",MKEY,@"600",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"800吨",MKEY,@"800",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"1000吨",MKEY,@"1000",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"1200吨",MKEY,@"1200",MVALUE, nil],nil];
}
//距离
+ (NSArray*)getDistance
{
    return [NSArray arrayWithObjects:
            [NSDictionary dictionaryWithObjectsAndKeys:@"不限",MKEY,@"-1",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"3KM",MKEY,@"3000",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"5KM",MKEY,@"5000",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"10KM",MKEY,@"10000",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"20KM",MKEY,@"20000",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"30KM",MKEY,@"30000",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"50KM",MKEY,@"50000",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"100KM",MKEY,@"100000",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"150KM",MKEY,@"150000",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"200KM",MKEY,@"200000",MVALUE, nil],nil];
}
+ (NSArray*)getDistance2
{
    return [NSArray arrayWithObjects:
            [NSDictionary dictionaryWithObjectsAndKeys:@"3KM",MKEY,@"3000",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"5KM",MKEY,@"5000",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"10KM",MKEY,@"10000",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"20KM",MKEY,@"20000",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"30KM",MKEY,@"30000",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"50KM",MKEY,@"50000",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"100KM",MKEY,@"100000",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"150KM",MKEY,@"150000",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"200KM",MKEY,@"200000",MVALUE, nil],nil];
}
//性别
+ (NSArray*)getSex
{
    return [NSArray arrayWithObjects:
            [NSDictionary dictionaryWithObjectsAndKeys:@"男",MKEY,@"1",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"女",MKEY,@"0",MVALUE, nil], nil];
}
//职位
+ (NSArray*)getJob
{
    return [NSArray arrayWithObjects:
            [NSDictionary dictionaryWithObjectsAndKeys:@"教师",MKEY,@"1",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"技术员",MKEY,@"2",MVALUE, nil], nil];
}
//学历
+ (NSArray*)getEducation
{
    return [NSArray arrayWithObjects:
            [NSDictionary dictionaryWithObjectsAndKeys:@"不限",MKEY,@"0",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"初中",MKEY,@"1",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"高中",MKEY,@"2",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"中技",MKEY,@"3",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"中专",MKEY,@"4",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"大专",MKEY,@"5",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"本科",MKEY,@"6",MVALUE, nil],nil];
}
//年限
+ (NSArray*)getYears
{
    return [NSArray arrayWithObjects:
            [NSDictionary dictionaryWithObjectsAndKeys:@"不限",MKEY,@"0",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"1年",MKEY,@"1",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"2年",MKEY,@"2",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"3-4年",MKEY,@"3",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"5-7年",MKEY,@"4",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"8-9年",MKEY,@"5",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"10年以上",MKEY,@"6",MVALUE, nil],nil];
}
//薪资
+ (NSArray*)getSalary
{
    return [NSArray arrayWithObjects:
            [NSDictionary dictionaryWithObjectsAndKeys:@"面议",MKEY,@"0",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"3000-4999",MKEY,@"1",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"4500-5999",MKEY,@"2",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"6000-7999",MKEY,@"3",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"8000-9999",MKEY,@"4",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"10000-14999",MKEY,@"5",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"15000-19999",MKEY,@"6",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"20000-29999",MKEY,@"8",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"30000-39999",MKEY,@"9",MVALUE, nil],  nil];
}
//区域
+ (NSArray*)getRegion
{
    return [NSArray arrayWithObjects:
            [NSDictionary dictionaryWithObjectsAndKeys:@"杭州",MKEY,@"22",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"舟山",MKEY,@"1117",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"衢州",MKEY,@"1116",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"金华",MKEY,@"1115",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"丽水",MKEY,@"29",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"温州",MKEY,@"28",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"台州",MKEY,@"27",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"湖州",MKEY,@"26",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"嘉兴",MKEY,@"25",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"绍兴",MKEY,@"24",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"宁波",MKEY,@"23",MVALUE, nil],nil];
}

+ (NSArray*)getRole
{
    return [NSArray arrayWithObjects:
                 [NSDictionary dictionaryWithObjectsAndKeys:@"个人",MKEY,@"0",MVALUE, nil],
                 [NSDictionary dictionaryWithObjectsAndKeys:@"机手",MKEY,@"1",MVALUE, nil],
                 [NSDictionary dictionaryWithObjectsAndKeys:@"项目经理",MKEY,@"2",MVALUE, nil],
                 [NSDictionary dictionaryWithObjectsAndKeys:@"其他公司",MKEY,@"3",MVALUE, nil],
                 [NSDictionary dictionaryWithObjectsAndKeys:@"运输公司",MKEY,@"4",MVALUE, nil],
                 [NSDictionary dictionaryWithObjectsAndKeys:@"配件公司",MKEY,@"5",MVALUE, nil],
                 [NSDictionary dictionaryWithObjectsAndKeys:@"维修公司",MKEY,@"6",MVALUE, nil],
                 [NSDictionary dictionaryWithObjectsAndKeys:@"吊装公司",MKEY,@"7",MVALUE, nil],
                 [NSDictionary dictionaryWithObjectsAndKeys:@"工程公司",MKEY,@"8",MVALUE, nil],nil];
}

+ (NSString*)getValueArray:(NSArray*)array Key:(NSString*)key
{
    for(id d in array){
        NSString *value=[d objectForKey:MVALUE];
        if([value isEqualToString:key]){
            return [d objectForKey:MKEY];
        }
    }
    return key;
}


@end
