//
//  VIPViewController.h
//  DLS
//  VIP
//  Created by Start on 3/2/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface VIPViewController : BaseViewController<MKMapViewDelegate,CLLocationManagerDelegate>

@property MKMapView *mapView;
@property CLLocationManager *locationManager;

@end
