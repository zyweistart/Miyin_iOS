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

@implementation NearbyViewController

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
    if([annotation isKindOfClass:[MKUserLocation class]]){
        //我的位置
        static NSString* CUserLocation = @"CUserLocation";
        MKPinAnnotationView* annView = (MKPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:CUserLocation];
        if(nil == annView) {
            annView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:CUserLocation];
        }
        return annView;
    }else{
        //附近点
        static NSString *CPinIdentifier = @"Pin";
        CustomAnnotation *myAnnotation = (CustomAnnotation*)annotation;
        MKPinAnnotationView *annView = (MKPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:CPinIdentifier];
        if(nil == annView) {
            annView = [[MKPinAnnotationView alloc] initWithAnnotation:myAnnotation reuseIdentifier:CPinIdentifier];
        }
        [annView setImage:[UIImage imageNamed:@"category1"]];
        UIButton *icon=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20,20)];
        [icon setImage:[UIImage imageNamed:@"category2"] forState:UIControlStateNormal];
        annView.rightCalloutAccessoryView=icon;
        [[annView rightCalloutAccessoryView] setTag:[myAnnotation index]];
        [[annView rightCalloutAccessoryView] addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickGoDetail:)]];
        [annView setEnabled:YES];
        [annView setCanShowCallout:YES];
        return annView;
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
    [params setObject:@"9" forKey:@"Id"];
    [params setObject:@"1" forKey:@"index"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest handle:@"GetListALL" requestParams:params];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if([response successFlag]){
        //清除地图上的位置点
        [self.mapView removeAnnotations:[self.mapView annotations]];
        double latitude[9]={29.997461006205593,29.990250398850474,29.936414481847535,29.942513384159106,29.987425482052284,29.985715624943672,30.168762870400922,29.948760652467562,29.968950031785944};
        double longitude[9]={120.6018155523682,120.54001745666507,120.57194647277835,120.57537970031741,120.657433838501,120.58688101257327,120.65537390197757,120.44440206970218,120.5882543035889};
        for(int i=0;i<9;i++){
            CustomAnnotation *annotation1 = [[CustomAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(latitude[i],longitude[i])];
            annotation1.title = @"新能量e电工";
            annotation1.subtitle = @"点击联系此电工";
            [annotation1 setIndex:i];
            [self.mapView addAnnotation:annotation1];
        }
    }
}

- (void)onClickGoDetail:(UITapGestureRecognizer *)sender
{
    NSInteger tag=[sender.view tag];
    NSLog(@"tag=%d",tag);
}

//切换地图或列表
- (void)goMapOrList:(UIButton*)sender
{
}

@end