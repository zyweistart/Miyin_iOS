//
//  STChartViewController.m
//  ElectricianRun
//
//  Created by Start on 3/18/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STChartViewController.h"
#import "STBaseUserExperienceViewController.h"

//保存最近12个每条进出线的电流IA、IB、IC的值
extern double allPhaseCurrentList[12][2][4][3];
//保存最近12个每条进出线的负荷数
extern double allTotalBurden[12][2][4];
//保存最近12个每条进出线的电量
extern double allTotalElectricity[12][2][4];
//保存最近12个每条进出线的电费
extern double allTotalElectricityVal[12][2][4];
extern int allPhaseCurrentListCount;
extern int allTotalElectricityCount;
@interface STChartViewController ()

@end

@implementation STChartViewController {
    NSTimer *timer;
    NSMutableDictionary *charts;
    NSMutableDictionary *chartNames;
    NSInteger currentIndex;
    NSInteger currentType;
    NSInteger count;
}

- (id)initWithIndex:(int)index Type:(int)type
{
    currentType=type;
    currentIndex=index;
    NSString *lineName=nil;
    if(currentIndex==0){
        lineName=@"进线A";
    }else if(currentIndex==1){
        lineName=@"出线A-1";
    }else if(currentIndex==2){
        lineName=@"出线A-2";
    }else if(currentIndex==3){
        lineName=@"出线A-3";
    }else if(currentIndex==4){
        lineName=@"进线B";
    }else if(currentIndex==5){
        lineName=@"出线B-1";
    }else if(currentIndex==6){
        lineName=@"出线B-2";
    }else if(currentIndex==7){
        lineName=@"出线B-3";
    }
    
    charts=[[NSMutableDictionary alloc]init];
    [charts setValue:@"ChartElectricCurrentLine" forKey:@"0"];
    [charts setValue:@"ChartBurdenLine" forKey:@"1"];
    [charts setValue:@"ChartElectricity" forKey:@"2"];
    [charts setValue:@"ChartElectricityVal" forKey:@"3"];
    [charts setValue:@"ChartElectricityPie" forKey:@"4"];
    [charts setValue:@"ChartElectricityPieVal" forKey:@"5"];
    
    chartNames=[[NSMutableDictionary alloc]init];
    [chartNames setValue:[NSString stringWithFormat:@"%@电流曲线图",lineName] forKey:@"0"];
    [chartNames setValue:[NSString stringWithFormat:@"%@负荷曲线图",lineName] forKey:@"1"];
    [chartNames setValue:[NSString stringWithFormat:@"%@电耗量柱状图",lineName] forKey:@"2"];
    [chartNames setValue:[NSString stringWithFormat:@"%@电费柱状图",lineName] forKey:@"3"];
    [chartNames setValue:[NSString stringWithFormat:@"%@尖峰谷电量饼图",lineName] forKey:@"4"];
    [chartNames setValue:[NSString stringWithFormat:@"%@尖峰谷电费饼图",lineName] forKey:@"5"];
    
    self = [super init];
    if (self) {
        self.title=[chartNames objectForKey:[NSString stringWithFormat:@"%d",currentType]];
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        if(currentType==0||currentType==1){
            count=REFRESHNUM1;
        }else if(currentType==2||currentType==3){
            count=REFRESHNUM2;
        }else{
            count=0;
        }
        
        self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
        [self.webView setUserInteractionEnabled:YES];
        [self.webView setScalesPageToFit:YES];
        [self.webView setBackgroundColor:[UIColor clearColor]];
        [self.webView setOpaque:NO];//使网页透明
//        NSString *path = [[NSBundle mainBundle] pathForResource:[charts objectForKey:[NSString stringWithFormat:@"%d",currentType]] ofType:@"html"];
        
        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"ichartjs.bundle/%@.html",[charts objectForKey:[NSString stringWithFormat:@"%d",currentType]]]];
        
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath: path]]];
        [self.webView setDelegate:self];
        [self.view addSubview:self.webView];
        
    }
    return self;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //初始化先调用一次
    [self updateChartValue];
    if(count>0){
        //每隔5秒调用一次
        timer = [NSTimer scheduledTimerWithTimeInterval:count target:self selector:@selector(updateChartValue) userInfo:nil repeats:YES];
    }
}

