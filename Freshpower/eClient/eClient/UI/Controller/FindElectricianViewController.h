//
//  FindElectricianViewController.h
//  eClient
//
//  Created by Start on 3/21/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "BaseEGOTableViewPullRefreshViewController.h"
#import <MapKit/MapKit.h>

@interface FindElectricianViewController : BaseEGOTableViewPullRefreshViewController<MKMapViewDelegate,CLLocationManagerDelegate>

@property MKMapView *mapView;
@property CLLocationManager *locationManager;

@end
