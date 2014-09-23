//
//  STIndexViewController.m
//  ElectricianClient
//
//  Created by Start on 3/25/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STIndexViewController.h"

#import "STWarnComapnyViewController.h"
#import "STWarnComapnySimulationDataViewController.h"
#import "STInspectionInfoViewController.h"
#import "STBurdenChartViewController.h"
#import "STBurdenListViewController.h"
#import "STBurdenDetailListViewController.h"
#import "STElectricityListViewController.h"
#import "STElectricityListSimulationDataViewController.h"
#import "STInspectionViewController.h"
#import "STSimulationData.h"
#import "STElectricityView.h"
#import "ETFoursquareImages.h"
#import "SQLiteOperate.h"

#define REQUESTCODEELECTRICITY 47328194
#define REQUESTCODEBURDEN 343214
#define REQUESTCODERUNOVERVIEW 43214

//保存最近12个每条进出线的负荷数
extern double allTotalBurden[12][2][4];

@interface STIndexViewController () <UIAlertViewDelegate>

@end

@implementation STIndexViewController {
    UIButton *currentDay;
    UIButton *currentMonth;
    int currentElectricityType;
    STElectricityView *electricityView;
    UIWebView *burdenWebView;
    UIWebView *runOverviewwebView;
    NSTimer *burdenTime;
    NSTimer *runOverViewTime;
    UIButton *btnRefreshRunOverView;
    STBurdenChartViewController *burdenChartViewController;
    SQLiteOperate *db;
    NSTimer *countdown;
    int counttimer;
    NSMutableArray *simulationElectricityData;
    double dayPriceElectricity;
    double monthPriceElectricity;
    double economizeFee;
    NSString *maxLineName;
    double maxLineValue;
    NSString *minLineName;
    double minLineValue;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    int IMAGEHEIGHT=199;
    
    ETFoursquareImages *foursquareImages = [[ETFoursquareImages alloc] initWithFrame:CGRectMake(0, 0, 320,IMAGEHEIGHT)];
    [foursquareImages setImagesHeight:IMAGEHEIGHT];
    
    NSMutableArray *images=[[NSMutableArray alloc]init];
    
    db=[[SQLiteOperate alloc]init];
    if([db openDB]){
        //创建文件管理器
        NSFileManager* fileManager = [NSFileManager defaultManager];
        //获取Documents主目录
        NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        //得到相应的Documents的路径
        NSString* docDir = [paths objectAtIndex:0];
        //更改到待操作的目录下
        [fileManager changeCurrentDirectoryPath:[docDir stringByExpandingTildeInPath]];
        NSString *sqlQuery = [NSString stringWithFormat:@"SELECT * FROM PIC ORDER BY ID limit %d offset 0",TOPIMAGENUM];
        NSMutableArray *indata=[db query1:sqlQuery];
        if(indata!=nil&&[indata count]>0){
            for(int i=0;i<[indata count];i++){
                NSString *name=[[indata objectAtIndex:i] objectForKey:@"name"];
                NSString *path = [docDir stringByAppendingPathComponent:name];
                //如果图标文件已经存在则进行显示否则进行下载
                if([fileManager fileExistsAtPath:path]){
                    [images addObject:[UIImage imageWithContentsOfFile:path]];
                }
            }
        }
    }
    //如果不够则加载默认的图片
    if([images count]==0){
        for(int i=0;i<TOPIMAGENUM;i++){
            [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"image%d",i+1]]];
        }
    }
    [foursquareImages setImages:images];
    
    [self.view addSubview:foursquareImages];
    
    UIScrollView *scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, IMAGEHEIGHT, 320, self.view.frame.size.height-IMAGEHEIGHT-49)];
    [scroll setBackgroundColor:[UIColor whiteColor]];
    scroll.contentSize = CGSizeMake(320,673.5);
    [scroll setScrollEnabled:YES];
    [self.view addSubview:scroll];
    
    //报警信息
    UIButton *btnGo=[[UIButton alloc]initWithFrame:CGRectMake(6,5, 152, 59)];
    [btnGo setBackgroundImage:[UIImage imageNamed:@"JB"] forState:UIControlStateNormal];
    [btnGo addTarget:self action:@selector(goAlarm:) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:btnGo];
    
    //巡检报告
    btnGo=[[UIButton alloc]initWithFrame:CGRectMake(162,5, 152, 59)];
    [btnGo setBackgroundImage:[UIImage imageNamed:@"XJ"] forState:UIControlStateNormal];
    [btnGo addTarget:self action:@selector(goInspection:) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:btnGo];
    ///////////////////////////////////////////////////
    //企业总负荷曲线
    UIView *burdenFrame=[[UIView alloc]initWithFrame:CGRectMake(0, 69, self.view.frame.size.width, 201.5)];
    UIView *burdenTopFrame=[[UIView alloc]initWithFrame:CGRectMake(4.25, 0, 311.5, 31.5)];
    [burdenTopFrame setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ftop"]]];
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 21.5)];
    [lbl setFont:[UIFont systemFontOfSize:12]];
    [lbl setTextColor:[UIColor blackColor]];
    [lbl setTextAlignment:NSTextAlignmentLeft];
    [lbl setText:@"企业总负荷曲线"];
    [burdenTopFrame addSubview:lbl];
    btnGo=[[UIButton alloc]initWithFrame:CGRectMake(240 ,5, 60, 21.5)];
    btnGo.titleLabel.font = [UIFont systemFontOfSize: 12.0];
    [btnGo setTitle:@"详细负荷" forState:UIControlStateNormal];
    [btnGo setBackgroundColor:BTNCOLORGB];
    [btnGo addTarget:self action:@selector(goBurden:) forControlEvents:UIControlEventTouchUpInside];
    [burdenTopFrame addSubview:btnGo];
    [burdenFrame addSubview:burdenTopFrame];
    UIView *burdenBottomFrame=[[UIView alloc]initWithFrame:CGRectMake(4, 31.5, 312, 170)];
    [burdenBottomFrame setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"dbottom"]]];
    //负荷曲线图
    burdenWebView=[[UIWebView alloc]initWithFrame:CGRectMake(5, 5,302,160)];
    [burdenWebView setScalesPageToFit:YES];
    [burdenWebView setOpaque:NO];//使网页透明
    [burdenWebView setBackgroundColor:[UIColor clearColor]];
    [burdenWebView setDelegate:self];
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"ichartjs.bundle/ChartIndexBurdenLine.html"];
    [burdenWebView setTag:11];
    [burdenWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
    [burdenBottomFrame addSubview:burdenWebView];
    
    [burdenFrame addSubview:burdenBottomFrame];
    [scroll addSubview:burdenFrame];
    ///////////////////////////////////////////////////
    //电量电费总揽
    UIView *electricityFrame=[[UIView alloc]initWithFrame:CGRectMake(0, 270.5, self.view.frame.size.width, 201.5)];
    UIView *electricityTopFrame=[[UIView alloc]initWithFrame:CGRectMake(4.25, 0, 311.5, 31.5)];
    [electricityTopFrame setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ftop"]]];
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 21.5)];
    [lbl setFont:[UIFont systemFontOfSize:12]];
    [lbl setTextColor:[UIColor blackColor]];
    [lbl setTextAlignment:NSTextAlignmentLeft];
    [lbl setText:@"电量电费总揽"];
    [electricityTopFrame addSubview:lbl];
    btnGo=[[UIButton alloc]initWithFrame:CGRectMake(240 ,5, 60, 21.5)];
    btnGo.titleLabel.font = [UIFont systemFontOfSize: 12.0];
    [btnGo setTitle:@"详细电费" forState:UIControlStateNormal];
    [btnGo setBackgroundColor:BTNCOLORGB];
    [btnGo addTarget:self action:@selector(goElectricity:) forControlEvents:UIControlEventTouchUpInside];
    [electricityTopFrame addSubview:btnGo];
    [electricityFrame addSubview:electricityTopFrame];
    UIView *electricityBottomFrame=[[UIView alloc]initWithFrame:CGRectMake(4, 31.5, 312, 170)];
    [electricityBottomFrame setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"dbottom"]]];
    //
    currentDay=[[UIButton alloc]initWithFrame:CGRectMake(1, 0, 155, 40)];
    currentDay.titleLabel.font=[UIFont systemFontOfSize:12.0f];
    [currentDay setTitle:@"昨日电量" forState:UIControlStateNormal];
    [currentDay setBackgroundColor:[UIColor colorWithRed:(55/255.0) green:(55/255.0) blue:(139/255.0) alpha:1]];
    [currentDay addTarget:self action:@selector(loadCurentDay:) forControlEvents:UIControlEventTouchUpInside];
    [electricityBottomFrame addSubview:currentDay];
    currentMonth=[[UIButton alloc]initWithFrame:CGRectMake(156, 0, 155, 40)];
    currentMonth.titleLabel.font=[UIFont systemFontOfSize:12.0f];
    [currentMonth setTitle:@"当月电量" forState:UIControlStateNormal];
    [currentMonth setBackgroundColor:[UIColor colorWithRed:(210/255.0) green:(85/255.0) blue:(24/255.0) alpha:1]];
    [currentMonth addTarget:self action:@selector(loadCurentMonth:) forControlEvents:UIControlEventTouchUpInside];
    [electricityBottomFrame addSubview:currentMonth];
    
    electricityView=[[STElectricityView alloc]initWithFrame:CGRectMake(5, 40, 302, 130)];
    [electricityBottomFrame addSubview:electricityView];
    [electricityFrame addSubview:electricityBottomFrame];
    [scroll addSubview:electricityFrame];
    ///////////////////////////////////////////////////
    //运行状态总揽
    UIView *runOverviewFrame=[[UIView alloc]initWithFrame:CGRectMake(0, 472, self.view.frame.size.width, 201.5)];
    UIView *runOverviewTopFrame=[[UIView alloc]initWithFrame:CGRectMake(4.25, 0, 311.5, 31.5)];
    [runOverviewTopFrame setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ftop"]]];
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 100, 21.5)];
    [lbl setFont:[UIFont systemFontOfSize:12]];
    [lbl setTextColor:[UIColor blackColor]];
    [lbl setTextAlignment:NSTextAlignmentLeft];
    [lbl setText:@"运行状态总揽"];
    [runOverviewTopFrame addSubview:lbl];
    btnRefreshRunOverView=[[UIButton alloc]initWithFrame:CGRectMake(240 ,5, 60, 21.5)];
    btnRefreshRunOverView.titleLabel.font = [UIFont systemFontOfSize: 12.0];
    [btnRefreshRunOverView setTitle:@"刷新" forState:UIControlStateNormal];
    [btnRefreshRunOverView setBackgroundColor:BTNCOLORGB];
    [btnRefreshRunOverView addTarget:self action:@selector(goRunOverviewRefresh:) forControlEvents:UIControlEventTouchUpInside];
    [runOverviewTopFrame addSubview:btnRefreshRunOverView];
    [btnRefreshRunOverView setHidden:YES];
    [runOverviewFrame addSubview:runOverviewTopFrame];
    UIView *runOverviewBottomFrame=[[UIView alloc]initWithFrame:CGRectMake(4, 31.5, 312, 170)];
    [runOverviewBottomFrame setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"dbottom"]]];
    //运行状态总缆
    runOverviewwebView=[[UIWebView alloc]initWithFrame:CGRectMake(5, 5,302,160)];
    [runOverviewwebView setScalesPageToFit:YES];
    [runOverviewwebView setOpaque:NO];//使网页透明
    [runOverviewwebView setBackgroundColor:[UIColor clearColor]];
    [runOverviewwebView setDelegate:self];
    [runOverviewwebView setTag:22];
    NSString *path2 = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"ichartjs.bundle/ChartIndexRunOverview.html"];
    [runOverviewwebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path2]]];
    [runOverviewBottomFrame addSubview:runOverviewwebView];
    [runOverviewFrame addSubview:runOverviewBottomFrame];
    [scroll addSubview:runOverviewFrame];
    
    foursquareImages.scrollView.contentSize = CGSizeMake(320, 320+IMAGEHEIGHT);
    [foursquareImages.pageControl setCurrentPageIndicatorTintColor:[UIColor colorWithRed:(28/255.f) green:(189/255.f) blue:(141/255.f) alpha:1.0]];
    
    [self loadCurentDay:nil];
    
    if([Account isLogin]){
        if(countdown!=nil){
            counttimer=0;
            [countdown invalidate];
            countdown=nil;
        }
    }else{
        burdenChartViewController=[[STBurdenChartViewController alloc]init];
        if(countdown==nil){
            counttimer=0;
            countdown = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countdownf) userInfo:nil repeats:YES];
        }
    }
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if(webView.tag==11){
        [self performSelector:@selector(loadBurdenData) withObject:nil afterDelay:0.5];
        if(burdenTime==nil){
            //每1分钟更新一次未登录则60分钟更新一次
            int timer=60*60;
            if([Account isLogin]){
                timer=60;
            }
            burdenTime= [NSTimer scheduledTimerWithTimeInterval:timer target:self selector:@selector(loadBurdenData) userInfo:nil repeats:YES];
        }
    }else if(webView.tag==22){
        [self performSelector:@selector(loadRunOverViewData) withObject:nil afterDelay:0.5];
        if(runOverViewTime==nil){
            //5秒更新一次
            runOverViewTime = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(loadRunOverViewData) userInfo:nil repeats:YES];
        }
    }
}

