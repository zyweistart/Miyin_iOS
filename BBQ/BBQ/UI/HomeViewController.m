//
//  HomeViewController.m
//  BBQ
//
//  Created by Start on 15/7/27.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)init{
    self=[super init];
    if(self){
        [self cTitle:@"Home"];
        
        UIView *bottomView=[[UIView alloc]initWithFrame:CGRectMake1(0, 100, 120, 40)];
        [self.tableView setTableFooterView:bottomView];
        CButton *bDemo=[[CButton alloc]initWithFrame:CGRectMake1(20, 0, 120, 40) Name:@"Scan" Type:2];
        [bDemo addTarget:self action:@selector(goScan) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:bDemo];
        CButton *bScan=[[CButton alloc]initWithFrame:CGRectMake1(180, 0, 120, 40) Name:@"Stop" Type:2];
        [bScan addTarget:self action:@selector(goStop) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:bScan];
        
    }
    return self;
}

- (void)goScan
{
    [self initNotification];
    [self ScanPeripheral];
    MODEL = MODEL_NORMAL;
}

- (void)goStop
{
    [self stopScan];
}

- (void)ScanPeripheral
{
    if (self.appDelegate.bleManager.activePeripheral){
        //self.appDelegate.bleManager.activePeripheral.isConnected
        if(self.appDelegate.bleManager.activePeripheral.state==CBPeripheralStateConnected){
            [[self.appDelegate.bleManager CM] cancelPeripheralConnection:[self.appDelegate.bleManager activePeripheral]];
        }
    }
    [self.appDelegate.bleManager.peripherals removeAllObjects];
    [self.appDelegate.bleManager.activeCharacteristics removeAllObjects];
    [self.appDelegate.bleManager.activeDescriptors removeAllObjects];
    self.appDelegate.bleManager.activePeripheral = nil;
    self.appDelegate.bleManager.activeService = nil;
    
    //定时扫描持续时间 10 秒，之后打印扫描到的信息
    [self.appDelegate.bleManager findBLEPeripherals:10];
}

- (void)stopScan
{
    [self.appDelegate.bleManager stopScan];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc  removeObserver:self name:NOTIFICATION_DIDCONNECTEDBLEDEVICE object:nil];
    [nc  removeObserver:self name:NOTIFICATION_STOPSCAN object:nil];
    [nc  removeObserver:self name:NOTIFICATION_BLEDEVICEWITHRSSIFOUND object:nil];
    [nc  removeObserver:self name:NOTIFICATION_SERVICEFOUNDOVER object:nil];
    [nc  removeObserver:self name:NOTIFICATION_DOWNLOADSERVICEPROCESSSTEP object:nil];
}

- (void)initNotification
{
    //设定通知
    //发现BLE外围设备
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    //成功连接到指定外围BLE设备
    [nc addObserver: self
           selector: @selector(didConectedbleDevice:)
               name: NOTIFICATION_DIDCONNECTEDBLEDEVICE
             object: nil];
    [nc addObserver: self
           selector: @selector(stopScanBLEDevice:)
               name: NOTIFICATION_STOPSCAN
             object: nil];
    [nc addObserver: self
           selector: @selector(bleDeviceWithRSSIFound:)
               name: NOTIFICATION_BLEDEVICEWITHRSSIFOUND
             object: nil];
    [nc addObserver: self
           selector: @selector(ServiceFoundOver:)
               name: NOTIFICATION_SERVICEFOUNDOVER
             object: nil];
    [nc addObserver: self
           selector: @selector(DownloadCharacteristicOver:)
               name: NOTIFICATION_DOWNLOADSERVICEPROCESSSTEP
             object: nil];
    
}

//连接成功
- (void)didConectedbleDevice:(CBPeripheral *)peripheral
{
    NSLog(@" BLE 设备连接成功   ！\r\n");
    MODEL = MODEL_CONNECTING ;  //1
    [self.appDelegate.bleManager.activePeripheral discoverServices:nil];
}

//扫描ble设备
- (void)stopScanBLEDevice:(CBPeripheral *)peripheral
{
    NSLog(@" BLE外设 列表 被更新 ！\r\n");
}

//此方法刷新次数过多，会导致tableview界面无法刷新的情况发生
- (void)bleDeviceWithRSSIFound:(NSNotification *) notification
{
    NSLog(@" 更新RSSI 值 ！\r\n");
}

//服务发现完成之后的回调方法
- (void)ServiceFoundOver:(CBPeripheral *)peripheral
{
    NSLog(@" 获取所有的服务 ");
    MODEL = MODEL_SCAN;  //2
}

//成功扫描所有服务特征值
- (void)DownloadCharacteristicOver:(CBPeripheral *)peripheral
{
    MODEL = MODEL_CONECTED;  //3
    NSLog(@" 获取所有的特征值 ! \r\n");
}

@end
