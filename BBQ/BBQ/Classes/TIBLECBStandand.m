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

//中心管理器状态检测
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
    int i = 0 ;
    if (!self.peripherals) {
        //列表为空，第一次发现新设备
        self.peripherals = [[NSMutableArray alloc] initWithObjects:peripheral,nil];
    } else {
        //列表中有曾经发现的设备，如果重复发现则刷新，
        for(i = 0; i < self.peripherals.count; i++) {
            CBPeripheral *p = [self.peripherals objectAtIndex:i];
            //重复设备不加入列表
            if (p.UUID == peripheral.UUID) {
                [self.peripherals replaceObjectAtIndex:i withObject:peripheral];
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
    }
    //发送外围设备的序号，以及RSSI通知
    rssiArray = [NSArray arrayWithObjects:[NSNumber numberWithInt:i],RSSI, nil];
    if(isScan) {
        nc = [NSNotificationCenter defaultCenter];
        [nc postNotificationName:NOTIFICATION_BLEDEVICEWITHRSSIFOUND object: rssiArray];
    }
}

//中心设备成功连接BLE外围设备
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    self.activePeripheral = peripheral;
    //点击某个设备后，将这个设备对象作为参数，通知给属性列表窗体，在那个窗体中进行连接以及服务扫描操作。
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:NOTIFICATION_DIDCONNECTEDBLEDEVICE object: nil];
}

//连接发生错误
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    
}

//服务发现完成之后的回调方法
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    if (!error) {
        //触发获取所有特征值
        [self getAllCharacteristicsFromKeyfob:peripheral];
        NSNumber *n =  [NSNumber numberWithFloat:1.0];
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc postNotificationName:NOTIFICATION_SERVICEFOUNDOVER object: n];
    } else {
        NSLog(@"Service discovery was unsuccessfull !\r\n");
    }
}

//发现服务的特征值之后的回调方法，主要是打印所有服务的特征值。
- (void) peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    static int index = 0 ;
    if (!error) {
        index ++ ;
        for(int i=0; i < service.characteristics.count; i++) {
            CBCharacteristic *c = [service.characteristics objectAtIndex:i];
            [self SaveToActiveCharacteristic:c];
        }
        NSNumber *m =  [NSNumber numberWithFloat:0.25];
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc postNotificationName:NOTIFICATION_DOWNLOADSERVICEPROCESSSTEP object: m];
    } else {
        index = 0 ;
    }
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"1800"]]) {
        for (CBCharacteristic *aChar in service.characteristics) {
            //遍历此服务的所有特征值
            if ([aChar.UUID isEqual:[CBUUID UUIDWithString:@"2A04"]]) {
                [peripheral readValueForCharacteristic:aChar];
//                NSLog(@"//step_10_y Found a Connection Parameters Characteristic");
//                NSLog(@"%@", aChar);
            }
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if (!error) {
//        NSLog(@"Updated notification state for characteristic with UUID %s on service with  UUID %s on peripheral with UUID %s\r\n",[self CBUUIDToString:characteristic.UUID],[self CBUUIDToString:characteristic.service.UUID],[self UUIDToString:peripheral.UUID]);
    } else {
//        NSLog(@"Error in setting notification state for characteristic with UUID %s on service with  UUID %s on peripheral with UUID %s\r\n",[self CBUUIDToString:characteristic.UUID],[self CBUUIDToString:characteristic.service.UUID],[self UUIDToString:peripheral.UUID]);
//        NSLog(@"Error code was %s\r\n",[[error description] cStringUsingEncoding:NSStringEncodingConversionAllowLossy]);
    }
}

//特征值更新后的回调函数，或者收到通知和提示消息后的回调
//这里会根据特征值的UUID来进行区分是哪一个特征值的更新或者改变通知
//如果这些特征值的UUID的值，事先不确定，必须靠连接后的读取来获得，必须在获取之后保存在某一个可变阵列缓冲中
//事后，根据收到的消息中的UUID和缓冲中的特征值UUID逐个比较，最终改变相应特征值的值
//特征值读取，或者得到更改通知后的回调
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    ////////////////////    UInt16 characteristicUUID = [self CBUUIDToInt:characteristic.UUID];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    if (!error) {
        if ([self.mode compare:@"UPDATEMODE" ] == NSOrderedSame) {
            //NSLog(@"-----------特征值改变通知----------<<<<<<<<<<");//Jason++
            if ([self isAActiveCharacteristic:(characteristic)]==YES) {
                [self UpdateToActiveCharacteristic:characteristic];
                [nc postNotificationName:NOTIFICATION_VALUECHANGUPDATE object: characteristic];
            }
        }else if ([self.mode compare:@"SCANMODE" ] == NSOrderedSame){
            //            NSLog(@"-----------读取特征值的值之后值----------第3步结束");//Jason++
            //            if ([self isAActiveCharacteristic:(characteristic)]==YES) {
            //                [self SaveToActiveCharacteristic:characteristic];
            //                NSNumber *m =  [NSNumber numberWithFloat:0.75];
            //                [nc postNotificationName: @"DOWNLOADSERVICEPROCESSSTEP" object: m];
            //            }
            return;
        } else if ([self.mode compare:@"IDLEMODE" ] == NSOrderedSame) {
            //NSLog(@"-----------读取特征值的值之后值----------单独读");
            if ([self isAActiveCharacteristic:(characteristic)]==YES) {
                [self SaveToActiveCharacteristic:characteristic];
                [nc postNotificationName:NOTIFICATION_VALUECHANGUPDATE object: Nil];
            }
        }
    } else {
        if ([self.mode compare:@"UPDATEMODE" ] == NSOrderedSame) {
            NSLog(@"错误-----------特征值改变通知----------<<<<<<<<<<");
        } else if ([self.mode compare:@"SCANMODE" ] == NSOrderedSame){
            NSLog(@"错误---------读取特征值的值之后值----------第3步结束");
            NSNumber *m =  [NSNumber numberWithFloat:0.75];
            [nc postNotificationName:NOTIFICATION_DOWNLOADSERVICEPROCESSSTEP object: m];
        }
    }
}