- (void)updateChartValue
{
    
    int d=allPhaseCurrentListCount>=12?0:(12-allPhaseCurrentListCount%12);
    int c=allTotalElectricityCount>=12?0:(12-allTotalElectricityCount%12);
    
    NSMutableArray *data=[[NSMutableArray alloc]init];
    if(currentType==0){
        NSMutableArray *v0=[[NSMutableArray alloc]init];
        for(int i=d;i<12;i++){
            float f=1443.4;
            if(currentIndex==1||currentIndex==5){
                f=f*0.2;
            }else if(currentIndex==2||currentIndex==6){
                f=f*0.3;
            }else if(currentIndex==3||currentIndex==7){
                f=f*0.5;
            }
            [v0 addObject:[[NSNumber alloc]initWithFloat:f]];
        }
        NSMutableDictionary *d0=[[NSMutableDictionary alloc]init];
        [d0 setValue:@"最大阀值" forKey:@"name"];
        [d0 setValue:v0 forKey:@"value"];
        [d0 setValue:@"#37378b" forKey:@"color"];
        [d0 setValue:[[NSNumber alloc]initWithFloat:1] forKey:@"line_width"];
        [data addObject:d0];
        
        NSMutableArray *v1=[[NSMutableArray alloc]init];
        for(int i=d;i<12;i++){
            float f=allPhaseCurrentList[i][currentIndex/4][currentIndex%4][0];
            f=[[NSString stringWithFormat:@"%.2f", f]floatValue];
            [v1 addObject:[[NSNumber alloc]initWithFloat:f]];
        }
        NSMutableDictionary *d1=[[NSMutableDictionary alloc]init];
        [d1 setValue:@"A相" forKey:@"name"];
        [d1 setValue:v1 forKey:@"value"];
        [d1 setValue:@"#89a54e" forKey:@"color"];
        [d1 setValue:[[NSNumber alloc]initWithFloat:1] forKey:@"line_width"];
        [data addObject:d1];
        
        NSMutableArray *v2=[[NSMutableArray alloc]init];
        for(int i=d;i<12;i++){
            float f=allPhaseCurrentList[i][currentIndex/4][currentIndex%4][1];
            f=[[NSString stringWithFormat:@"%.2f", f]floatValue];
            [v2 addObject:[[NSNumber alloc]initWithFloat:f]];
        }
        NSMutableDictionary *d2=[[NSMutableDictionary alloc]init];
        [d2 setValue:@"B相" forKey:@"name"];
        [d2 setValue:v2 forKey:@"value"];
        [d2 setValue:@"#1f7e92" forKey:@"color"];
        [d2 setValue:[[NSNumber alloc]initWithFloat:1] forKey:@"line_width"];
        [data addObject:d2];
        
        NSMutableArray *v3=[[NSMutableArray alloc]init];
        for(int i=d;i<12;i++){
            float f=allPhaseCurrentList[i][currentIndex/4][currentIndex%4][2];
            f=[[NSString stringWithFormat:@"%.2f", f]floatValue];
            [v3 addObject:[[NSNumber alloc]initWithFloat:f]];
        }
        NSMutableDictionary *d3=[[NSMutableDictionary alloc]init];
        [d3 setValue:@"C相" forKey:@"name"];
        [d3 setValue:v3 forKey:@"value"];
        [d3 setValue:@"#aa4643" forKey:@"color"];
        [d3 setValue:[[NSNumber alloc]initWithFloat:1] forKey:@"line_width"];
        [data addObject:d3];
        
    }else if(currentType==1){
        NSMutableArray *v=[[NSMutableArray alloc]init];
        for(int i=d;i<12;i++){
            float f=allTotalBurden[i][currentIndex/4][currentIndex%4]/1000;
            f=[[NSString stringWithFormat:@"%.2f", f]floatValue];
            [v addObject:[[NSNumber alloc]initWithFloat:f]];
        }
        NSMutableDictionary *d1=[[NSMutableDictionary alloc]init];
        [d1 setValue:v forKey:@"value"];
        [d1 setValue:@"当前负荷" forKey:@"name"];
        [d1 setValue:@"#1f7e92" forKey:@"color"];
        [d1 setValue:[[NSNumber alloc]initWithFloat:3] forKey:@"line_width"];
        [data addObject:d1];
    }else if(currentType==2){
        int num=0;
        for(int i=c;i<12;i++){
            float f=allTotalElectricity[i][currentIndex/4][currentIndex%4];
            f=[[NSString stringWithFormat:@"%.2f", f]floatValue];
            NSMutableDictionary *d1=[[NSMutableDictionary alloc]init];
            [d1 setValue:[NSString stringWithFormat:@"%d",++num] forKey:@"name"];
            [d1 setValue:[[NSNumber alloc]initWithFloat:f] forKey:@"value"];
            [d1 setValue:@"#4572a7" forKey:@"color"];
            [data addObject:d1];
        }
        for(int i=0;i<c;i++){
            float f=0;
            NSMutableDictionary *d1=[[NSMutableDictionary alloc]init];
            [d1 setValue:[NSString stringWithFormat:@"%d",++num] forKey:@"name"];
            [d1 setValue:[[NSNumber alloc]initWithFloat:f] forKey:@"value"];
            [d1 setValue:@"#4572a7" forKey:@"color"];
            [data addObject:d1];
        }
    }else if(currentType==3){
        int num=0;
        for(int i=c;i<12;i++){
            float f=allTotalElectricityVal[i][currentIndex/4][currentIndex%4];
            f=[[NSString stringWithFormat:@"%.2f", f]floatValue];
            NSMutableDictionary *d1=[[NSMutableDictionary alloc]init];
            [d1 setValue:[NSString stringWithFormat:@"%d",++num] forKey:@"name"];
            [d1 setValue:[[NSNumber alloc]initWithFloat:f] forKey:@"value"];
            [d1 setValue:@"#4572a7" forKey:@"color"];
            [data addObject:d1];
        }
        for(int i=0;i<c;i++){
            float f=0;
            NSMutableDictionary *d1=[[NSMutableDictionary alloc]init];
            [d1 setValue:[NSString stringWithFormat:@"%d",++num] forKey:@"name"];
            [d1 setValue:[[NSNumber alloc]initWithFloat:f] forKey:@"value"];
            [d1 setValue:@"#4572a7" forKey:@"color"];
            [data addObject:d1];
        }
    }else if(currentType==4){
        NSMutableDictionary *d1=[[NSMutableDictionary alloc]init];
        [d1 setValue:@"谷电量" forKey:@"name"];
        [d1 setValue:[[NSNumber alloc]initWithFloat:4000] forKey:@"value"];
        [d1 setValue:@"#4572a7" forKey:@"color"];
        [data addObject:d1];
        
        NSMutableDictionary *d2=[[NSMutableDictionary alloc]init];
        [d2 setValue:@"尖电量" forKey:@"name"];
        [d2 setValue:[[NSNumber alloc]initWithFloat:720] forKey:@"value"];
        [d2 setValue:@"#aa4643" forKey:@"color"];
        [data addObject:d2];
        
        NSMutableDictionary *d3=[[NSMutableDictionary alloc]init];
        [d3 setValue:@"峰电量" forKey:@"name"];
        [d3 setValue:[[NSNumber alloc]initWithFloat:7200] forKey:@"value"];
        [d3 setValue:@"#89a54e" forKey:@"color"];
        [data addObject:d3];
    }else if(currentType==5){
        float a=4000;
        float b=720;
        float c=7200;
        if(currentIndex==1||currentIndex==5){
            a=a*0.2;
            b=b*0.2;
            c=c*0.2;
        }else if(currentIndex==2||currentIndex==6){
            a=a*0.3;
            b=b*0.3;
            c=c*0.3;
        }else if(currentIndex==3||currentIndex==7){
            a=a*0.5;
            b=b*0.5;
            c=c*0.5;
        }
        double val=[STBaseUserExperienceViewController businessCalculationTime];
        
        a=a*val;
        b=b*val;
        c=c*val;
        
        NSMutableDictionary *d1=[[NSMutableDictionary alloc]init];
        [d1 setValue:@"谷电量" forKey:@"name"];
        [d1 setValue:[[NSNumber alloc]initWithFloat:a] forKey:@"value"];
        [d1 setValue:@"#4572a7" forKey:@"color"];
        [data addObject:d1];
        
        NSMutableDictionary *d2=[[NSMutableDictionary alloc]init];
        [d2 setValue:@"尖电量" forKey:@"name"];
        [d2 setValue:[[NSNumber alloc]initWithFloat:b] forKey:@"value"];
        [d2 setValue:@"#aa4643" forKey:@"color"];
        [data addObject:d2];
        
        NSMutableDictionary *d3=[[NSMutableDictionary alloc]init];
        [d3 setValue:@"峰电量" forKey:@"name"];
        [d3 setValue:[[NSNumber alloc]initWithFloat:c] forKey:@"value"];
        [d3 setValue:@"#89a54e" forKey:@"color"];
        [data addObject:d3];
    }
    NSString *jsonString = [[NSString alloc] initWithData:[Common toJSONData:data] encoding:NSUTF8StringEncoding];
    
    [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"refresh(%@);",jsonString]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if(timer){
        [timer invalidate];
    }
}

@end
