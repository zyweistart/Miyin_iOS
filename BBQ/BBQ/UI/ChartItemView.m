//
//  ChartItemView.m
//  BBQ
//
//  Created by Start on 15/7/30.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "ChartItemView.h"

#define SECOND 6

@implementation ChartItemView{
    NSInteger totalSecond;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if(self.scale==0){
            self.scale=1;
        }
        [self setBackgroundColor:DEFAULTITLECOLORRGB(65, 51, 42)];
        [self setUserInteractionEnabled:YES];
        self.frameView=[[UIView alloc]initWithFrame:CGRectMake1(0, 5*self.scale, 315*self.scale, 180*self.scale)];
        self.frameView.layer.masksToBounds=YES;
        self.frameView.layer.cornerRadius=CGWidth(5*self.scale);
        self.frameView.layer.borderWidth=1*self.scale;
        self.frameView.layer.borderColor=DEFAULTITLECOLOR(200).CGColor;
        [self.frameView setBackgroundColor:DEFAULTITLECOLOR(230)];
        [self.frameView setUserInteractionEnabled:YES];
        [self addSubview:self.frameView];
        
        self.lblTitle=[[UILabel alloc]initWithFrame:CGRectMake1(0, 0, 40*self.scale, 180*self.scale)];
        [self.lblTitle setTextColor:[UIColor whiteColor]];
        [self.lblTitle setFont:[UIFont systemFontOfSize:18*self.scale]];
        [self.lblTitle setBackgroundColor:DEFAULTITLECOLORRGB(242, 125, 0)];
        [self.lblTitle setTextAlignment:NSTextAlignmentCenter];
        [self.frameView addSubview:self.lblTitle];
        
        self.topLabelView=[[UIView alloc]initWithFrame:CGRectMake1(45*self.scale, 0, 275*self.scale, 20*self.scale)];
        [self.frameView addSubview:self.topLabelView];
        self.lblCFType=[[UILabel alloc]initWithFrame:CGRectMake1(0, 0, 55*self.scale, 20*self.scale)];
        [self.lblCFType setFont:[UIFont systemFontOfSize:12*self.scale]];
        [self.lblCFType setTextColor:DEFAULTITLECOLOR(150)];
        [self.topLabelView addSubview:self.lblCFType];
        self.lblCurrentTemp=[[UILabel alloc]initWithFrame:CGRectMake1(55*self.scale, 0, 80*self.scale, 20*self.scale)];
        [self.lblCurrentTemp setFont:[UIFont systemFontOfSize:12*self.scale]];
        [self.lblCurrentTemp setTextColor:DEFAULTITLECOLOR(150)];
        [self.lblCurrentTemp setTextAlignment:NSTextAlignmentRight];
        [self.topLabelView addSubview:self.lblCurrentTemp];
        UIView *CurrentTempLine=[[UIView alloc]initWithFrame:CGRectMake1(140*self.scale, 9*self.scale, 20*self.scale, 2*self.scale)];
        [CurrentTempLine setBackgroundColor:DEFAULTITLECOLORRGB(7, 166, 206)];
        [self.topLabelView addSubview:CurrentTempLine];
        self.lblSetTemp=[[UILabel alloc]initWithFrame:CGRectMake1(165*self.scale, 0, 60*self.scale, 20*self.scale)];
        [self.lblSetTemp setFont:[UIFont systemFontOfSize:12*self.scale]];
        [self.lblSetTemp setTextColor:DEFAULTITLECOLOR(150)];
        [self.lblSetTemp setTextAlignment:NSTextAlignmentRight];
        [self.topLabelView addSubview:self.lblSetTemp];
        UIView *SetTempLine=[[UIView alloc]initWithFrame:CGRectMake1(230*self.scale, 9*self.scale, 20*self.scale, 2*self.scale)];
        [SetTempLine setBackgroundColor:DEFAULTITLECOLORRGB(210, 91, 44)];
        [self.topLabelView addSubview:SetTempLine];
        
        self.lineChartView = [[PNLineChartView alloc]initWithFrame:CGRectMake1(40*self.scale,20*self.scale, 240*self.scale, 160*self.scale)];
        [self.lineChartView setBackgroundColor:[UIColor clearColor]];
        [self.lineChartView setUserInteractionEnabled:YES];
        [self.frameView addSubview:self.lineChartView];
        self.lineChartView.min = 0;
        self.lblTimerUnit=[[UILabel alloc]initWithFrame:CGRectMake1(270*self.scale, 150*self.scale, 50*self.scale, 20*self.scale)];
        [self.lblTimerUnit setFont:[UIFont systemFontOfSize:10*self.scale]];
        [self.lblTimerUnit setTextColor:DEFAULTITLECOLOR(150)];
        [self.lblTimerUnit setTextAlignment:NSTextAlignmentCenter];
        [self.frameView addSubview:self.lblTimerUnit];
        totalSecond=0;
        if(self.mTimer==nil){
            self.mTimer=[NSTimer scheduledTimerWithTimeInterval:SECOND target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
        }
        [self loadChartData];
        self.max=250;
        self.pointNumber = 1200;
        [self setLanguage];
    }
    return self;
}