#pragma 自定义函数

//连接指定的BLE外围设备
- (void)connectPeripheral:(CBPeripheral *)peripheral
{
    self.activePeripheral = peripheral;
    self.activePeripheral.delegate = self;
    [self.CM connectPeripheral:self.activePeripheral options:nil];
}

//获取所有服务的特征值
-(void)getAllCharacteristicsFromKeyfob:(CBPeripheral *)p
{
    //读取所有服务的特征值
    for (int i=0; i < p.services.count; i++) {
        CBService *s = [p.services objectAtIndex:i];
        //开始读取当前服务的特征值
        [p discoverCharacteristics:nil forService:s];
    }
}

- (void)SaveToActiveCharacteristic:(CBCharacteristic *)c
{
    if (!self.activeCharacteristics){
        //列表为空，第一次发现新设备
        self.activeCharacteristics = [[NSMutableArray alloc] initWithObjects:c,nil];
//        NSLog(@"New characteristics, adding ... characteristic UUID %s",[self CBUUIDToString:c.UUID]);
    } else {
        //列表中有曾经发现的设备，如果重复发现则刷新，
        for(int i = 0; i < self.activeCharacteristics.count; i++) {
            CBCharacteristic *p = [self.activeCharacteristics objectAtIndex:i];
            if (p.UUID == c.UUID) {
                [self.activeCharacteristics replaceObjectAtIndex:i withObject:c];
//                NSLog(@"覆盖 characteristic UUID %s",[self CBUUIDToString:p.UUID]);
                return ;
            }
        }
        //发现的外围设备，被保存在对象的peripherals 缓冲中
        [self.activeCharacteristics addObject:c];
//        NSLog(@"New characteristics, adding ... characteristic UUID %s",[self CBUUIDToString:c.UUID]);
    }
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
//    NSLog(@"//step_4 Stopped Scanning\r\n");
//    NSLog(@"//step_4 Known peripherals : %ld\r\n",[self.peripherals count]);
    //[self printKnownPeripherals];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:NOTIFICATION_STOPSCAN object: nil];
//    timer = nil;
    scanKeepTimer = nil ;
}

- (void)UpdateToActiveCharacteristic:(CBCharacteristic *)c
{
    if (!self.activeCharacteristics)
        //列表为空，第一次发现新设备
        NSLog(@"no characteristics !\r\n");
    for(int i = 0; i < self.activeCharacteristics.count; i++) {
        CBCharacteristic *p = [self.activeCharacteristics objectAtIndex:i];
        if (p.UUID == c.UUID) {
            [self.activeCharacteristics replaceObjectAtIndex:i withObject:c];
//            NSLog(@"覆盖刷新 characteristic UUID %s\r\n",[self CBUUIDToString:p.UUID]);
//            [self DisplayCharacteristicMessage:c];
            return ;
        }
    }
}

- (BOOL)isAActiveCharacteristic:(CBCharacteristic*)c
{
    for(int i = 0; i < self.activeCharacteristics.count; i++) {
        CBCharacteristic *p = [self.activeCharacteristics objectAtIndex:i];
        if (p.UUID == c.UUID) {
            return YES;
        }
    }
    return NO;
}

- (UInt16)swap:(UInt16)s
{
    UInt16 temp = s << 8;
    temp |= (s >> 8);
    return temp;
}

