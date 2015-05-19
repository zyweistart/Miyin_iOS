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
            [NSDictionary dictionaryWithObjectsAndKeys:@"3KM",MKEY,@"1",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"5KM",MKEY,@"2",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"10KM",MKEY,@"3",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"20KM",MKEY,@"4",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"30KM",MKEY,@"5",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"50KM",MKEY,@"6",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"100KM",MKEY,@"7",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"150KM",MKEY,@"8",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"200KM",MKEY,@"9",MVALUE, nil],nil];
}
+ (NSArray*)getDistance2
{
    return [NSArray arrayWithObjects:
            [NSDictionary dictionaryWithObjectsAndKeys:@"3KM",MKEY,@"1",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"5KM",MKEY,@"2",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"10KM",MKEY,@"3",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"20KM",MKEY,@"4",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"30KM",MKEY,@"5",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"50KM",MKEY,@"6",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"100KM",MKEY,@"7",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"150KM",MKEY,@"8",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"200KM",MKEY,@"9",MVALUE, nil],nil];
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
                 [NSDictionary dictionaryWithObjectsAndKeys:@"专科",MKEY,@"1",MVALUE, nil],
                 [NSDictionary dictionaryWithObjectsAndKeys:@"本科",MKEY,@"2",MVALUE, nil], nil];
}
//年限
+ (NSArray*)getYears
{
    return [NSArray arrayWithObjects:
            [NSDictionary dictionaryWithObjectsAndKeys:@"不限",MKEY,@"0",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"一年",MKEY,@"1",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"两年",MKEY,@"2",MVALUE, nil], nil];
}
//薪资
+ (NSArray*)getSalary
{
    return [NSArray arrayWithObjects:
            [NSDictionary dictionaryWithObjectsAndKeys:@"面议",MKEY,@"0",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"5000-10000元",MKEY,@"1",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"3000-5000",MKEY,@"2",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"1500-3000",MKEY,@"3",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"1500以下",MKEY,@"4",MVALUE, nil], nil];
}
//区域
+ (NSArray*)getRegion
{
    return [NSArray arrayWithObjects:
     [NSDictionary dictionaryWithObjectsAndKeys:@"杭州",MKEY,@"8",MVALUE, nil],
     [NSDictionary dictionaryWithObjectsAndKeys:@"上海",MKEY,@"12",MVALUE, nil],
            [NSDictionary dictionaryWithObjectsAndKeys:@"北京",MKEY,@"25",MVALUE, nil],nil];
}

+ (NSArray*)getRole
{
    return [NSArray arrayWithObjects:
                 [NSDictionary dictionaryWithObjectsAndKeys:@"个人",MKEY,@"1",MVALUE, nil],
                 [NSDictionary dictionaryWithObjectsAndKeys:@"机手",MKEY,@"2",MVALUE, nil],
                 [NSDictionary dictionaryWithObjectsAndKeys:@"项目经理",MKEY,@"3",MVALUE, nil],
                 [NSDictionary dictionaryWithObjectsAndKeys:@"其他公司",MKEY,@"4",MVALUE, nil],
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
