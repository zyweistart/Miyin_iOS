//
//  TIBLECBStandand.h
//  BBQ
//
//  Created by Start on 15/7/28.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreBluetooth/CBService.h>

#define NOTIFICATION_DIDCONNECTEDBLEDEVICE @"DIDCONNECTEDBLEDEVICE"
#define NOTIFICATION_STOPSCAN @"STOPSCAN"
#define NOTIFICATION_BLEDEVICEWITHRSSIFOUND @"BLEDEVICEWITHRSSIFOUND"
#define NOTIFICATION_SERVICEFOUNDOVER @"SERVICEFOUNDOVER"
#define NOTIFICATION_DOWNLOADSERVICEPROCESSSTEP @"DOWNLOADSERVICEPROCESSSTEP"

@interface TIBLECBStandand : NSObject<CBCentralManagerDelegate, CBPeripheralDelegate>{
    NSTimer *scanKeepTimer;
    Boolean isScan;
}

//可变长表格阵列，用来保存扫描到的所有 CBPeripheral 对象指针
@property (strong, nonatomic) NSMutableArray *peripherals;
//BLE中心管理器对象指针
@property (strong, nonatomic) CBCentralManager *CM;
//当前已进入连接状态的外围设备对象指针
@property (strong, nonatomic) CBPeripheral *activePeripheral;
//当前正在操作的特征值缓存
@property (strong, nonatomic) NSMutableArray *activeCharacteristics;
//当前正在操作的特征值缓存
@property (strong, nonatomic) NSMutableArray *activeDescriptors;
//当前正在操作的特征值缓存
@property (strong, nonatomic) NSString *mode;
@property (strong, nonatomic) CBService *activeService;

- (void)stopScan;
- (int)findBLEPeripherals:(int)timeout;

@end