- (const char*)UUIDToString:(CFUUIDRef)UUID
{
    if (!UUID) return "NULL";
    CFStringRef s = CFUUIDCreateString(NULL, UUID);
    return CFStringGetCStringPtr(s, 0);
}

- (const char*)CBUUIDToString:(CBUUID*)UUID
{
    return [[UUID.data description] cStringUsingEncoding:NSStringEncodingConversionAllowLossy];
}

- (CBService*)findServiceFromUUID:(CBUUID*)UUID p:(CBPeripheral*)p
{
    for(int i = 0; i < p.services.count; i++) {
        CBService *s = [p.services objectAtIndex:i];
        if ([self compareCBUUID:s.UUID UUID2:UUID]) return s;
    }
    return nil; //Service not found on this peripheral
}

- (int)compareCBUUID:(CBUUID*) UUID1 UUID2:(CBUUID*)UUID2
{
    char b1[16];
    char b2[16];
    [UUID1.data getBytes:b1];
    [UUID2.data getBytes:b2];
    if (memcmp(b1, b2, UUID1.data.length) == 0)return 1;
    else return 0;
}

- (CBCharacteristic*)findCharacteristicFromUUID:(CBUUID *)UUID service:(CBService*)service
{
    for(int i=0; i < service.characteristics.count; i++) {
        CBCharacteristic *c = [service.characteristics objectAtIndex:i];
        if ([self compareCBUUID:c.UUID UUID2:UUID]) return c;
    }
    return nil; //Characteristic not found on this service
}

//-(void) DisplayCharacteristicMessage:(CBCharacteristic *)c{
//    
//    return;
//    
//    NSLog(@" service.UUID:%@ (%s)",c.service.UUID,[self CBUUIDToString:c.service.UUID]);
//    NSLog(@"         UUID:%@ (%s)",c.UUID,[self CBUUIDToString:c.UUID]);
//    NSLog(@"   properties:0x%02x",c.properties);
//    
//    NSLog(@" value.length:%ld",c.value.length);
//    
//    INT_STRUCT buf1;
//    [c.value getBytes:&buf1 length:c.value.length];
//    NSLog(@"        value:");
//    for(int i=0; i < c.value.length; i++) {
//        NSLog(@"%02x ",buf1.buff[i]&0x000000ff);
//    }
//    
//    NSLog(@"isBroadcasted:%d",c.isBroadcasted);
//    NSLog(@"  isNotifying:%d",c.isNotifying);
//    
//    NSString *provincName = [NSString stringWithFormat:@"%@", [self GetCharcteristicDiscriptorFromActiveDescriptorsArray:c]];
//    
//    NSLog(@"   Discriptor:%@ ",provincName);
//    
//    //    NSLog(@"      :%@ ",c.UUID);
//    //    NSLog(@"  UUID:%@ ",d.UUID);
//    //    NSLog(@"    id:%@ ",d.value);
//}

//- (id)GetCharcteristicDiscriptorFromActiveDescriptorsArray:(CBCharacteristic *)characteristic
//{
//    for(int i = 0; i < self.activeDescriptors.count; i++) {
//        CBDescriptor *p = [self.activeDescriptors objectAtIndex:i];
//        //        NSLog(@" activeDescriptors.UUID:%@ ",p.characteristic.UUID);
//        //        NSLog(@"  CBCharacteristic.UUID:%@ ",characteristic.UUID);
//        if (p.characteristic.UUID == characteristic.UUID) {
//            return p.value;
//        }
//    }
//    return nil;
//}

- (void)notification:(int)serviceUUID characteristicUUID:(int)characteristicUUID p:(CBPeripheral *)p on:(BOOL)on
{
    UInt16 s = [self swap:serviceUUID];
    UInt16 c = [self swap:characteristicUUID];
    
    NSData *sd = [[NSData alloc] initWithBytes:(char *)&s length:2];
    NSData *cd = [[NSData alloc] initWithBytes:(char *)&c length:2];
    
    CBUUID *su = [CBUUID UUIDWithData:sd];
    CBUUID *cu = [CBUUID UUIDWithData:cd];
    
    CBService *service = [self findServiceFromUUID:su p:p];
    if (!service) {
        NSLog(@"Could not find service with UUID %s on peripheral with UUID %s\r\n",[self CBUUIDToString:su],[self UUIDToString:p.UUID]);
        return;
    }
    CBCharacteristic *characteristic = [self findCharacteristicFromUUID:cu service:service];
    if (!characteristic) {
        NSLog(@"Could not find characteristic with UUID %s on service with UUID %s on peripheral with UUID %s\r\n",[self CBUUIDToString:cu],[self CBUUIDToString:su],[self UUIDToString:p.UUID]);
        return;
    }
    [p setNotifyValue:on forCharacteristic:characteristic];
}

@end