//报警
- (void)goAlarm:(id)sender
{
    if([Account isLogin]){
        UINavigationController *realTimeAlarmViewControllerNAV=[[UINavigationController alloc]initWithRootViewController:[[STWarnComapnyViewController alloc]initWithType:1]];
        realTimeAlarmViewControllerNAV.tabBarItem.image=[UIImage imageNamed:@"bj"];
        realTimeAlarmViewControllerNAV.tabBarItem.title=@"实时报警";
        UINavigationController *historyAlarmViewControllerNav=[[UINavigationController alloc]initWithRootViewController:[[STWarnComapnyViewController alloc]initWithType:2]];
        historyAlarmViewControllerNav.tabBarItem.image=[UIImage imageNamed:@"ls"];
        historyAlarmViewControllerNav.tabBarItem.title=@"历史报警";
        UITabBarController *alarmTableBarController=[[UITabBarController alloc]init];
        [alarmTableBarController setViewControllers:[[NSArray alloc]initWithObjects:
                                                     realTimeAlarmViewControllerNAV,
                                                     historyAlarmViewControllerNav,nil]];
        [self presentViewController:alarmTableBarController animated:YES completion:nil];
    }else{
        UINavigationController *realTimeWarnComapnySimulationDataViewControllerNAV=[[UINavigationController alloc]initWithRootViewController:[[STWarnComapnySimulationDataViewController alloc]initWithType:1]];
        realTimeWarnComapnySimulationDataViewControllerNAV.tabBarItem.image=[UIImage imageNamed:@"bj"];
        realTimeWarnComapnySimulationDataViewControllerNAV.tabBarItem.title=@"实时报警";
        UINavigationController *historyWarnComapnySimulationDataViewControllerNav=[[UINavigationController alloc]initWithRootViewController:[[STWarnComapnySimulationDataViewController alloc]initWithType:2]];
        historyWarnComapnySimulationDataViewControllerNav.tabBarItem.image=[UIImage imageNamed:@"ls"];
        historyWarnComapnySimulationDataViewControllerNav.tabBarItem.title=@"历史报警";
        UITabBarController *alarmTableBarController=[[UITabBarController alloc]init];
        [alarmTableBarController setViewControllers:[[NSArray alloc]initWithObjects:
                                                     realTimeWarnComapnySimulationDataViewControllerNAV,
                                                     historyWarnComapnySimulationDataViewControllerNav,nil]];
        [self presentViewController:alarmTableBarController animated:YES completion:nil];
    }
}

