//
//  LocationGetter.h
//  ElectricianRun
//
//  Created by Start on 3/11/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationGetter : NSObject<CLLocationManagerDelegate>

- (void)startUpdates;

- (void)stopUpdates;

@property (strong,nonatomic) CLLocationManager *locationManager;

@property (strong,nonatomic) CLLocation *currentLocation;

@end
