//
//  TIBLECBStandand.m
//  BBQ
//
//  Created by Start on 15/7/28.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "TIBLECBStandand.h"

@implementation TIBLECBStandand

- (id)init
{
    self=[super init];
    if(self){
        self.CM = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    }
    return self;
}

- (void)stopScan
{
    [self.CM stopScan];
    isScan  = NO;
}

- (int)findBLEPeripherals:(int)timeout
{
    if (self.CM.state  != CBCentralManagerStatePoweredOn) {
        return -1;
    }
    if (scanKeepTimer == nil) {
        scanKeepTimer = [NSTimer scheduledTimerWithTimeInterval:(float)timeout target:self selector:@selector(scanTimer:) userInfo:nil repeats:NO];
    }
    [self stopScan];
    // Start scanning
    [self.CM scanForPeripheralsWithServices:nil options:0];
    isScan = YES;
    // Started scanning OK !
    return 0;
}

//定时扫描结束，打印BLE设备信息
- (void)scanTimer:(NSTimer*)timer {
    [self.CM stopScan];
    NSLog(@"//step_4 Stopped Scanning\r\n");
    NSLog(@"//step_4 Known peripherals : %ld\r\n",[self.peripherals count]);
    //    [self printKnownPeripherals];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:NOTIFICATION_STOPSCAN object: nil];
    //    timer = nil;
    scanKeepTimer = nil ;
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    switch ([central state]) {
        case CBCentralManagerStateUnsupported:
            break;
        case CBCentralManagerStateUnauthorized:
            break;
        case CBCentralManagerStatePoweredOff:
            break;
        case CBCentralManagerStatePoweredOn:
            //开始扫描
            break;
        case CBCentralManagerStateUnknown:
            break;
        default:
            break;
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSArray *rssiArray;
    NSNotificationCenter *nc;
    //NSLog(@"Scanner_Step_ 3: BLE MOUDLE 收到设备，发出通知 ！\r\n");
    NSLog(@"RSSI : %d\r\n",[RSSI intValue]);
    NSLog(@"advertisementData = %@",advertisementData);
    int i = 0 ;
    if (!self.peripherals) {
        //列表为空，第一次发现新设备
        self.peripherals = [[NSMutableArray alloc] initWithObjects:peripheral,nil];
    } else {
        //列表中有曾经发现的设备，如果重复发现则刷新，
        for(i = 0; i < self.peripherals.count; i++) {
            CBPeripheral *p = [self.peripherals objectAtIndex:i];
            //if ([self UUIDSAreEqual:p.UUID u2:peripheral.UUID]) {
            if (p.UUID == peripheral.UUID) {
                [self.peripherals replaceObjectAtIndex:i withObject:peripheral];
                //NSLog(@"//step_3 Duplicate UUID found updating ...\r\n");
                //发送外围设备的序号，以及RSSI通知
                rssiArray = [NSArray arrayWithObjects:[NSNumber numberWithInt:i],RSSI, nil];
                if(isScan) {
                    nc = [NSNotificationCenter defaultCenter];
                    [nc postNotificationName: NOTIFICATION_BLEDEVICEWITHRSSIFOUND object: rssiArray];
                }
                return;
            }
        }
        //发现的外围设备，被保存在对象的peripherals 缓冲中
        [self.peripherals addObject:peripheral];
        //NSLog(@"New UUID, adding\r\n");
    }
    //NSLog(@"//step_2 didDiscoverPeripheral\r\n");
    //发送外围设备的序号，以及RSSI通知
    rssiArray = [NSArray arrayWithObjects:[NSNumber numberWithInt:i],RSSI, nil];
    //NSLog(@"%@",rssiArray);
    if(isScan) {
        nc = [NSNotificationCenter defaultCenter];
        [nc postNotificationName:NOTIFICATION_BLEDEVICEWITHRSSIFOUND object: rssiArray];
        
    }
}

//中心设备成功连接BLE外围设备
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
//    NSLog(@"//step_7_1 Connection to peripheral with UUID : %s successfull\r\n",[self UUIDToString:peripheral.UUID]);
    self.activePeripheral = peripheral;
    //点击某个设备后，将这个设备对象作为参数，通知给属性列表窗体，在那个窗体中进行连接以及服务扫描操作。
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:NOTIFICATION_DIDCONNECTEDBLEDEVICE object: nil];
}


@end