//巡检
- (void)goInspection:(id)sender
{
    if([Account isLogin]){
        UINavigationController *inspectionInfoViewControllerNav=[[UINavigationController alloc]initWithRootViewController:[[STInspectionInfoViewController alloc]init]];
        [self presentViewController:inspectionInfoViewControllerNav animated:YES completion:nil];
    }else{
        UINavigationController *inspectionViewControllerNav=[[UINavigationController alloc]initWithRootViewController:[[STInspectionViewController alloc]init]];
        [self presentViewController:inspectionViewControllerNav animated:YES completion:nil];
    }
}

//企业总负荷曲线
- (void)goBurden:(id)sender
{
    if([Account isLogin]){
        STBurdenDetailListViewController *burdenDetailListViewController=[[STBurdenDetailListViewController alloc]init];
        UINavigationController *burdenDetailListViewControllerNav=[[UINavigationController alloc]initWithRootViewController:burdenDetailListViewController];
        [self presentViewController:burdenDetailListViewControllerNav animated:YES completion:nil];
        [burdenDetailListViewController autoRefresh];
    }else{
        UINavigationController *burdenChartViewControllerNav=[[UINavigationController alloc]initWithRootViewController:burdenChartViewController];
        burdenChartViewControllerNav.tabBarItem.image=[UIImage imageNamed:@"lb"];
        burdenChartViewControllerNav.tabBarItem.title=@"主线接图";
        UINavigationController *burdenListViewControllerNav=[[UINavigationController alloc]initWithRootViewController:[[STBurdenListViewController alloc]init]];
        burdenListViewControllerNav.tabBarItem.image=[UIImage imageNamed:@"xl"];
        burdenListViewControllerNav.tabBarItem.title=@"列表形式";
        UITabBarController *alarmTableBarController=[[UITabBarController alloc]init];
        [alarmTableBarController setViewControllers:[[NSArray alloc]initWithObjects:
                                                     burdenChartViewControllerNav,
                                                     burdenListViewControllerNav,nil]];
        [self presentViewController:alarmTableBarController animated:YES completion:nil];
    }
}

