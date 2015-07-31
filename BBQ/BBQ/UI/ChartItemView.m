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
        [self setUserInteractionEnabled:YES];
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
        
        [self createChartView];
        
        totalSecond=0;
        if(self.mTimer==nil){
            self.mTimer=[NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
        }
    }
    return self;
}

- (void)loadData:(NSDictionary*)data
{
    [self setCurrentData:data];
    for(id k in [data allKeys]){
        NSString *key=[NSString stringWithFormat:@"%@",k];
        self.currentKey=[NSString stringWithFormat:@"%@",key];
        [self.lblTitle setText:self.currentKey];
    }
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
            BOOL flag=YES;
            for(NSDictionary *d in array){
                //存在相同时间段则不加入
                if([timerV isEqualToString:[d objectForKey:CHARTTIMER]]){
                    flag=NO;
                }
            }
            if(flag){
                [chDataValue setObject:timerV forKey:CHARTTIMER];
                [array addObject:chDataValue];
            }
            //最多只显示8条
            NSMutableArray *tmpArray=[NSMutableArray new];
            if([array count]>600){
                tmpArray=[NSMutableArray new];
                for(NSInteger i=[array count]-600;i<[array count];i++){
                    [tmpArray addObject:[array objectAtIndex:i]];
                }
            }else{
                tmpArray=[NSMutableArray arrayWithArray:array];
            }
            
            [[[Data Instance]chartData]setObject:array forKey:self.currentKey];
            
            [self createChartView];
            
            break;
        }
    }
    
}

- (void)createChartView
{
    if (self.lineChartView) {
        [self.lineChartView removeFromSuperview];
        self.lineChartView = nil;
    }
    self.lineChartView = [[PNLineChartView alloc]initWithFrame:CGRectMake1(40,0, 275, 180)];
    [self.lineChartView setBackgroundColor:[UIColor whiteColor]];
    [self.frameView addSubview:self.lineChartView];
    
    self.lineChartView.axisLeftLineWidth = 30;
    self.lineChartView.min = 0;
    self.lineChartView.max = 538;
    self.lineChartView.interval = (self.lineChartView.max-self.lineChartView.min)/5;
    NSMutableArray* yAxisValues = [@[] mutableCopy];
    for (int i=0; i<6; i++) {
        NSString *value = [NSString stringWithFormat:@"%.2f", self.lineChartView.min+self.lineChartView.interval*i];
        [yAxisValues addObject:value];
    }
    self.lineChartView.yAxisValues = yAxisValues;
    
    NSMutableArray *xAxisValues = [NSMutableArray array];
    NSArray *dlV=[[[Data Instance]chartData]objectForKey:self.currentKey];
    for(int i=0;i<[dlV count];i++){
        NSDictionary *vv=[dlV objectAtIndex:i];
        NSString * str = [NSString stringWithFormat:@"%@",[vv objectForKey:CHARTTIMER]];
        [xAxisValues addObject:str];
    }
    self.lineChartView.xAxisValues = xAxisValues;
    
    NSMutableArray *plottingDataValues1 = [NSMutableArray array];
    NSMutableArray *plottingDataValues2 = [NSMutableArray array];
    dlV=[[[Data Instance]chartData]objectForKey:self.currentKey];
    for(int i=0;i<[dlV count];i++){
        NSDictionary *vv=[dlV objectAtIndex:i];
        [plottingDataValues1 addObject:[NSString stringWithFormat:@"%@",[vv objectForKey:CHARTCURVALUE]]];
        [plottingDataValues2 addObject:[NSString stringWithFormat:@"%@",[vv objectForKey:CHARTSETVALUE]]];
    }
    
    PNPlot *plot1 = [[PNPlot alloc] init];
    plot1.plottingValues = plottingDataValues1;
    plot1.lineColor = [UIColor blueColor];
    plot1.lineWidth = 0.5;
    [self.lineChartView addPlot:plot1];
    
    PNPlot *plot2 = [[PNPlot alloc] init];
    plot2.plottingValues = plottingDataValues2;
    plot2.lineColor = [UIColor redColor];
    plot2.lineWidth = 1;
    [self.lineChartView  addPlot:plot2];
}

@end