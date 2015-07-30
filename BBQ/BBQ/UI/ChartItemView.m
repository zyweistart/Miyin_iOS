//
//  ChartItemView.m
//  BBQ
//
//  Created by Start on 15/7/30.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "ChartItemView.h"

@implementation ChartItemView{
    NSInteger totalSecond;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:DEFAULTITLECOLORRGB(65, 51, 42)];
        self.frameView=[[UIView alloc]initWithFrame:CGRectMake1(0, 5, 315, 180)];
        self.frameView.layer.masksToBounds=YES;
        self.frameView.layer.cornerRadius=CGWidth(5);
        self.frameView.layer.borderWidth=1;
        self.frameView.layer.borderColor=DEFAULTITLECOLOR(200).CGColor;
        [self.frameView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.frameView];
        
        self.lblTitle=[[UILabel alloc]initWithFrame:CGRectMake1(0, 0, 40, 180)];
        [self.lblTitle setTextColor:[UIColor whiteColor]];
        [self.lblTitle setFont:[UIFont systemFontOfSize:18]];
        [self.lblTitle setBackgroundColor:DEFAULTITLECOLORRGB(242, 125, 0)];
        [self.lblTitle setTextAlignment:NSTextAlignmentCenter];
        [self.frameView addSubview:self.lblTitle];
        
        self.chartView = [[UUChart alloc]initwithUUChartDataFrame:CGRectMake1(40,0, 275, 180) withSource:self withStyle:UUChartLineStyle];
        [self.chartView showInView:self.frameView];
        
        totalSecond=0;
        if(self.mTimer==nil){
            self.mTimer=[NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
        }
    }
    return self;
}

- (void)loadData:(NSDictionary*)data
{
    for(id k in [data allKeys]){
        NSString *key=[NSString stringWithFormat:@"%@",k];
        self.currentKey=[NSString stringWithFormat:@"%@",key];
        [self.lblTitle setText:self.currentKey];
    }
}

- (NSArray *)getXTitles:(int)num
{
    NSMutableArray *xTitles = [NSMutableArray array];
    NSArray *dlV=[[[Data Instance]chartData]objectForKey:self.currentKey];
    for(int i=0;i<[dlV count];i++){
        NSDictionary *vv=[dlV objectAtIndex:i];
        NSString * str = [NSString stringWithFormat:@"%@",[vv objectForKey:CHARTTIMER]];
        [xTitles addObject:str];
    }
    return xTitles;
}

#pragma mark - @required

//横坐标标题数组
- (NSArray *)UUChart_xLableArray:(UUChart *)chart
{
    return [self getXTitles:7];
}

//数值多重数组
- (NSArray *)UUChart_yValueArray:(UUChart *)chart
{
    NSMutableArray *ary1 = [NSMutableArray array];
    NSMutableArray *ary2 = [NSMutableArray array];
    NSArray *dlV=[[[Data Instance]chartData]objectForKey:self.currentKey];
    for(int i=0;i<[dlV count];i++){
        NSDictionary *vv=[dlV objectAtIndex:i];
        [ary1 addObject:[NSString stringWithFormat:@"%@",[vv objectForKey:CHARTCURVALUE]]];
        [ary2 addObject:[NSString stringWithFormat:@"%@",[vv objectForKey:CHARTSETVALUE]]];
    }
    return @[ary1,ary2];
}

#pragma mark - @optional
//颜色数组
- (NSArray *)UUChart_ColorArray:(UUChart *)chart
{
    return @[DEFAULTITLECOLORRGB(8, 167, 206),UURed];
}

//显示数值范围
- (CGRange)UUChartChooseRangeInLineChart:(UUChart *)chart
{
    return CGRangeZero;
}

#pragma mark 折线图专享功能

//标记数值区域
- (CGRange)UUChartMarkRangeInLineChart:(UUChart *)chart
{
    return CGRangeZero;
}

//判断显示横线条
- (BOOL)UUChart:(UUChart *)chart ShowHorizonLineAtIndex:(NSInteger)index
{
    return YES;
}

//判断显示最大最小值
- (BOOL)UUChart:(UUChart *)chart ShowMaxMinAtIndex:(NSInteger)index
{
    return YES;
}

- (void)updateTimer
{
    if(self.currentKey==nil){
        return;
    }
    for(NSDictionary *da in [[Data Instance]currentTValue]){
        NSString *value=[da objectForKey:self.currentKey];
        if(value!=nil){
            totalSecond+=60;
            NSMutableArray *array=[[[Data Instance]chartData]objectForKey:self.currentKey];
            if(array==nil){
                array=[[NSMutableArray alloc]init];
            }
            NSString *settValue=[[[Data Instance]sett]objectForKey:self.currentKey];
            NSMutableDictionary *chDataValue=[[NSMutableDictionary alloc]init];
            [chDataValue setObject:value forKey:CHARTCURVALUE];
            [chDataValue setObject:settValue forKey:CHARTSETVALUE];
            NSInteger t=totalSecond/60;
            NSString *timerV=[NSString stringWithFormat:@"%ldm",t];
            if(t>60){
                timerV=[NSString stringWithFormat:@"%ldh",t/60];
            }
            [chDataValue setObject:timerV forKey:CHARTTIMER];
            [array addObject:chDataValue];
            
            //最多只显示8条
            NSMutableArray *tmpArray=[NSMutableArray arrayWithArray:array];
            if([array count]>8){
                tmpArray=[NSMutableArray new];
                for(NSInteger i=[array count]-8;i<[array count];i++){
                    [tmpArray addObject:[array objectAtIndex:i]];
                }
            }else{
                tmpArray=[NSMutableArray arrayWithArray:array];
            }
            
            [[[Data Instance]chartData]setObject:tmpArray forKey:self.currentKey];
            
            if (self.chartView) {
                [self.chartView removeFromSuperview];
                self.chartView = nil;
            }
            self.chartView = [[UUChart alloc]initwithUUChartDataFrame:CGRectMake1(40,0, 275, 180) withSource:self withStyle:UUChartLineStyle];
            [self.chartView showInView:self.frameView];
            
            break;
        }
    }
}

@end