//电量电费总揽
- (void)goElectricity:(id)sender
{
    if([Account isLogin]){
        STElectricityListViewController *electricityListViewController=[[STElectricityListViewController alloc]initWithSelectType:currentElectricityType];
        
        UINavigationController *electricityListViewControllerNav=[[UINavigationController alloc]initWithRootViewController:electricityListViewController];
        [self presentViewController:electricityListViewControllerNav animated:YES completion:nil];
        [electricityListViewController autoRefresh];
    }else{
        STElectricityListSimulationDataViewController *electricityListSimulationDataViewController=[[STElectricityListSimulationDataViewController alloc]init];
        [electricityListSimulationDataViewController setSelectTypeValue:currentElectricityType];
        [electricityListSimulationDataViewController setDataItemArray:self.dataItemArray];
        UINavigationController *electricityListSimulationDataViewControllerNav=[[UINavigationController alloc]initWithRootViewController:electricityListSimulationDataViewController];
        [self presentViewController:electricityListSimulationDataViewControllerNav animated:YES completion:nil];
    }
}

//电费按日
- (void)loadCurentDay:(id)sender
{
    [currentMonth setBackgroundColor:[UIColor colorWithRed:(210/255.0) green:(85/255.0) blue:(24/255.0) alpha:1]];
    [currentDay setBackgroundColor:[UIColor colorWithRed:(55/255.0) green:(55/255.0) blue:(139/255.0) alpha:1]];
    currentElectricityType=0;
    [self loadElectricityData];
}

//电费按月
- (void)loadCurentMonth:(id)sender
{
    [currentMonth setBackgroundColor:[UIColor colorWithRed:(55/255.0) green:(55/255.0) blue:(139/255.0) alpha:1]];
    [currentDay setBackgroundColor:[UIColor colorWithRed:(210/255.0) green:(85/255.0) blue:(24/255.0) alpha:1]];
    currentElectricityType=1;
    [self loadElectricityData];
}

//刷新运行状态总揽
- (void)goRunOverviewRefresh:(id)sender
{
    if([Account isLogin]){
        [btnRefreshRunOverView setHidden:NO];
        NSMutableDictionary *p=[[NSMutableDictionary alloc]init];
        [p setObject:[[Account getResultData]objectForKey:@"CP_ID"] forKey:@"CP_ID"];
        self.runOverViewRequest=[[HttpRequest alloc]init:self delegate:self responseCode:REQUESTCODERUNOVERVIEW];
        [self.runOverViewRequest setIsShowMessage:YES];
        [self.runOverViewRequest start:URLAppIndexRunStatus params:p];
    }
}

