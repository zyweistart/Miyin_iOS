//
//  MapViewController.h
//  DLS
//
//  Created by Start on 5/19/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "BaseViewController.h"
#import <MapKit/MapKit.h>

@interface MapViewController : BaseViewController<MKMapViewDelegate,CLLocationManagerDelegate>

@property MKMapView *mapView;
@property CLLocationManager *locationManager;

@property NSDictionary *data;

- (id)initWithDictionary:(NSDictionary*)data;

@end
