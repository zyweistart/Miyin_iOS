//
//  MainViewController.h
//  BBQ
//
//  Created by Start on 15/7/27.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "BaseTableViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface MainViewController : BaseTableViewController<CBCentralManagerDelegate,CBPeripheralDelegate>

@property(strong,nonatomic)NSMutableData *mutableData;
@property(strong,nonatomic)NSMutableString *mutableString;

@property(strong,nonatomic)CBPeripheral *peripheral;
@property(strong,nonatomic)CBCentralManager *centralManager;

@end
