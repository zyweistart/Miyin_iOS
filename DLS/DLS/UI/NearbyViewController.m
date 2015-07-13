//
//  NearbyViewController.m
//  DLS
//
//  Created by Start on 3/2/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "NearbyViewController.h"
#import "SearchView.h"
#import "ProjectCell.h"
#import "CustomAnnotation.h"
#import "LoginViewController.h"
#import "QiuzuDetailViewController.h"
#import "RentalDetailViewController.h"

#define MERCATOR_RADIUS 85445659.44705395
#define ZOOMLEVEL 0.05f
#define SEARCHTIPCOLOR [UIColor colorWithRed:(88/255.0) green:(130/255.0) blue:(216/255.0) alpha:1]

@interface NearbyViewController ()

@end

@implementation NearbyViewController{
    int type;
    double latitude,longitude;
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
        
        [self buildTableViewWithView:self.view];
        
        type=1;
        [self.mapView setHidden:NO];
        [self.tableView setHidden:YES];
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
//    if(![[User Instance]isLogin]){
//        [self presentViewControllerNav:[[LoginViewController alloc]init]];
//    }else{
//        [self goCurrentLocation];
//    }
    [self performSelector:@selector(goCurrentLocation) withObject:nil];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
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

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id)annotation
{
    if([annotation isKindOfClass:[CustomAnnotation class]]){
        //附近点
        static NSString *CPinIdentifier = @"Pin";
        CustomAnnotation *myAnnotation = (CustomAnnotation*)annotation;
        MKPinAnnotationView *annView = (MKPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:CPinIdentifier];
        if(nil == annView) {
            annView = [[MKPinAnnotationView alloc] initWithAnnotation:myAnnotation reuseIdentifier:CPinIdentifier];
        }
        int tag=[myAnnotation index];
        NSDictionary *data=[self.dataItemArray objectAtIndex:tag];
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

- (void)mapView:(MKMapView *)_mapView regionDidChangeAnimated:(BOOL)animated {
    
//    NSLog(@"当前搜索的范围为:%d----%d", [self getZoomLevel],abs([self getZoomLevel]-20)*10000);
    
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    CLLocationCoordinate2D loc = [userLocation coordinate];
    latitude=loc.latitude;
    longitude=loc.longitude;
    //放大地图到自身的经纬度位置。
    //    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);
    //    [self.mapView setRegion:region animated:YES];
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

- (int)getZoomLevel {
    return 21-round(log2(self.mapView.region.span.longitudeDelta * MERCATOR_RADIUS * M_PI / (180.0 * self.mapView.bounds.size.width)));
}

- (void)loadHttp
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"35" forKey:@"Id"];
    [params setObject:@"1" forKey:@"access_token"];
    [params setObject:[NSString stringWithFormat:@"%ld",[self currentPage]] forKey:@"index"];

    double lat=longitude;
    double lng=latitude;
    int radius=abs([self getZoomLevel]-20)*100000;
    
    double degree=(24901*1609)/360.0;
    double raidusMile=radius;
    
    double dpmLat=1/degree;
    double radiusLat=dpmLat*raidusMile;
    double minLat=lat-radiusLat;
    double maxLat=lat+radiusLat;
    
    double mpdLng=degree*cos(lat*(M_PI/180));
    double dpmLng=1/mpdLng;
    double radiusLng=dpmLng*raidusMile;
    double minLng=lng+radiusLng;
    double maxLng=lng-radiusLng;
    NSMutableDictionary *search=[[NSMutableDictionary alloc]init];
    [search setObject:[NSString stringWithFormat:@"%lf",maxLat] forKey:@"maxX"];
    [search setObject:[NSString stringWithFormat:@"%lf",maxLng] forKey:@"maxY"];
    [search setObject:[NSString stringWithFormat:@"%lf",minLat] forKey:@"minX"];
    [search setObject:[NSString stringWithFormat:@"%lf",minLng] forKey:@"minY"];
    [params setObject:search forKey:@"search"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:501];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest handle:@"GetListALL" requestParams:params];
}

//刷新地图位置数据
- (void)goRefreshMapData
{
    self.currentPage=1;
    [self loadHttp];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    [super requestFinishedByResponse:response requestCode:reqCode];
    if([response successFlag]){
        if(type==1){
            //清除地图上的位置点
            [self.mapView removeAnnotations:[self.mapView annotations]];
            for(int i=0;i<[self.dataItemArray count];i++){
                NSDictionary *data=[self.dataItemArray objectAtIndex:i];
                NSString *location=[data objectForKey:@"location"];
                NSArray *array=[location componentsSeparatedByString:@","];
                NSString *lat=[array objectAtIndex:0];
                NSString *lng=[array objectAtIndex:1];
                CustomAnnotation *annotation1 = [[CustomAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake([lng doubleValue],[lat doubleValue])];
                annotation1.title = [data objectForKey:@"Name"];
                annotation1.subtitle = @"点击联系此信息";
                [annotation1 setIndex:i];
                [self.mapView addAnnotation:annotation1];
            }
        }
    }
}

- (void)onClickGoDetail:(UITapGestureRecognizer *)sender
{
    NSUInteger tag=[sender.view tag];
    NSDictionary *data=[self.dataItemArray objectAtIndex:tag];
    [self.navigationController pushViewController:[[QiuzuDetailViewController alloc]initWithDictionary:data] animated:YES];
}

//切换地图或列表
- (void)goMapOrList:(UIButton*)sender
{
    if(type==1){
        //切换到列表模式
        type=2;
        [self.mapView setHidden:YES];
        [self.tableView setHidden:NO];
    }else{
        //切换到地图模式
        type=1;
        [self.mapView setHidden:NO];
        [self.tableView setHidden:YES];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.dataItemArray count]>0){
        return CGHeight(85);
    }else{
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.dataItemArray count]>0){
        static NSString *CProjectCell = @"CProjectCell";
        ProjectCell *cell = [tableView dequeueReusableCellWithIdentifier:CProjectCell];
        if (cell == nil) {
            cell = [[ProjectCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier: CProjectCell];
        }
        NSUInteger row=[indexPath row];
        NSDictionary *d=[self.dataItemArray objectAtIndex:row];
        [cell setData:d];
        [[cell status]setHidden:YES];
        return cell;
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.dataItemArray count]>0){
        NSDictionary *data=[self.dataItemArray objectAtIndex:[indexPath row]];
        NSString *ClassId=[NSString stringWithFormat:@"%@",[data objectForKey:@"ClassId"]];
        if([@"41" isEqualToString:ClassId]){
            //出租
            [self.navigationController pushViewController:[[QiuzuDetailViewController alloc]initWithDictionary:data] animated:YES];
        }else if([@"42" isEqualToString:ClassId]){
            //求租
            [self.navigationController pushViewController:[[RentalDetailViewController alloc]initWithDictionary:data] animated:YES];
        }else if([@"44" isEqualToString:ClassId]){
            //VIP
            [self.navigationController pushViewController:[[QiuzuDetailViewController alloc]initWithDictionary:data] animated:YES];
        }
    }
}


@end