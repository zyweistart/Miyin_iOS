//
//  FindElectricianViewController.m
//  eClient
//  找电工
//  Created by Start on 3/21/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "FindElectricianViewController.h"
#import "CustomAnnotation.h"
#import "ElectricianDetailViewController.h"
#import "MapCell.h"

#define ZOOMLEVEL 0.05f
#define SEARCHTIPCOLOR [UIColor colorWithRed:(88/255.0) green:(130/255.0) blue:(216/255.0) alpha:1]

@interface FindElectricianViewController ()

@end

@implementation FindElectricianViewController{
    UIButton *btnSwitch;
    BOOL isCurrentMap;
    double latitude,longitude;
    NSArray *currentPoints;
}

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"找电工"];
        //右切换按钮
        btnSwitch = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnSwitch setBackgroundImage:[UIImage imageNamed:@"list"]forState:UIControlStateNormal];
        [btnSwitch addTarget:self action:@selector(goMapOrList:) forControlEvents:UIControlEventTouchUpInside];
        btnSwitch.frame = CGRectMake(0, 0, 24, 20);
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:btnSwitch];
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
        
        isCurrentMap=YES;
        [self.tableView setHidden:YES];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(isCurrentMap){
        [self goCurrentLocation];
    }else{
        if([[self dataItemArray]count]==0){
            if(!self.tableView.pullTableIsRefreshing) {
                self.tableView.pullTableIsRefreshing=YES;
                [self performSelector:@selector(refreshTable) withObject:nil afterDelay:1.0f];
            }
        }
    }
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

//MapView委托方法，当定位自身时调用
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    CLLocationCoordinate2D loc = [userLocation coordinate];
    latitude=loc.latitude;
    longitude=loc.longitude;
    //放大地图到自身的经纬度位置。
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);
//    [self.mapView setRegion:region animated:YES];
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
        NSDictionary *data=[currentPoints objectAtIndex:[myAnnotation index]];
        NSString *IS_ONLINE=[NSString stringWithFormat:@"%@",[data objectForKey:@"IS_ONLINE"]];
        if([@"1" isEqualToString:IS_ONLINE]){
            //在线
            [annView setImage:[UIImage imageNamed:@"point"]];
        }else{
            //不在线
            [annView setImage:[UIImage imageNamed:@"nopoint"]];
        }
        UIButton *icon=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20,20)];
        [icon setImage:[UIImage imageNamed:@"勾"] forState:UIControlStateNormal];
        annView.rightCalloutAccessoryView=icon;
        [[annView rightCalloutAccessoryView] setTag:[myAnnotation index]];
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

//刷新列表数据
- (void)loadHttp
{
    [self goMapData:500];
}

//刷新地图位置数据
- (void)goRefreshMapData
{
    [self goMapData:501];
}

- (void)goMapData:(int)reqCode
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:[[User Instance]getUserName] forKey:@"imei"];
    [params setObject:[[User Instance]getPassword] forKey:@"authentication"];
    [params setObject:@"600201" forKey:@"GNID"];
    [params setObject:[NSString stringWithFormat:@"%lf",longitude] forKey:@"QTKEY"];
    [params setObject:[NSString stringWithFormat:@"%lf",latitude] forKey:@"QTVAL"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:reqCode];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest handle:URL_appDistributeTasks requestParams:params];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if(reqCode==500){
        [super requestFinishedByResponse:response requestCode:reqCode];
    }else if(reqCode==501){
        if([response successFlag]){
            //清除地图上的位置点
            [self.mapView removeAnnotations:[self.mapView annotations]];
            currentPoints=[[response resultJSON]objectForKey:@"table1"];
            for(int i=0;i<[currentPoints count];i++){
                NSDictionary *d=[currentPoints objectAtIndex:i];
                double lat=[[d objectForKey:@"LATITUDE"]doubleValue];
                double longit=[[d objectForKey:@"LONGITUDE"]doubleValue];
                NSString *MB=[d objectForKey:@"MB"];
                NSString *GRAB_COUNT=[d objectForKey:@"GRAB_COUNT"];
                NSString *IS_ONLINE=[NSString stringWithFormat:@"%@",[d objectForKey:@"IS_ONLINE"]];
                if([@"1" isEqualToString:IS_ONLINE]){
                    //在线
                    MB=[d objectForKey:@"mb2"];
                }
                CustomAnnotation *annotation1 = [[CustomAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake(lat,longit)];
                annotation1.title = MB;
                annotation1.subtitle =[NSString stringWithFormat:@"接单数:%@",GRAB_COUNT];
                [annotation1 setIndex:i];
                [self.mapView addAnnotation:annotation1];
            }
        }
    }
}

- (void)onClickGoDetail:(UITapGestureRecognizer *)sender
{
    NSInteger tag=[sender.view tag];
    NSDictionary *data=[currentPoints objectAtIndex:tag];
    [self.navigationController pushViewController:[[ElectricianDetailViewController alloc]initWithParams:data] animated:YES];
}

//切换地图或列表
- (void)goMapOrList:(UIButton*)sender
{
    if(isCurrentMap){
        [btnSwitch setBackgroundImage:[UIImage imageNamed:@"map"]forState:UIControlStateNormal];
        [self.mapView setHidden:YES];
        [self.tableView setHidden:NO];
        if(!self.tableView.pullTableIsRefreshing) {
            self.tableView.pullTableIsRefreshing=YES;
            [self performSelector:@selector(refreshTable) withObject:nil afterDelay:1.0f];
        }
    }else{
        [btnSwitch setBackgroundImage:[UIImage imageNamed:@"list"]forState:UIControlStateNormal];
        [self.mapView setHidden:NO];
        [self.tableView setHidden:YES];
    }
    isCurrentMap=!isCurrentMap;
}

- (CGFloat)tableView:tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.dataItemArray count]>0){
        return CGHeight(50);
    }else{
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.dataItemArray count]>0){
        static NSString *cellIdentifier = @"Cell";
        MapCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell) {
            cell = [[MapCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        NSDictionary *data=[self.dataItemArray objectAtIndex:[indexPath row]];
        NSString *IS_ONLINE=[NSString stringWithFormat:@"%@",[data objectForKey:@"IS_ONLINE"]];
        if([@"1" isEqualToString:IS_ONLINE]){
            [cell.image setImage:[UIImage imageNamed:@"point"]];
            NSString *md2=[data objectForKey:@"mb2"];
            [cell.lbl1 setText:[NSString stringWithFormat:@"电话:%@",md2]];
        }else{
            [cell.image setImage:[UIImage imageNamed:@"nopoint"]];
            NSString *MB=[data objectForKey:@"MB"];
            [cell.lbl1 setText:[NSString stringWithFormat:@"电话:%@",MB]];
        }
        [cell.lbl2 setText:[NSString stringWithFormat:@"评价:%@",[data objectForKey:@"NUM"]]];
//        [cell.lbl3 setText:[NSString stringWithFormat:@"距离:%@",[data objectForKey:@"DISTANCE"]]];
        [cell.lbl4 setText:[NSString stringWithFormat:@"接单:%@",[data objectForKey:@"GRAB_COUNT"]]];
        return cell;
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.dataItemArray count]>0){
        NSLog(@"didSelectRow");
    }
}

@end