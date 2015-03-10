//
//  LocationViewController.h
//  DLS
//
//  Created by Start on 3/10/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "BaseTableViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface LocationViewController : BaseTableViewController<CLLocationManagerDelegate>

@property (nonatomic, strong) NSMutableDictionary *cities;
@property (nonatomic, strong) NSMutableArray *keys; //城市首字母
@property (nonatomic, strong) NSMutableArray *arrayCitys;   //城市数据
@property (nonatomic, strong) NSMutableArray *arrayHotCity;

@property (strong, nonatomic) CLLocationManager* locationManager;

@end