- (void)setLanguage
{
    if([@"f" isEqualToString:[[Data Instance]getCf]]){
        [self.lblCFType setText:[NSString stringWithFormat:@"%@(°F)",LOCALIZATION(@"Temp")]];
    }else{
        [self.lblCFType setText:[NSString stringWithFormat:@"%@(°C)",LOCALIZATION(@"Temp")]];
    }
    [self.lblCurrentTemp setText:LOCALIZATION(@"Current Temp")];
    [self.lblSetTemp setText:LOCALIZATION(@"Set Temp")];
    [self.lblTimerUnit setText:LOCALIZATION(@"Timer(M)")];
}

- (void)loadData:(NSDictionary*)data
{
    [self setCurrentData:data];
    for(id k in [data allKeys]){
        NSString *key=[NSString stringWithFormat:@"%@",k];
        self.currentKey=[NSString stringWithFormat:@"%@",key];
        [self.lblTitle setText:self.currentKey];
        if([@"T1" isEqualToString:self.currentKey]){
            self.max = 250;
            self.pointNumber=1200;
        }else if([@"T2" isEqualToString:self.currentKey]){
            self.max = 250;
            self.pointNumber=1200;
        }else if([@"T3" isEqualToString:self.currentKey]){
            self.max = 250;
            self.pointNumber=1200;
        }else if([@"T4" isEqualToString:self.currentKey]){
            self.max = 537;
            self.pointNumber=1200;
        }
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
            totalSecond+=SECOND;
            NSMutableArray *array=[[[Data Instance]chartData]objectForKey:self.currentKey];
            if(array==nil){
                array=[[NSMutableArray alloc]init];
            }
            NSString *settValue=[[[Data Instance]sett]objectForKey:self.currentKey];
            NSMutableDictionary *chDataValue=[[NSMutableDictionary alloc]init];
            [chDataValue setObject:value forKey:CHARTCURVALUE];
            [chDataValue setObject:settValue forKey:CHARTSETVALUE];
            NSInteger t=totalSecond/SECOND;
            NSString *timerV=[NSString stringWithFormat:@"%ld",t];
            if(t>SECOND){
//                timerV=[NSString stringWithFormat:@"%ldh:%ldm",t/60,t%60];
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
            //最多只显示
            NSMutableArray *tmpArray=[NSMutableArray new];
            if([array count]>self.pointNumber){
                tmpArray=[NSMutableArray new];
                
                for(NSInteger i=[array count]-self.pointNumber;i<[array count];i++){
                    [tmpArray addObject:[array objectAtIndex:i]];
                }
            }else{
                tmpArray=[NSMutableArray arrayWithArray:array];
            }
            
            [[[Data Instance]chartData]setObject:tmpArray forKey:self.currentKey];
            
             [self loadChartData];
            
            break;
        }
    }
    
}

