//
//  MapViewController.m
//  DLS
//
//  Created by Start on 5/19/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "MapViewController.h"
#import "CustomAnnotation.h"

#define ZOOMLEVEL 0.05f

@interface MapViewController ()

@end

@implementation MapViewController{
    double latitude,longitude;
}

- (id)initWithDictionary:(NSDictionary*)data{
    self=[super init];
    if(self){
        self.data=data;
        self.title=@"位置";
        
        //创建地图
        self.mapView=[[MKMapView alloc]initWithFrame:[self.view bounds]];
        [self.mapView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.mapView setDelegate:self];
        [self.mapView setMapType:MKMapTypeStandard];
        [self.mapView setShowsUserLocation:YES];
        [self.mapView setZoomEnabled:YES];
        [self.mapView setScrollEnabled:YES];
        [self.view addSubview:self.mapView];
        
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString *location=[Common getString:[self.data objectForKey:@"location"]];
    if(![@"" isEqualToString:location]){
        NSArray *array=[location componentsSeparatedByString:@","];
        NSString *lat=[array objectAtIndex:0];
        NSString *lng=[array objectAtIndex:1];
        CustomAnnotation *annotation1 = [[CustomAnnotation alloc] initWithCoordinate:CLLocationCoordinate2DMake([lng doubleValue],[lat doubleValue])];
        annotation1.title = [self.data objectForKey:@"Name"];
        //            annotation1.subtitle = @"点击联系此信息";
        [self.mapView addAnnotation:annotation1];
        MKCoordinateRegion region;
        region.center=CLLocationCoordinate2DMake([lng doubleValue],[lat doubleValue]);
        region.span.longitudeDelta = ZOOMLEVEL;
        region.span.longitudeDelta = ZOOMLEVEL;
        [self.mapView setRegion:region animated:YES];
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
        NSString *ClassId=[NSString stringWithFormat:@"%@",[self.data objectForKey:@"ClassId"]];
        if([@"41" isEqualToString:ClassId]){
            [annView setImage:[UIImage imageNamed:@"求租点"]];
        }else{
            [annView setImage:[UIImage imageNamed:@"出租点"]];
        }
        return annView;
    }else{
        return nil;
    }
}


@end
