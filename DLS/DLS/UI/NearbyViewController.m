//
//  NearbyViewController.m
//  DLS
//
//  Created by Start on 3/2/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "NearbyViewController.h"
#import "SearchView.h"
#import "CustomAnnotation.h"

#define ZOOMLEVEL 0.05f
#define SEARCHTIPCOLOR [UIColor colorWithRed:(88/255.0) green:(130/255.0) blue:(216/255.0) alpha:1]

@interface NearbyViewController ()

@end

@implementation NearbyViewController{
    NSArray *dataItemArray;
}

- (id)init{
    self=[super init];
    if(self){
        //搜索框架
        SearchView *searchView=[[SearchView alloc]initWithFrame:CGRectMake1(0, 0, 250, 30)];
        [searchView setController:self];
        [self navigationItem].titleView=searchView;
        //右切换按钮
        UIButton *btnMap = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnMap setBackgroundImage:[UIImage imageNamed:@"list"]forState:UIControlStateNormal];
        [btnMap addTarget:self action:@selector(goMapOrList:) forControlEvents:UIControlEventTouchUpInside];
        btnMap.frame = CGRectMake(0, 0, 24, 20);
        UIBarButtonItem *negativeSpacerRight = [[UIBarButtonItem alloc]
                                                initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                target:nil action:nil];
        negativeSpacerRight.width = -5;
        self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacerRight, [[UIBarButtonItem alloc] initWithCustomView:btnMap], nil];
        
        //创建地图
        self.mapView=[[MKMapView alloc]initWithFrame:[self.view bounds]];
        [self.mapView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.mapView setDelegate:self];
        [self.mapView setMapType:MKMapTypeStandard];
        [self.mapView setShowsUserLocation:YES];
        [self.mapView setZoomEnabled:YES];
        [self.mapView setScrollEnabled:YES];
        [self.view addSubview:self.mapView];
        //刷新位置点数据
        UIButton *refresh=[[UIButton alloc]initWithFrame:CGRectMake1(270, 10, 33, 33)];
        [refresh setImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
        [refresh addTarget:self action:@selector(goRefreshMapData) forControlEvents:UIControlEventTouchDown];
        [self.mapView addSubview:refresh];
        //定位到当前位置
        UIButton *currentLocation=[[UIButton alloc]initWithFrame:
                                   CGRectMake1(270, 53, 33, 33)];
        [currentLocation setImage:[UIImage imageNamed:@"mylocation"] forState:UIControlStateNormal];
        [currentLocation addTarget:self action:@selector(goCurrentLocation) forControlEvents:UIControlEventTouchDown];
        [self.mapView addSubview:currentLocation];
        
        //定位管理
        self.locationManager = [CLLocationManager new];
#ifdef __IPHONE_8_0
        if(IS_OS_8_OR_LATER) {
            [self.locationManager requestWhenInUseAuthorization];
            [self.locationManager requestAlwaysAuthorization];
        }
#endif
        [self.locationManager setDelegate:self];
        [self.locationManager setDistanceFilter:kCLDistanceFilterNone];
        [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [self.locationManager startUpdatingLocation];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self goCurrentLocation];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                [self.locationManager requestAlwaysAuthorization];
            }
            break;
        case kCLAuthorizationStatusDenied:
            NSLog(@"请在设置-隐私-定位服务中开启定位功能！");
            break;
        case kCLAuthorizationStatusRestricted:
            NSLog(@"定位服务无法使用！");
        default:
            break;
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id)annotation {
    if([annotation isKindOfClass:[CustomAnnotation class]]){
        //附近点
        static NSString *CPinIdentifier = @"Pin";
        CustomAnnotation *myAnnotation = (CustomAnnotation*)annotation;
        MKPinAnnotationView *annView = (MKPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:CPinIdentifier];
        if(nil == annView) {
            annView = [[MKPinAnnotationView alloc] initWithAnnotation:myAnnotation reuseIdentifier:CPinIdentifier];
        }
        int tag=[myAnnotation index];
        NSDictionary *data=[dataItemArray objectAtIndex:tag];
        NSString *ClassId=[NSString stringWithFormat:@"%@",[data objectForKey:@"ClassId"]];
        if([@"41" isEqualToString:ClassId]){
            [annView setImage:[UIImage imageNamed:@"求租点"]];
        }else{
            [annView setImage:[UIImage imageNamed:@"出租点"]];
        }
        UIButton *icon=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20,20)];
        [icon setImage:[UIImage imageNamed:@"category2"] forState:UIControlStateNormal];
        annView.rightCalloutAccessoryView=icon;
        [[annView rightCalloutAccessoryView] setTag:tag];
        [[annView rightCalloutAccessoryView] addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickGoDetail:)]];
        [annView setEnabled:YES];
        [annView setCanShowCallout:YES];
        return annView;
    }else{
        return nil;
    }
}

//定位到当前位置
- (void)goCurrentLocation
{
    MKCoordinateRegion region;
    region.center=[[self.locationManager location] coordinate];
    region.span.longitudeDelta = ZOOMLEVEL;
    region.span.longitudeDelta = ZOOMLEVEL;
    [self.mapView setRegion:region animated:YES];
}
//刷新地图位置数据
- (void)goRefreshMapData
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"30.33088" forKey:@"Latitude"];
    [params setObject:@"120.198387" forKey:@"longitude"];
    [params setObject:@"500000" forKey:@"scope"];
    [params setObject:@"1" forKey:@"index"];
    [params setObject:@"41,42" forKey:@"classId"];
    [params setObject:@"0" forKey:@"size"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest handle:@"GetListPageMap" requestParams:params];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if([response successFlag]){
        //清除地图上的位置点
        [self.mapView removeAnnotations:[self.mapView annotations]];
        
        dataItemArray=[[[response resultJSON]objectForKey:@"Data"]objectForKey:@"Tab"];
        for(int i=0;i<[dataItemArray count];i++){
            NSDictionary *data=[dataItemArray objectAtIndex:i];
            NSString *location=[data objectForKey:@"location"];
            NSArray *array=[location componentsSeparatedByString:@","];
            NSString *latitude=[array objectAtIndex:0];
            NSString *longitude=[array objectAtIndex:1];
            CustomAnnotation *annotation1 = [[CustomAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake([longitude doubleValue],[latitude doubleValue])];
            annotation1.title = [data objectForKey:@"Name"];
            annotation1.subtitle = @"点击联系此信息";
            [annotation1 setIndex:i];
            [self.mapView addAnnotation:annotation1];
        }
    }
}

- (void)onClickGoDetail:(UITapGestureRecognizer *)sender
{
    NSInteger tag=[sender.view tag];
    NSLog(@"当前的tag=%d",tag);
}

//切换地图或列表
- (void)goMapOrList:(UIButton*)sender
{
    NSLog(@"切换成功了");
}

@end