//企业日月电量电费
- (void)loadElectricityData
{
    if([Account isLogin]){
        NSMutableDictionary *p=[[NSMutableDictionary alloc]init];
        [p setObject:[[Account getResultData]objectForKey:@"CP_ID"] forKey:@"CP_ID"];
        [p setObject:currentElectricityType==0?@"Day":@"Month" forKey:@"SelectType"];
        self.electricityRequest=[[HttpRequest alloc]init:self delegate:self responseCode:REQUESTCODEELECTRICITY];
        [self.electricityRequest setIsShowMessage:YES];
        [self.electricityRequest start:URLAppComElec params:p];
    }else{
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH"];
        int hour=[[formatter stringFromDate:[NSDate date]] intValue];
        simulationElectricityData=[STSimulationData getElectricityData];
        
        float totalElectricity=[[simulationElectricityData objectAtIndex:hour==0?23:hour-1] floatValue];
        
        if(hour==0){
            hour=24;
        }
        
        if(currentElectricityType==0){
            [[[electricityView rv1]lbl1]setText:@"昨日"];
            totalElectricity=totalElectricity*hour;
        }else{
            [[[electricityView rv1]lbl1]setText:@"当月"];
            [formatter setDateFormat:@"dd"];
            int day=[[formatter stringFromDate:[NSDate date]] intValue];
            if(day>1){
                day-=1;
            }else{
                day=1;
            }
            totalElectricity=totalElectricity*day*24;
        }
        
        economizeFee=totalElectricity*0.512;
        
        dayPriceElectricity = 0.95 - [STSimulationData getBeforeAveragePrice];
        
        monthPriceElectricity = dayPriceElectricity*totalElectricity;
        
        //首页数据
        [[[electricityView rv2] lbl2]setText:[NSString stringWithFormat:@"%.2fkWh",totalElectricity]];
        float f1=totalElectricity*0.06;
        float fv1=f1*1.406;
        float f2=totalElectricity*0.6;
        float fv2=f2*1.108;
        float f3=totalElectricity*0.34;
        float fv3=f3*0.596;
        float totalv=fv1+fv2+fv3;
        [[[electricityView rv2] lbl3]setText:[NSString stringWithFormat:@"%.2f元",totalv]];
        [[[electricityView rv3] lbl2]setText:[NSString stringWithFormat:@"%.2fkWh",f1]];
        [[[electricityView rv3] lbl3]setText:[NSString stringWithFormat:@"%.2f元",fv1]];
        [[[electricityView rv4] lbl2]setText:[NSString stringWithFormat:@"%.2fkWh",f2]];
        [[[electricityView rv4] lbl3]setText:[NSString stringWithFormat:@"%.2f元",fv2]];
        [[[electricityView rv5] lbl2]setText:[NSString stringWithFormat:@"%.2fkWh",f3]];
        [[[electricityView rv5] lbl3]setText:[NSString stringWithFormat:@"%.2f元",fv3]];
        [[electricityView lblAvgPrice] setText:[NSString stringWithFormat:@"%.2f元/kWh",totalv/totalElectricity]];
        
        //详细电费数据
        double priceElectricity=0.06*1.406+0.6*1.108+0.34*0.596;
        
        self.dataItemArray=[[NSMutableArray alloc]init];
        
        double totalElectriBillcity=totalElectricity*priceElectricity;
        
        NSMutableArray *inScale=[STSimulationData getInScale];
        NSMutableArray *outScale=[STSimulationData getOutScale];
        
        double totalElectricityFirst=totalElectricity*[[inScale objectAtIndex:0]doubleValue];
        double totalElectricityBillFirst=totalElectriBillcity*[[inScale objectAtIndex:0]doubleValue];
        double totalElectricitySecond=totalElectricity*[[inScale objectAtIndex:1]doubleValue];
        double totalElectricityBillSecond=totalElectriBillcity*[[inScale objectAtIndex:1]doubleValue];
        
        NSMutableDictionary *data=[[NSMutableDictionary alloc]init];
        [data setObject:[STSimulationData getLineName:0] forKey:@"METER_NAME"];
        [data setObject:[NSString stringWithFormat:@"%.2fkWh",totalElectricityFirst] forKey:@"TotalPower"];
        [data setObject:[NSString stringWithFormat:@"%.2f元",totalElectricityBillFirst] forKey:@"TotalFee"];
        [data setObject:[NSString stringWithFormat:@"%.2f元/kWh",totalElectricityBillFirst/totalElectricityFirst] forKey:@"AvgPrice"];
        [self.dataItemArray addObject:data];
        
        data=[[NSMutableDictionary alloc]init];
        [data setObject:[STSimulationData getLineName:1] forKey:@"METER_NAME"];
        [data setObject:[NSString stringWithFormat:@"%.2fkWh",totalElectricityFirst*0.2] forKey:@"TotalPower"];
        [data setObject:[NSString stringWithFormat:@"%.2f元",totalElectricityBillFirst*[[outScale objectAtIndex:0]doubleValue]] forKey:@"TotalFee"];
        double b11 = (totalElectricityBillFirst*[[outScale objectAtIndex:0]doubleValue])/(totalElectricityFirst*0.2);
        [data setObject:[NSString stringWithFormat:@"%.2f元/kWh",b11] forKey:@"AvgPrice"];
        [self.dataItemArray addObject:data];
        
        data=[[NSMutableDictionary alloc]init];
        [data setObject:[STSimulationData getLineName:2] forKey:@"METER_NAME"];
        [data setObject:[NSString stringWithFormat:@"%.2fkWh",totalElectricityFirst*0.3] forKey:@"TotalPower"];
        [data setObject:[NSString stringWithFormat:@"%.2f元",totalElectricityBillFirst*[[outScale objectAtIndex:1]doubleValue]] forKey:@"TotalFee"];
        double b12 = (totalElectricityBillFirst*[[outScale objectAtIndex:1]doubleValue])/(totalElectricityFirst*0.3);
        [data setObject:[NSString stringWithFormat:@"%.2f元/kWh",b12] forKey:@"AvgPrice"];
        [self.dataItemArray addObject:data];
        
        data=[[NSMutableDictionary alloc]init];
        [data setObject:[STSimulationData getLineName:3] forKey:@"METER_NAME"];
        [data setObject:[NSString stringWithFormat:@"%.2fkWh",totalElectricityFirst*0.5] forKey:@"TotalPower"];
        [data setObject:[NSString stringWithFormat:@"%.2f元",totalElectricityBillFirst*[[outScale objectAtIndex:2]doubleValue]] forKey:@"TotalFee"];
        double b13 = (totalElectricityBillFirst*[[outScale objectAtIndex:2]doubleValue])/(totalElectricityFirst*0.5);
        [data setObject:[NSString stringWithFormat:@"%.2f元/kWh",b13] forKey:@"AvgPrice"];
        [self.dataItemArray addObject:data];
        
        data=[[NSMutableDictionary alloc]init];
        [data setObject:[STSimulationData getLineName:4] forKey:@"METER_NAME"];
        [data setObject:[NSString stringWithFormat:@"%.2fkWh",totalElectricitySecond] forKey:@"TotalPower"];
        [data setObject:[NSString stringWithFormat:@"%.2f元",totalElectricityBillSecond] forKey:@"TotalFee"];
        [data setObject:[NSString stringWithFormat:@"%.2f元/kWh",totalElectricityBillSecond/totalElectricitySecond] forKey:@"AvgPrice"];
        [self.dataItemArray addObject:data];
        
        data=[[NSMutableDictionary alloc]init];
        [data setObject:[STSimulationData getLineName:5] forKey:@"METER_NAME"];
        [data setObject:[NSString stringWithFormat:@"%.2fkWh",totalElectricitySecond*0.2] forKey:@"TotalPower"];
        [data setObject:[NSString stringWithFormat:@"%.2f元",totalElectricityBillSecond*[[outScale objectAtIndex:3]doubleValue]] forKey:@"TotalFee"];
        double b21 = (totalElectricityBillSecond*[[outScale objectAtIndex:3]doubleValue])/(totalElectricitySecond*0.2);
        [data setObject:[NSString stringWithFormat:@"%.2f元/kWh",b21] forKey:@"AvgPrice"];
        [self.dataItemArray addObject:data];
        
        data=[[NSMutableDictionary alloc]init];
        [data setObject:[STSimulationData getLineName:6] forKey:@"METER_NAME"];
        [data setObject:[NSString stringWithFormat:@"%.2fkWh",totalElectricitySecond*0.3] forKey:@"TotalPower"];
        [data setObject:[NSString stringWithFormat:@"%.2f元",totalElectricityBillSecond*[[outScale objectAtIndex:4]doubleValue]] forKey:@"TotalFee"];
        double b22 = (totalElectricityBillSecond*[[outScale objectAtIndex:4]doubleValue])/(totalElectricitySecond*0.3);
        [data setObject:[NSString stringWithFormat:@"%.2f元/kWh",b22] forKey:@"AvgPrice"];
        [self.dataItemArray addObject:data];
        
        data=[[NSMutableDictionary alloc]init];
        [data setObject:[STSimulationData getLineName:7] forKey:@"METER_NAME"];
        [data setObject:[NSString stringWithFormat:@"%.2fkWh",totalElectricitySecond*0.5] forKey:@"TotalPower"];
        [data setObject:[NSString stringWithFormat:@"%.2f元",totalElectricityBillSecond*[[outScale objectAtIndex:5]doubleValue]] forKey:@"TotalFee"];
        double b23 = (totalElectricityBillSecond*[[outScale objectAtIndex:5]doubleValue])/(totalElectricitySecond*0.3);
        [data setObject:[NSString stringWithFormat:@"%.2f元/kWh",b23] forKey:@"AvgPrice"];
        [self.dataItemArray addObject:data];
        
        double priceArr[6]={
            b11,b12,b13,
            b21,b22,b23
        };
        //找出最小值
        int minValueIndex=0;
        for(int i=1;i<6;i++){
            double minValue=priceArr[minValueIndex];
            double tmpValue=priceArr[i];
            if(tmpValue<minValue){
                minValueIndex=i;
            }
        }
        //找出最大值
        int maxValueIndex=0;
        for(int i=1;i<6;i++){
            double maxValue=priceArr[maxValueIndex];
            double tmpValue=priceArr[i];
            if(tmpValue>maxValue){
                maxValueIndex=i;
            }
        }
        
        minLineName=[STSimulationData getChildLineName:minValueIndex];
        minLineValue=priceArr[minValueIndex];
        maxLineName=[STSimulationData getChildLineName:maxValueIndex];
        maxLineValue=priceArr[maxValueIndex];
    }
}

