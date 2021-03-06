//
//  NearbyViewController.h
//  DLS
//  附近
//  Created by Start on 3/2/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseEGOTableViewPullRefreshViewController.h"
#import <MapKit/MapKit.h>

@interface NearbyViewController : BaseEGOTableViewPullRefreshViewController<MKMapViewDelegate,CLLocationManagerDelegate>

@property MKMapView *mapView;
@property CLLocationManager *locationManager;

@end