- (void)loadChartData
{
    //清除旧的位置点
    [self.lineChartView clearPlot];
    [Data getTemperatureValue:@"2"];
    if([@"f" isEqualToString:[[Data Instance]getCf]]){
        self.lineChartView.max = self.max*9/5+32;
        [self.lblCFType setText:[NSString stringWithFormat:@"%@(°F)",LOCALIZATION(@"Temp")]];
    }else{
        self.lineChartView.max = self.max;
        [self.lblCFType setText:[NSString stringWithFormat:@"%@(°C)",LOCALIZATION(@"Temp")]];
    }
    self.lineChartView.interval = (self.lineChartView.max-self.lineChartView.min)/self.lineChartView.numberOfVerticalElements;
    NSArray *dlV=[[[Data Instance]chartData]objectForKey:self.currentKey];
    NSMutableArray *totalData=nil;
    NSMutableArray *timerList=[[NSMutableArray alloc]init];
    NSMutableDictionary *totalDataDic=[[NSMutableDictionary alloc]init];
    int y=60/SECOND;
    for(int i=0;i<[dlV count];i++){
        NSDictionary *vv=[dlV objectAtIndex:i];
        int timerValue=[[vv objectForKey:CHARTTIMER]intValue];
        int b=timerValue/y;
        if(timerValue%y>0){
            b++;
        }
        NSString *timer=[NSString stringWithFormat:@"%d",b];
        totalData=[totalDataDic objectForKey:timer];
        if(totalData==nil){
            [timerList addObject:timer];
            totalData=[[NSMutableArray alloc]init];
        }
        [totalData addObject:vv];
        [totalDataDic setObject:totalData forKey:timer];
    }
    if([timerList count]>0){
        NSArray *dlist=[totalDataDic objectForKey:[timerList objectAtIndex:0]];
        if([dlist count]<y){
            [timerList removeObjectAtIndex:0];
        }
    }
    //x轴
    NSMutableArray *xAxisValues = [NSMutableArray array];
    for(NSString *timer in timerList){
        [xAxisValues addObject:timer];
    }
    self.lineChartView.xAxisValues = xAxisValues;
    //y轴
    NSMutableArray* yAxisValues = [@[] mutableCopy];
    for (int i=0; i<=self.lineChartView.numberOfVerticalElements; i++) {
        NSString *value = [NSString stringWithFormat:@"%.2f", self.lineChartView.min+self.lineChartView.interval*i];
        [yAxisValues addObject:value];
    }
    self.lineChartView.yAxisValues = yAxisValues;
    NSMutableArray *plottingDataValues1 = [NSMutableArray array];
    NSMutableArray *plottingDataValues2 = [NSMutableArray array];
    for(NSString *timer in timerList){
        NSArray *dlist=[totalDataDic objectForKey:timer];
        for(NSDictionary *d in dlist){
            [plottingDataValues1 addObject:[NSString stringWithFormat:@"%@",[d objectForKey:CHARTCURVALUE]]];
            [plottingDataValues2 addObject:[NSString stringWithFormat:@"%@",[d objectForKey:CHARTSETVALUE]]];
        }
    }
    //当前温度值
    PNPlot *plot1 = [[PNPlot alloc] init];
    plot1.plottingValues = plottingDataValues1;
    plot1.lineColor = DEFAULTITLECOLORRGB(7, 166, 206);
    plot1.lineWidth = 1.5;
    [self.lineChartView addPlot:plot1];
    //设定温度值
    PNPlot *plot2 = [[PNPlot alloc] init];
    plot2.plottingValues = plottingDataValues2;
    plot2.lineColor = DEFAULTITLECOLORRGB(210, 91, 44);
    plot2.lineWidth = 1.5;
    [self.lineChartView  addPlot:plot2];
}

- (void)closeAll
{
    if(self.mTimer){
        [self.mTimer invalidate];
        self.mTimer=nil;
    }
}

@end