//加载企业总负荷曲线数据
- (void)loadBurdenData
{
    if([Account isLogin]){
        NSMutableDictionary *p=[[NSMutableDictionary alloc]init];
        [p setObject:[[Account getResultData]objectForKey:@"CP_ID"] forKey:@"CP_ID"];
        self.burdenRequest=[[HttpRequest alloc]init:self delegate:self responseCode:REQUESTCODEBURDEN];
        [self.runOverViewRequest setIsShowMessage:NO];
        [self.runOverViewRequest setIsShowNetConnectionMessage:NO];
        [self.burdenRequest start:URLAppComFhReport params:p];
    }else{
        NSMutableDictionary *d1=[[NSMutableDictionary alloc]init];
        [d1 setValue:[STSimulationData getRandomChargeData] forKey:@"value"];
        [d1 setValue:@"当前负荷" forKey:@"name"];
        [d1 setValue:@"#1f7e92" forKey:@"color"];
        [d1 setValue:[[NSNumber alloc]initWithFloat:3] forKey:@"line_width"];
        NSMutableArray *jsondata=[[NSMutableArray alloc]init];
        [jsondata addObject:d1];
        
        NSString *jsonString = [[NSString alloc] initWithData:[Common toJSONData:jsondata] encoding:NSUTF8StringEncoding];
        [burdenWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"refresh(%@);",jsonString]];
    }
}

