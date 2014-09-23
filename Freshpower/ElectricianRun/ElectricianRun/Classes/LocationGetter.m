//
//  LocationGetter.m
//  ElectricianRun
//
//  Created by Start on 3/11/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "LocationGetter.h"

@implementation LocationGetter

- (void)startUpdates
{
    if (self.locationManager==nil){
        self.locationManager = [[CLLocationManager alloc] init];
        [self.locationManager setDelegate:self];
        //设置精确度
        [self.locationManager setDesiredAccuracy: kCLLocationAccuracyBest];
        self.locationManager.distanceFilter = 10;
        [self.locationManager startUpdatingLocation];
//        [self.locationManager startMonitoringSignificantLocationChanges];
        
    }
}

- (void)stopUpdates
{
    if(self.locationManager!=nil){
        [self.locationManager stopUpdatingLocation];
//        [self.locationManager stopMonitoringSignificantLocationChanges];
    }
}

//定位时候调用
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
//    NSLog(@"latitude: %.6f, longitude: %.6f\n",newLocation.coordinate.latitude,newLocation.coordinate.longitude);
    self.currentLocation=newLocation;
}

//定位出错时被调
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
}

@end
