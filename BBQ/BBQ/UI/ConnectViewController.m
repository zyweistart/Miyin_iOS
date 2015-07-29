//
//  ConnectViewController.m
//  BBQ
//
//  Created by Start on 15/7/28.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "ConnectViewController.h"
#import "TabBarFrameViewController.h"
#import "Tools.h"

@interface ConnectViewController ()

@end

@implementation ConnectViewController{
    CButton *bEnter;
}

- (id)init{
    self=[super init];
    if(self){
        [self cTitle:@"设备连接"];
        self.progressView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(180, 0, 30, 30)];
        [self.progressView setColor :[UIColor whiteColor]];
        [self RefreshStateNormal];
        [self buildTableViewWithView:self.view];
        
        UIView *bottomView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 120, 40)];
        [self.tableView setTableFooterView:bottomView];
        bEnter=[[CButton alloc]initWithFrame:CGRectMake1(20, 0, 280, 40) Name:@"Enter" Type:2];
        [bEnter setEnabled:NO];
        [bEnter addTarget:self action:@selector(goMainPage) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:bEnter];
        [self.tableView setTableFooterView:bottomView];
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self performSelector:@selector(startScan) withObject:nil afterDelay:0.5];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.appDelegate.bleManager.peripherals count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"TableCellIdentifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] ;
    }
    CBPeripheral *cbPeripheral = [self.appDelegate.bleManager.peripherals objectAtIndex:[indexPath row]];
    if(cbPeripheral.name !=nil) {
        cell.textLabel.text = [cbPeripheral name];
    } else {
        cell.textLabel.text = @"未知设备";
    }
    if (cbPeripheral == self.appDelegate.bleManager.activePeripheral) {
        //判定是哪一个蓝牙设备
        if (MODEL == MODEL_NORMAL) {
            [[cell detailTextLabel] setText: @"-----"];
        }else if (MODEL == MODEL_CONNECTING){
            [[cell detailTextLabel] setText: @"Connecting..."];
        }else if (MODEL == MODEL_SCAN){
            [[cell detailTextLabel] setText: @"Scanning..."];
        }else if (MODEL == MODEL_CONECTED){
            [[cell detailTextLabel] setText: @"Connected"];
            [bEnter setEnabled:YES];
            [bEnter setTitle:[NSString stringWithFormat:@"Enter %@",cbPeripheral.name] forState:UIControlStateNormal];
        }
    }
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.appDelegate.bleManager.activePeripheral){
        //self.appDelegate.bleManager.activePeripheral.isConnected
        if(self.appDelegate.bleManager.activePeripheral.state==CBPeripheralStateConnected){
            [self.appDelegate.bleManager.CM cancelPeripheralConnection:self.appDelegate.bleManager.activePeripheral];
        }
    }
    [self.appDelegate.bleManager.activeCharacteristics removeAllObjects];
    [self.appDelegate.bleManager.activeDescriptors removeAllObjects];
    self.appDelegate.bleManager.activePeripheral = nil;
    self.appDelegate.bleManager.activeService = nil;
    //发出通知新页面，对指定外围设备进行连接
    CBPeripheral *peripheral=[self.appDelegate.bleManager.peripherals objectAtIndex:indexPath.row];
    [self.appDelegate.bleManager connectPeripheral:peripheral];
}

- (void)RefreshStateStart
{
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithCustomView:_progressView];
    [_progressView startAnimating];
    [self.navigationItem setRightBarButtonItem:rightBtn];
}

- (void)RefreshStateNormal
{
    [_progressView stopAnimating];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(startScan)];
    [self.navigationItem setRightBarButtonItem:rightBtn];
}

//开始扫描
- (void)startScan
{
    [self initNotification];
    [self RefreshStateStart];
    [self ScanPeripheral];
    MODEL = MODEL_NORMAL;
}

//获取数据
- (void)startGetData
{
    [self.appDelegate.bleManager notification:0xFFE0 characteristicUUID:0xFFE4 p:self.appDelegate.bleManager.activePeripheral on:YES];
}

- (void)ScanPeripheral
{
    if (self.appDelegate.bleManager.activePeripheral) {
        if(self.appDelegate.bleManager.activePeripheral.state==CBPeripheralStateConnected){
            [[self.appDelegate.bleManager CM] cancelPeripheralConnection:[self.appDelegate.bleManager activePeripheral]];
        }
    }
    [self.appDelegate.bleManager.peripherals removeAllObjects];
    [self.appDelegate.bleManager.activeDescriptors removeAllObjects];
    [self.appDelegate.bleManager.activeCharacteristics removeAllObjects];
    self.appDelegate.bleManager.activeService = nil;
    self.appDelegate.bleManager.activePeripheral = nil;
    
    //定时扫描持续时间10秒，之后打印扫描到的信息
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
//    NSLog(@" BLE 设备连接成功   ！\r\n");
    MODEL = MODEL_CONNECTING ;
    [self.tableView reloadData];
    [self.appDelegate.bleManager.activePeripheral discoverServices:nil];
}

//扫描ble设备
- (void)stopScanBLEDevice:(CBPeripheral *)peripheral
{
//    NSLog(@" BLE外设 列表 被更新 ！\r\n");
    [self.tableView reloadData];
    [self RefreshStateNormal];
}

//此方法刷新次数过多，会导致tableview界面无法刷新的情况发生
- (void)bleDeviceWithRSSIFound:(NSNotification *) notification
{
//    NSLog(@" 更新RSSI 值 ！\r\n");
    [self.tableView reloadData];
}

//服务发现完成之后的回调方法
- (void)ServiceFoundOver:(CBPeripheral *)peripheral
{
//    NSLog(@" 获取所有的服务 ");
    MODEL = MODEL_SCAN;
    [self.tableView reloadData];
}

//成功扫描所有服务特征值
- (void)DownloadCharacteristicOver:(CBPeripheral *)peripheral
{
//    NSLog(@" 获取所有的特征值 ! \r\n");
    MODEL = MODEL_CONECTED;
    [self.tableView reloadData];
}

- (void)goMainPage
{
    TabBarFrameViewController *mTabBarFrameViewController=[[TabBarFrameViewController alloc]init];
    [self presentViewController:mTabBarFrameViewController animated:YES completion:^{
//        [self startGetData];
    }];
}

@end