//加载运行总缆数据
- (void)loadRunOverViewData
{
    if([Account isLogin]){
        [btnRefreshRunOverView setHidden:NO];
        NSMutableDictionary *p=[[NSMutableDictionary alloc]init];
        [p setObject:[[Account getResultData]objectForKey:@"CP_ID"] forKey:@"CP_ID"];
        self.runOverViewRequest=[[HttpRequest alloc]init:self delegate:self responseCode:REQUESTCODERUNOVERVIEW];
        [self.runOverViewRequest setIsShowMessage:NO];
        [self.runOverViewRequest setIsShowNetConnectionMessage:NO];
        [self.runOverViewRequest start:URLAppIndexRunStatus params:p];
    }else{
        
        [btnRefreshRunOverView setHidden:YES];
        NSMutableArray *jsondata=[[NSMutableArray alloc]init];
        
        for(int i=0;i<2;i++){
            for(int j=0;j<4;j++){
                float value=allTotalBurden[11][i][j]/1000;
                NSMutableDictionary *d=[[NSMutableDictionary alloc]init];
                [d setValue:[STSimulationData getSimpleLineName:(i*4+j)] forKey:@"name"];
                [d setValue:[[NSNumber alloc]initWithInt:value] forKey:@"value"];
                float f=0.0;
                if(j==0){
                    f=value/1443;
                }else if(j==1){
                    f=value/200;
                }else if(j==2){
                    f=value/500;
                }else if(j==3){
                    f=value/800;
                }
                if(f>=0.9){
                    [d setValue:@"red" forKey:@"color"];
                }else if(f>0.5&&f<0.9){
                    [d setValue:@"yellow" forKey:@"color"];
                }else{
                    [d setValue:@"green" forKey:@"color"];
                }
                [jsondata addObject:d];
            }
        }
        
        NSString *jsonString = [[NSString alloc] initWithData:[Common toJSONData:jsondata] encoding:NSUTF8StringEncoding];
        [runOverviewwebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"refresh(%@);",jsonString]];
    }
}

- (void)requestFinishedByResponse:(Response*)response responseCode:(int)repCode
{
    if(repCode==REQUESTCODEBURDEN){
        //负荷曲线
        NSMutableArray *jsondata=[[NSMutableArray alloc]init];
        NSDictionary *data=[response resultJSON];
        if(data!=nil){
            NSDictionary *rows=[data objectForKey:@"Rows"];
            int result=[[rows objectForKey:@"result"] intValue];
            if(result==1){
                NSMutableArray *tmpData=[data objectForKey:@"ComFhList"];
                if(tmpData){
                    NSMutableArray *v=[[NSMutableArray alloc]init];
                    for(int i=0;i<[tmpData count];i++){
                        NSDictionary *d=[tmpData objectAtIndex:i];
                        float value=[[Common NSNullConvertEmptyString:[d objectForKey:@"负荷"]]floatValue];
                        if([tmpData count]-1==i&&value<=0){
                            break;
                        }
                        [v addObject:[[NSNumber alloc]initWithFloat:value]];
                    }
                    if([v count]==0){
                        [v addObject:[[NSNumber alloc]initWithFloat:0]];
                    }
                    NSMutableDictionary *d2=[[NSMutableDictionary alloc]init];
                    [d2 setValue:v forKey:@"value"];
                    [d2 setValue:@"当前负荷" forKey:@"name"];
                    [d2 setValue:@"#1f7e92" forKey:@"color"];
                    [jsondata addObject:d2];
                }
            }
        }
        if([jsondata count]==0){
            //在没有数据的情况下
            NSMutableDictionary *d=[[NSMutableDictionary alloc]init];
            NSMutableArray *v=[[NSMutableArray alloc]init];
            [v addObject:[[NSNumber alloc]initWithFloat:0]];
            [d setValue:v forKey:@"value"];
            [d setValue:@"当前负荷" forKey:@"name"];
            [d setValue:@"#1f7e92" forKey:@"color"];
            [d setValue:[[NSNumber alloc]initWithFloat:3] forKey:@"line_width"];
            [jsondata addObject:d];
        }
        NSString *jsonString = [[NSString alloc] initWithData:[Common toJSONData:jsondata] encoding:NSUTF8StringEncoding];
        [burdenWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"refresh(%@);",jsonString]];
    }else if(repCode==REQUESTCODERUNOVERVIEW){
        NSMutableArray *jsondata=[[NSMutableArray alloc]init];
        //运行总缆
        NSDictionary *data=[response resultJSON];
        if(data!=nil){
            NSDictionary *rows=[data objectForKey:@"Rows"];
            int result=[[rows objectForKey:@"result"] intValue];
            if(result==1){
                NSMutableArray *tmpData=[data objectForKey:@"IndexRunStatus"];
                if(tmpData){
                    for(NSDictionary *d in tmpData){
                        NSMutableDictionary *d2=[[NSMutableDictionary alloc]init];
                        [d2 setValue:[Common NSNullConvertEmptyString:[d objectForKey:@"METER_NAME"]] forKey:@"name"];
                        [d2 setValue:[[NSNumber alloc]initWithFloat:[[Common NSNullConvertEmptyString:[d objectForKey:@"I_VALUE"]]floatValue]] forKey:@"value"];
                        [d2 setValue:[Common NSNullConvertEmptyString:[d objectForKey:@"COLOR"]] forKey:@"color"];
                        [jsondata addObject:d2];
                    }
                }
            }
        }
        if([jsondata count]==0){
            //在没有数据的情况下
            NSMutableDictionary *d1=[[NSMutableDictionary alloc]init];
            [d1 setValue:@"空" forKey:@"name"];
            [d1 setValue:[[NSNumber alloc]initWithInt:0] forKey:@"value"];
            [d1 setValue:@"#ff0000" forKey:@"color"];
            [jsondata addObject:d1];
        }
        NSString *jsonString = [[NSString alloc] initWithData:[Common toJSONData:jsondata] encoding:NSUTF8StringEncoding];
        [runOverviewwebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"refresh(%@);",jsonString]];
    }else if(repCode==REQUESTCODEELECTRICITY){
        //电量电费
        NSDictionary *data=[response resultJSON];
        if(data!=nil){
            NSDictionary *rows=[data objectForKey:@"Rows"];
            int result=[[rows objectForKey:@"result"] intValue];
            if(result==1){
                NSMutableArray *tmpData=[data objectForKey:@"ComElec"];
                if(tmpData){
                    for(NSDictionary *d in tmpData){
                        [[electricityView lblAvgPrice] setText:[Common NSNullConvertEmptyString:[d objectForKey:@"AvgPrice"]]];
                        [[[electricityView rv2] lbl2]setText:[Common NSNullConvertEmptyString:[d objectForKey:@"TotalPower"]]];
                        [[[electricityView rv2] lbl3]setText:[Common NSNullConvertEmptyString:[d objectForKey:@"TotalFee"]]];
                        [[[electricityView rv3] lbl2]setText:[Common NSNullConvertEmptyString:[d objectForKey:@"TipPower"]]];
                        [[[electricityView rv3] lbl3]setText:[Common NSNullConvertEmptyString:[d objectForKey:@"TipFee"]]];
                        [[[electricityView rv4] lbl2]setText:[Common NSNullConvertEmptyString:[d objectForKey:@"PeakPower"]]];
                        [[[electricityView rv4] lbl3]setText:[Common NSNullConvertEmptyString:[d objectForKey:@"PeakFee"]]];
                        [[[electricityView rv5] lbl2]setText:[Common NSNullConvertEmptyString:[d objectForKey:@"ValleyPower"]]];
                        [[[electricityView rv5] lbl3]setText:[Common NSNullConvertEmptyString:[d objectForKey:@"ValleyFee"]]];
                        break;
                    }
                }else{
                    [Common alert:@"查询无数据"];
                }
            }else{
                [Common alert:[rows objectForKey:@"remark"]];
            }
        }else{
            [Common alert:@"数据解析异常"];
        }
    }
}

