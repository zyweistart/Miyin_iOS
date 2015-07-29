//
//  MainViewController.m
//  BBQ
//
//  Created by Start on 15/7/27.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)init
{
    self=[super init];
    if(self){
        [self buildTableViewWithView:self.view];
        UIView *bottomView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 120, 40)];
        [self.tableView setTableFooterView:bottomView];
        CButton *bDemo=[[CButton alloc]initWithFrame:CGRectMake1(20, 0, 120, 40) Name:@"Demo" Type:1];
        [bDemo addTarget:self action:@selector(goDemo) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:bDemo];
        CButton *bScan=[[CButton alloc]initWithFrame:CGRectMake1(180, 0, 120, 40) Name:@"Scan" Type:2];
        [bScan addTarget:self action:@selector(goScan) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:bScan];
        //1、建立中心角色
        self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SAMPLECell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSDictionary *data=[self.dataItemArray objectAtIndex:indexPath.row];
    NSString *name=[data objectForKey:@"kCBAdvDataLocalName"];
    cell.textLabel.text = name;
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

- (void)goDemo
{
    if(self.peripheral){
        //连接蓝牙
        [self.centralManager connectPeripheral:self.peripheral options:nil];
    }
}

//2、扫描外设
- (void)goScan
{
    [self.dataItemArray removeAllObjects];
    [self.centralManager scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey:@YES}];
    //超时停止扫描
    double delayInSeconds = 30.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW,(int64_t)(delayInSeconds* NSEC_PER_SEC));
    dispatch_after(popTime,dispatch_get_main_queue(),^(void){
        [self.centralManager stopScan];
    });
}

#pragma  mark -- CBCentralManagerDelegate
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
            [self goScan];
            break;
        case CBCentralManagerStateUnknown:
            break;
        default:
            break;
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    if (self.peripheral != peripheral){
        self.peripheral = peripheral;
        NSLog(@"%@",self.peripheral.name);
//        NSLog(@"%@",advertisementData);
//        NSLog(@"%@",peripheral.identifier.UUIDString);
//        [self.centralManager stopScan];
    }
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    [self.mutableData setLength:0];
    [self.peripheral setDelegate:self];
    //此时设备已经连接上了 你要做的就是找到该设备上的指定服务
    [self.peripheral discoverServices:nil];
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"连接发生错误");
}

#pragma mark -- CBPeripheralDelegate
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    if (error==nil) {
        //在这个方法中我们要查找到我们需要的服务然后调用discoverCharacteristics方法查找我们需要的特性
        for (CBService *service in peripheral.services) {
            [peripheral discoverCharacteristics:nil forService:service];
        }
    } else {
//        NSLog(@"Discovered services for %@ with error: %@", peripheral.name, [error localizedDescription]);
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    if (error==nil) {
        //在这个方法中我们要找到我们所需的服务的特性然后调用setNotifyValue方法告知我们要监测这个服务特性的状态变化
        for (CBCharacteristic *characteristic in service.characteristics) {
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
        }
    } else {
//        NSLog(@"Discover CharacteristicsForService for %@ with error: %@", peripheral.name, [error localizedDescription]);
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (error==nil) {
        if (characteristic.isNotifying) {
            [peripheral readValueForCharacteristic:characteristic];
        } else {
            [self.centralManager cancelPeripheralConnection:self.peripheral];
        }
    } else {
//        NSLog(@"Error changing notification state: %@", error.localizedDescription);
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    NSString *aString = [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
    NSLog(@"%@",aString);
//    if([aString containsString:@"\r\n"]){
//        NSLog(@"%@",self.mutableString);
//        self.mutableString = [[NSMutableString alloc]init];
//    }else{
//        if(aString){
//            [self.mutableString appendString:aString];
//        }
//    }
}

@end