- (void)requestFailed:(int)repCode didFailWithError:(NSError *)error{
    
}

- (void)countdownf
{
    counttimer++;
    if(counttimer==30){
        NSMutableString *contentStr=[[NSMutableString alloc]init];
        if(dayPriceElectricity>=0){
            [contentStr appendFormat:@"今日平均电价高于上月平均电价%.2f元/kWh 。",dayPriceElectricity];
        }else{
            [contentStr appendFormat:@"今日平均电价低于上月平均电价%.2f元/kWh 。",fabs(dayPriceElectricity)];
        }
        if(monthPriceElectricity>=0){
            [contentStr appendFormat:@"本月将多支出%.2f元",monthPriceElectricity];
        }else{
            [contentStr appendFormat:@"本月将少支出%.2f元",fabs(monthPriceElectricity)];
        }
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"信息"
                              message:contentStr
                              delegate:self
                              cancelButtonTitle:@"继续体验"
                              otherButtonTitles:@"取消体验", nil];
        alert.tag=1;
        [alert show];
        [countdown setFireDate:[NSDate distantFuture]];
    }else if(counttimer==60){
        NSMutableString *contentStr=[[NSMutableString alloc]init];
        [contentStr appendFormat:@"今日平均电价最高的线路是%@，平均电价%.2f元/kWh。平均电价最低的线路是%@，平均电价%.2f元/kWh。",maxLineName,maxLineValue,minLineName,minLineValue];
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"信息"
                              message:contentStr
                              delegate:self
                              cancelButtonTitle:@"继续体验"
                              otherButtonTitles:@"取消体验", nil];
        alert.tag=2;
        [alert show];
        [countdown setFireDate:[NSDate distantFuture]];
    }else if(counttimer==90){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"信息"
                              message:[NSString stringWithFormat:@"企业的谷电利用率较低，若提升至50％，能够节费%.2f元",economizeFee]
                              delegate:nil
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:nil, nil];
        alert.tag=3;
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==1){
        if(buttonIndex==1){
            //取消体验
            [countdown invalidate];
            countdown=nil;
        }else{
            [countdown setFireDate:[NSDate date]];
        }
    }else if(alertView.tag==2){
        if(buttonIndex==1){
            //取消体验
            [countdown invalidate];
            countdown=nil;
        }else{
            [countdown setFireDate:[NSDate date]];
        }
    }else if(alertView.tag==3){
        [countdown invalidate];
        countdown=nil;
    }
}

@end