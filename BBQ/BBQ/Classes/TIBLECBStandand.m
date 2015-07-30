//
//  TIBLECBStandand.m
//  0 BLE Scanner
//
//  Created by rfstar on 12-9-25.
//  Copyright (c) 2012年 rfstar. All rights reserved.
// 

#import "TIBLECBStandand.h"

@implementation TIBLECBStandand

#pragma mark -------BLE 通讯模型类的属性-------

@synthesize CM;                 ////BLE中心管理器对象指针
@synthesize peripherals;        ////可变长表格阵列，用来保存扫描到的所有 CBPeripheral 对象指针
@synthesize activePeripheral;   ////当前已进入连接状态的外围设备对象指针
@synthesize activeCharacteristics;    //当前正在操作的特征值缓存
@synthesize activeDescriptors;
@synthesize mode;
@synthesize activeService;

#pragma mark -------BLE 通讯模型类的方法-------

/*!
 *  @method writeValue:
 *
 *  @param serviceUUID Service UUID to write to (e.g. 0x2400)
 *  @param characteristicUUID Characteristic UUID to write to (e.g. 0x2401)
 *  @param data Data to write to peripheral
 *  @param p CBPeripheral to write to
 *
 *  @discussion Main routine for writeValue request, writes without feedback. It converts integer into
 *  CBUUID's used by CoreBluetooth. It then searches through the peripherals services to find a
 *  suitable service, it then checks that there is a suitable characteristic on this service.
 *  If this is found, value is written. If not nothing is done.
 *
 */

-(void) writeValue:(int)serviceUUID characteristicUUID:(int)characteristicUUID p:(CBPeripheral *)p data:(NSData *)data {
    UInt16 s = [self swap:serviceUUID];
    UInt16 c = [self swap:characteristicUUID];
    NSData *sd = [[NSData alloc] initWithBytes:(char *)&s length:2];
    NSData *cd = [[NSData alloc] initWithBytes:(char *)&c length:2];
    CBUUID *su = [CBUUID UUIDWithData:sd];
    CBUUID *cu = [CBUUID UUIDWithData:cd];
    
    CBService *service = [self findServiceFromUUID:su p:p];
    if (!service) {
        //NSLog(@"Could not find service with UUID %s on peripheral with UUID %s\r\n",[self CBUUIDToString:su],[self UUIDToString:p.UUID]);
        return;
    }
    
    CBCharacteristic *characteristic = [self findCharacteristicFromUUID:cu service:service];
    if (!characteristic) {
        //NSLog(@"Could not find characteristic with UUID %s on service with UUID %s on peripheral with UUID %s\r\n",[self CBUUIDToString:cu],[self CBUUIDToString:su],[self UUIDToString:p.UUID]);
        return;
    }
    [p writeValue:data forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
}


/*!
 *  @method readValue:
 *
 *  @param serviceUUID Service UUID to read from (e.g. 0x2400)
 *  @param characteristicUUID Characteristic UUID to read from (e.g. 0x2401)
 *  @param p CBPeripheral to read from
 *
 *  @discussion Main routine for read value request. It converts integers into
 *  CBUUID's used by CoreBluetooth. It then searches through the peripherals services to find a
 *  suitable service, it then checks that there is a suitable characteristic on this service.
 *  If this is found, the read value is started. When value is read the didUpdateValueForCharacteristic
 *  routine is called.
 *
 *  @see didUpdateValueForCharacteristic
 */

-(void) readValue: (int)serviceUUID characteristicUUID:(int)characteristicUUID p:(CBPeripheral *)p {
    UInt16 s = [self swap:serviceUUID];
    UInt16 c = [self swap:characteristicUUID];
    NSData *sd = [[NSData alloc] initWithBytes:(char *)&s length:2];
    NSData *cd = [[NSData alloc] initWithBytes:(char *)&c length:2];
    CBUUID *su = [CBUUID UUIDWithData:sd];
    CBUUID *cu = [CBUUID UUIDWithData:cd];
    CBService *service = [self findServiceFromUUID:su p:p];
    if (!service) {
        //NSLog(@"Could not find service with UUID %s on peripheral with UUID %s\r\n",[self CBUUIDToString:su],[self UUIDToString:p.UUID]);
        return;
    }
    CBCharacteristic *characteristic = [self findCharacteristicFromUUID:cu service:service];
    if (!characteristic) {
        //NSLog(@"Could not find characteristic with UUID %s on service with UUID %s on peripheral with UUID %s\r\n",[self CBUUIDToString:cu],[self CBUUIDToString:su],[self UUIDToString:p.UUID]);
        return;
    }
    [p readValueForCharacteristic:characteristic];
}



/*!
 *  @method notification:
 *
 *  @param serviceUUID Service UUID to read from (e.g. 0x2400)
 *  @param characteristicUUID Characteristic UUID to read from (e.g. 0x2401)
 *  @param p CBPeripheral to read from
 *
 *  @discussion Main routine for enabling and disabling notification services. It converts integers
 *  into CBUUID's used by CoreBluetooth. It then searches through the peripherals services to find a
 *  suitable service, it then checks that there is a suitable characteristic on this service.
 *  If this is found, the notfication is set.
 *
 */
-(void) notification:(int)serviceUUID characteristicUUID:(int)characteristicUUID p:(CBPeripheral *)p on:(BOOL)on {
    UInt16 s = [self swap:serviceUUID];
    UInt16 c = [self swap:characteristicUUID];
    
    NSData *sd = [[NSData alloc] initWithBytes:(char *)&s length:2];
    NSData *cd = [[NSData alloc] initWithBytes:(char *)&c length:2];
    
    CBUUID *su = [CBUUID UUIDWithData:sd];
    CBUUID *cu = [CBUUID UUIDWithData:cd];
    
    CBService *service = [self findServiceFromUUID:su p:p];
    if (!service) {
        //NSLog(@"Could not find service with UUID %s on peripheral with UUID %s\r\n",[self CBUUIDToString:su],[self UUIDToString:p.UUID]);
        return;
    }
    CBCharacteristic *characteristic = [self findCharacteristicFromUUID:cu service:service];
    if (!characteristic) {
        //NSLog(@"Could not find characteristic with UUID %s on service with UUID %s on peripheral with UUID %s\r\n",[self CBUUIDToString:cu],[self CBUUIDToString:su],[self UUIDToString:p.UUID]);
        return;
    }
    [p setNotifyValue:on forCharacteristic:characteristic];
}


/*!
 *  @method swap:
 *
 *  @param s Uint16 value to byteswap
 *
 *  @discussion swap byteswaps a UInt16
 *
 *  @return Byteswapped UInt16
 */

-(UInt16) swap:(UInt16)s {
    UInt16 temp = s << 8;
    temp |= (s >> 8);
    return temp;
}

/*!
 *  @method controlSetup:
 *
 *  @param s Not used
 *
 *  @return Allways 0 (Success)
 *
 *  @discussion controlSetup enables CoreBluetooths Central Manager and sets delegate to TIBLECBKeyfob class
 *
 */
- (int) controlSetup: (int) s{
    self.CM = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    return 0;
}

-(void)stopScan{
    [self.CM stopScan];
    isScan  = NO;
}
/*!
 *  @method findBLEPeripherals:
 *
 *  @param timeout timeout in seconds to search for BLE peripherals
 *
 *  @return 0 (Success), -1 (Fault)
 *
 *  @discussion findBLEPeripherals searches for BLE peripherals and sets a timeout when scanning is stopped
 *
 */
- (int) findBLEPeripherals:(int) timeout {
//    //NSLog(@"Scanner_Step_ 2: BLE MOUDLE 开始扫描 ！\r\n");
    if (self->CM.state  != CBCentralManagerStatePoweredOn) {
//        //NSLog(@"CoreBluetooth not correctly initialized !\r\n");
//        //NSLog(@"State = %d (%s)\r\n",self->CM.state,[self centralManagerStateToString:self.CM.state]);
        return -1;
    }
    
    if (scanKeepTimer==nil) {
        scanKeepTimer = [NSTimer scheduledTimerWithTimeInterval:(float)timeout
                                         target:self
                                       selector:@selector(scanTimer:)
                                       userInfo:nil
                                        repeats:NO];
    }
    [self.CM stopScan];
    [self.CM scanForPeripheralsWithServices:nil options:0]; // Start scanning
    isScan = YES;
    return 0; // Started scanning OK !
}

/*!
 *  @method scanTimer:
 *
 *  @param timer Backpointer to timer
 *
 *  @discussion scanTimer is called when findBLEPeripherals has timed out, it stops the CentralManager from scanning further and prints out information about known peripherals
 *
 */
//定时扫描结束，打印BLE设备信息
- (void) scanTimer:(NSTimer *)timer {
    [self.CM stopScan];
    
    //NSLog(@"//step_4 Stopped Scanning\r\n");
    //NSLog(@"//step_4 Known peripherals : %d\r\n",[self->peripherals count]);
//    [self printKnownPeripherals];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName: @"STOPSCAN" object: nil];
//    timer = nil;
    scanKeepTimer = nil ;
}

/*!
 *  @method connectPeripheral:
 *
 *  @param p Peripheral to connect to
 *
 *  @discussion connectPeripheral connects to a given peripheral and sets the activePeripheral property of TIBLECBKeyfob.
 *
 */
//连接指定的BLE外围设备
- (void) connectPeripheral:(CBPeripheral *)peripheral {
    //NSLog(@"//step_7_0 Connecting to peripheral with UUID : %s\r\n",[self UUIDToString:peripheral.UUID]);
    activePeripheral = peripheral;
    activePeripheral.delegate = self;
    [CM connectPeripheral:activePeripheral options:nil];
}

/*!
 *  @method centralManagerStateToString:
 *
 *  @param state State to print info of
 *
 *  @discussion centralManagerStateToString prints information text about a given CBCentralManager state
 *
 */
- (const char *) centralManagerStateToString: (int)state{
    switch(state) {
        case CBCentralManagerStateUnknown:
            return "State unknown (CBCentralManagerStateUnknown)";
        case CBCentralManagerStateResetting:
            return "State resetting (CBCentralManagerStateUnknown)";
        case CBCentralManagerStateUnsupported:
            return "State BLE unsupported (CBCentralManagerStateResetting)";
        case CBCentralManagerStateUnauthorized:
            return "State unauthorized (CBCentralManagerStateUnauthorized)";
        case CBCentralManagerStatePoweredOff:
            return "State BLE powered off (CBCentralManagerStatePoweredOff)";
        case CBCentralManagerStatePoweredOn:
            return "State powered up and ready (CBCentralManagerStatePoweredOn)";
        default:
            return "State unknown";
    }
    return "Unknown state";
}

/*!
 *  @method printKnownPeripherals:
 *
 *  @discussion printKnownPeripherals prints all curenntly known peripherals stored in the peripherals array of TIBLECBKeyfob class
 *
 */
- (void) printKnownPeripherals {
    int i;
    //NSLog(@"//step_5 List of currently known peripherals : \r\n");
    for (i=0; i < self->peripherals.count; i++)
    {
        CBPeripheral *p = [self->peripherals objectAtIndex:i];
        CFStringRef s = CFUUIDCreateString(NULL, p.UUID);
        //NSLog(@"%d  |  %s\r\n",i,CFStringGetCStringPtr(s, 0));
        [self printPeripheralInfo:p];
        //发出通知，参数为外围设备对象
        //NSLog(@"//step_6 update ble devices list !\r\n");
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc postNotificationName: @"BLEDEVICEFOUND" object: p];
    }
}

/*
 *  @method printPeripheralInfo:
 *
 *  @param peripheral Peripheral to print info of
 *
 *  @discussion printPeripheralInfo prints detailed info about peripheral
 *
 */

- (void) printPeripheralInfo:(CBPeripheral*)peripheral {
    CFStringRef s = CFUUIDCreateString(NULL, peripheral.UUID);
    
    //NSLog(@"------------------------------------\r\n");
    //NSLog(@"Peripheral Info :\r\n");
    //NSLog(@"UUID : %s\r\n",CFStringGetCStringPtr(s, 0));
    //NSLog(@"RSSI : %d\r\n",[peripheral.RSSI intValue]);
    //NSLog(@"Name : %s\r\n",[peripheral.name cStringUsingEncoding:NSStringEncodingConversionAllowLossy]);
    //NSLog(@"isConnected : %d\r\n",peripheral.isConnected);
    //NSLog(@"-------------------------------------\r\n");
    
}

/*
 *  @method UUIDSAreEqual:
 *
 *  @param u1 CFUUIDRef 1 to compare
 *  @param u2 CFUUIDRef 2 to compare
 *
 *  @returns 1 (equal) 0 (not equal)
 *
 *  @discussion compares two CFUUIDRef's
 *
 */

- (int) UUIDSAreEqual:(CFUUIDRef)u1 u2:(CFUUIDRef)u2 {
    CFUUIDBytes b1 = CFUUIDGetUUIDBytes(u1);
    CFUUIDBytes b2 = CFUUIDGetUUIDBytes(u2);
    if (memcmp(&b1, &b2, 16) == 0) {
        return 1 ;
    }
    return 0 ;
}


/*
 *  @method getAllServicesFromKeyfob
 *
 *  @param p Peripheral to scan
 *
 *
 *  @discussion getAllServicesFromKeyfob starts a service discovery on a peripheral pointed to by p.
 *  When services are found the didDiscoverServices method is called
 *
 */
-(void) getAllServicesFromKeyfob:(CBPeripheral *)p{
    [p discoverServices:nil]; // Discover all services without filter
    
}

/*
 *  @method getAllCharacteristicsFromKeyfob
 *
 *  @param p Peripheral to scan
 *
 *
 *  @discussion getAllCharacteristicsFromKeyfob starts a characteristics discovery on a peripheral
 *  pointed to by p
 *
 */

//获取所有服务的特征值
-(void) getAllCharacteristicsFromKeyfob:(CBPeripheral *)p{
    //读取所有服务的特征值
    for (int i=0; i < p.services.count; i++) {
        CBService *s = [p.services objectAtIndex:i];
        //NSLog(@"//step_9_0 Fetching characteristics for service with UUID : %s\r\n",[self CBUUIDToString:s.UUID]);
        
        //开始读取当前服务的特征值
        [p discoverCharacteristics:nil forService:s];
    }
}

/*
 *  @method CBUUIDToString
 *
 *  @param UUID UUID to convert to string
 *
 *  @returns Pointer to a character buffer containing UUID in string representation
 *
 *  @discussion CBUUIDToString converts the data of a CBUUID class to a character pointer for easy printout using NSLog()
 *
 */
-(const char *) CBUUIDToString:(CBUUID *) UUID {
    return [[UUID.data description] cStringUsingEncoding:NSStringEncodingConversionAllowLossy];
}


/*
 *  @method UUIDToString
 *
 *  @param UUID UUID to convert to string
 *
 *  @returns Pointer to a character buffer containing UUID in string representation
 *
 *  @discussion UUIDToString converts the data of a CFUUIDRef class to a character pointer for easy printout using NSLog()
 *
 */
-(const char *) UUIDToString:(CFUUIDRef)UUID {
    if (!UUID) return "NULL";
    CFStringRef s = CFUUIDCreateString(NULL, UUID);
    return CFStringGetCStringPtr(s, 0);
    
}

/*
 *  @method compareCBUUID
 *
 *  @param UUID1 UUID 1 to compare
 *  @param UUID2 UUID 2 to compare
 *
 *  @returns 1 (equal) 0 (not equal)
 *
 *  @discussion compareCBUUID compares two CBUUID's to each other and returns 1 if they are equal and 0 if they are not
 *
 */

-(int) compareCBUUID:(CBUUID *) UUID1 UUID2:(CBUUID *)UUID2 {
    char b1[16];
    char b2[16];
    [UUID1.data getBytes:b1];
    [UUID2.data getBytes:b2];
    if (memcmp(b1, b2, UUID1.data.length) == 0)return 1;
    else return 0;
}

/*
 *  @method compareCBUUIDToInt
 *
 *  @param UUID1 UUID 1 to compare
 *  @param UUID2 UInt16 UUID 2 to compare
 *
 *  @returns 1 (equal) 0 (not equal)
 *
 *  @discussion compareCBUUIDToInt compares a CBUUID to a UInt16 representation of a UUID and returns 1
 *  if they are equal and 0 if they are not
 *
 */
-(int) compareCBUUIDToInt:(CBUUID *)UUID1 UUID2:(UInt16)UUID2 {
    char b1[16];
    [UUID1.data getBytes:b1];
    UInt16 b2 = [self swap:UUID2];
    if (memcmp(b1, (char *)&b2, 2) == 0) return 1;
    else return 0;
}
/*
 *  @method CBUUIDToInt
 *
 *  @param UUID1 UUID 1 to convert
 *
 *  @returns UInt16 representation of the CBUUID
 *
 *  @discussion CBUUIDToInt converts a CBUUID to a Uint16 representation of the UUID
 *
 */
-(UInt16) CBUUIDToInt:(CBUUID *) UUID {
    char b1[16];
    [UUID.data getBytes:b1];
    return ((b1[0] << 8) | b1[1]);
}

/*
 *  @method IntToCBUUID
 *
 *  @param UInt16 representation of a UUID
 *
 *  @return The converted CBUUID
 *
 *  @discussion IntToCBUUID converts a UInt16 UUID to a CBUUID
 *
 */
-(CBUUID *) IntToCBUUID:(UInt16)UUID {
    char t[16];
    t[0] = ((UUID >> 8) & 0xff); t[1] = (UUID & 0xff);
    NSData *data = [[NSData alloc] initWithBytes:t length:16];
    return [CBUUID UUIDWithData:data];
}


/*
 *  @method findServiceFromUUID:
 *
 *  @param UUID CBUUID to find in service list
 *  @param p Peripheral to find service on
 *
 *  @return pointer to CBService if found, nil if not
 *
 *  @discussion findServiceFromUUID searches through the services list of a peripheral to find a
 *  service with a specific UUID
 *
 */
-(CBService *) findServiceFromUUID:(CBUUID *)UUID p:(CBPeripheral *)p {
    for(int i = 0; i < p.services.count; i++) {
        CBService *s = [p.services objectAtIndex:i];
        if ([self compareCBUUID:s.UUID UUID2:UUID]) return s;
    }
    return nil; //Service not found on this peripheral
}

/*
 *  @method findCharacteristicFromUUID:
 *
 *  @param UUID CBUUID to find in Characteristic list of service
 *  @param service Pointer to CBService to search for charateristics on
 *
 *  @return pointer to CBCharacteristic if found, nil if not
 *
 *  @discussion findCharacteristicFromUUID searches through the characteristic list of a given service
 *  to find a characteristic with a specific UUID
 *
 */
-(CBCharacteristic *) findCharacteristicFromUUID:(CBUUID *)UUID service:(CBService*)service {
    for(int i=0; i < service.characteristics.count; i++) {
        CBCharacteristic *c = [service.characteristics objectAtIndex:i];
        if ([self compareCBUUID:c.UUID UUID2:UUID]) return c;
    }
    return nil; //Characteristic not found on this service
}

-(void) SaveToActiveCharacteristic:(CBCharacteristic *)c{
    if (!self.activeCharacteristics){      //列表为空，第一次发现新设备
        self.activeCharacteristics = [[NSMutableArray alloc] initWithObjects:c,nil];
//        //NSLog(@"New characteristics, adding ... characteristic UUID %s",[self CBUUIDToString:c.UUID]);
    }
    else {                      //列表中有曾经发现的设备，如果重复发现则刷新，
        for(int i = 0; i < self.activeCharacteristics.count; i++) {
            CBCharacteristic *p = [self.activeCharacteristics objectAtIndex:i];
            if (p.UUID == c.UUID) {
                [self.activeCharacteristics replaceObjectAtIndex:i withObject:c];
//                //NSLog(@"覆盖 characteristic UUID %s",[self CBUUIDToString:p.UUID]);
                return ;
            }
        }
        //发现的外围设备，被保存在对象的peripherals 缓冲中
        [self.activeCharacteristics addObject:c];
//        //NSLog(@"New characteristics, adding ... characteristic UUID %s",[self CBUUIDToString:c.UUID]);
    }
}


-(void) UpdateToActiveCharacteristic:(CBCharacteristic *)c{
    if (!self.activeCharacteristics)      //列表为空，第一次发现新设备
        //NSLog(@"no characteristics !\r\n");
        
    for(int i = 0; i < self.activeCharacteristics.count; i++) {
        CBCharacteristic *p = [self.activeCharacteristics objectAtIndex:i];
        if (p.UUID == c.UUID) {
            [self.activeCharacteristics replaceObjectAtIndex:i withObject:c];
//            //NSLog(@"覆盖刷新 characteristic UUID %s\r\n",[self CBUUIDToString:p.UUID]);
            [self DisplayCharacteristicMessage:c];
            return ;
        }
    }

    //NSLog(@"Can't find this characteristics !\r\n");
}

-(BOOL) isAActiveCharacteristic:(CBCharacteristic *)c{
    for(int i = 0; i < self.activeCharacteristics.count; i++) {
        CBCharacteristic *p = [self.activeCharacteristics objectAtIndex:i];
        if (p.UUID == c.UUID) {
            return YES;
        }
    }
    //NSLog(@"^ isn't Active characteristics !\r\n");
    return NO;
}

-(void) SaveToActiveDescriptors:(CBDescriptor *)descriptor{
//    if (!self.activeDescriptors){      //列表为空，第一次发现新设备
//        self.activeDescriptors = [[NSMutableArray alloc] initWithObjects:descriptor,nil];
//        //NSLog(@"New descriptor, adding ... descriptor UUID %s\r\n",[self CBUUIDToString:descriptor.characteristic.UUID]);
//    }
//    else {                      //列表中有曾经发现的设备，如果重复发现则刷新，
        for(int i = 0; i < self.activeDescriptors.count; i++) {
            CBDescriptor *p = [self.activeDescriptors objectAtIndex:i];
            if (p.characteristic.UUID == descriptor.characteristic.UUID) {
                //NSLog(@"%d > %d !!!!!!!!! \r\n",i,self.activeDescriptors.count);
                [self.activeDescriptors replaceObjectAtIndex:i withObject:descriptor];
                return;
            }
        }
        //发现的外围设备，被保存在对象的peripherals 缓冲中
        [self.activeDescriptors addObject:descriptor];
        //NSLog(@"New descriptor, adding ... ");
        //NSLog(@" descriptor UUID %s",[self CBUUIDToString:descriptor.characteristic.UUID]);
        //NSLog(@" %s ",[self CBUUIDToString:descriptor.UUID]);
        //NSLog(@" %@ ",descriptor.value);
    
//    }
    //NSLog(@"zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz\r\n");
    //NSLog(@"activeDescriptors count = %d",[self.activeDescriptors count]);
    //NSLog(@"activeCharacteristics count = %d",[self.activeCharacteristics count]);
}

 
-(id) GetCharcteristicDiscriptorFromActiveDescriptorsArray:(CBCharacteristic *)characteristic{
    
    for(int i = 0; i < self.activeDescriptors.count; i++) {
        CBDescriptor *p = [self.activeDescriptors objectAtIndex:i];
//        //NSLog(@" activeDescriptors.UUID:%@ ",p.characteristic.UUID);
//        //NSLog(@"  CBCharacteristic.UUID:%@ ",characteristic.UUID);
        if (p.characteristic.UUID == characteristic.UUID) {
            return p.value;
        }
    }
    return nil;
}

-(void) DisplayCharacteristicDescriptorMessage:(CBDescriptor *)d{
    
    CBCharacteristic *c = d.characteristic;
    
    //NSLog(@" service.UUID:%@ (%s)",c.service.UUID,[self CBUUIDToString:c.service.UUID]);
    //NSLog(@"         UUID:%@ (%s)",c.UUID,[self CBUUIDToString:c.UUID]);
    //NSLog(@"   properties:0x%02x",c.properties);
    
    //NSLog(@" value.length:%d",c.value.length);
    
    INT_STRUCT buf1;
    [c.value getBytes:&buf1 length:c.value.length];
    //NSLog(@"                                                       value:");
    for(int i=0; i < c.value.length; i++) {
        //NSLog(@"%02x ",buf1.buff[i]&0x000000ff);
    }
    //NSLog(@"\r\n");
    
    //NSLog(@"isBroadcasted:%d",c.isBroadcasted);
    //NSLog(@"  isNotifying:%d\r\n",c.isNotifying);
    
    //NSLog(@"      :%@ ",c.UUID);
    //NSLog(@"  UUID:%@ ",d.UUID);
    //NSLog(@"    id:%@ ",d.value);
    
}

-(void) DisplayCharacteristicMessage:(CBCharacteristic *)c{
    
    return;
    
    //NSLog(@" service.UUID:%@ (%s)",c.service.UUID,[self CBUUIDToString:c.service.UUID]);
    //NSLog(@"         UUID:%@ (%s)",c.UUID,[self CBUUIDToString:c.UUID]);
    //NSLog(@"   properties:0x%02x",c.properties);
    
    //NSLog(@" value.length:%d",c.value.length);
    
    INT_STRUCT buf1;
    [c.value getBytes:&buf1 length:c.value.length];
    //NSLog(@"        value:");
    for(int i=0; i < c.value.length; i++) {
        //NSLog(@"%02x ",buf1.buff[i]&0x000000ff);
    }
    
    //NSLog(@"isBroadcasted:%d",c.isBroadcasted);
    //NSLog(@"  isNotifying:%d",c.isNotifying);

    NSString *provincName = [NSString stringWithFormat:@"%@", [self GetCharcteristicDiscriptorFromActiveDescriptorsArray:c]];

    //NSLog(@"   Discriptor:%@ ",provincName);

//    //NSLog(@"      :%@ ",c.UUID);
//    //NSLog(@"  UUID:%@ ",d.UUID);
//    //NSLog(@"    id:%@ ",d.value);
    
}

#pragma mark -------BLE 中心设备代理协议方法-------
//----------------------------------------------------------------------------------------------------
//
//CBCentralManagerDelegate protocol methods beneeth here
// Documented in CoreBluetooth documentation
//
//----------------------------------------------------------------------------------------------------

//@required

/*!
 *  @method centralManagerDidUpdateState:
 *
 *  @param central The central whose state has changed.
 *
 *  @discussion Invoked whenever the central's state has been updated.
 *      See the "state" property for more information.
 *
 */

//中心设备管理器状态更新回调函数

- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    //NSLog(@"//step_1 Status of CoreBluetooth central manager changed %d (%s)\r\n",central.state,[self centralManagerStateToString:central.state]);
}

//@optional

/*!
 *  @method centralManager:didRetrievePeripheral:
 *
 *  @discussion Invoked when the central retrieved a list of known peripherals.
 *      See the -[retrievePeripherals:] method for more information.
 *
 */
- (void)centralManager:(CBCentralManager *)central didRetrievePeripherals:(NSArray *)peripherals{
    
}

/*!
 *  @method centralManager:didRetrieveConnectedPeripherals:
 *
 *  @discussion Invoked when the central retrieved the list of peripherals currently connected to the system.
 *      See the -[retrieveConnectedPeripherals] method for more information.
 *
 */
- (void)centralManager:(CBCentralManager *)central didRetrieveConnectedPeripherals:(NSArray *)peripherals{
    
}

/*!
 *  @method centralManager:didDiscoverPeripheral:advertisementData:RSSI:
 *
 *  @discussion Invoked when the central discovered a peripheral while scanning.
 *      The advertisement / scan response data is stored in "advertisementData", and
 *      can be accessed through the CBAdvertisementData* keys.
 *      The peripheral must be retained if any command is to be performed on it.
 *
 */

typedef struct {
    int index;
    int RSSI;
}PERIPHERALS_RSSI;

//中心设备发现外围BLE设备后的回调，包含广播数据包，如果发现已经在列表中的设备，则覆盖保存一次

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    NSArray *rssiArray;
    NSNotificationCenter *nc;
    int i;
    
//    //NSLog(@"Scanner_Step_ 3: BLE MOUDLE 收到设备，发出通知 ！\r\n");
    //NSLog(@"RSSI : %d\r\n",[RSSI intValue]);
    
    //NSLog(@"advertisementData = %@",advertisementData);

    //只搜索Grill Now
    if(![peripheral.name containsString:@"Grill Now"]){
        return;
    }
    
    i = 0 ;
    if (!self.peripherals)      //列表为空，第一次发现新设备
        self.peripherals = [[NSMutableArray alloc] initWithObjects:peripheral,nil];
    else {                      //列表中有曾经发现的设备，如果重复发现则刷新，
        for(i = 0; i < self.peripherals.count; i++) {
            CBPeripheral *p = [self.peripherals objectAtIndex:i];
//            if ([self UUIDSAreEqual:p.UUID u2:peripheral.UUID]) {
              if (p.UUID == peripheral.UUID) {
                [self.peripherals replaceObjectAtIndex:i withObject:peripheral];
//                //NSLog(@"//step_3 Duplicate UUID found updating ...\r\n");
                //发送外围设备的序号，以及RSSI通知
                  rssiArray = [NSArray arrayWithObjects:[NSNumber numberWithInt:i],RSSI, nil];
                  if(isScan)
                  {
                     nc = [NSNotificationCenter defaultCenter];
                     [nc postNotificationName: @"BLEDEVICEWITHRSSIFOUND" object: rssiArray];
                  }
                return;
            }
        }
        //发现的外围设备，被保存在对象的peripherals 缓冲中
        [self->peripherals addObject:peripheral];
//        //NSLog(@"New UUID, adding\r\n");
    }
//    //NSLog(@"//step_2 didDiscoverPeripheral\r\n");
    //发送外围设备的序号，以及RSSI通知
    rssiArray = [NSArray arrayWithObjects:[NSNumber numberWithInt:i],RSSI, nil];
//    //NSLog(@"%@",rssiArray);
    if(isScan)
    {
        nc = [NSNotificationCenter defaultCenter];

        [nc postNotificationName: @"BLEDEVICEWITHRSSIFOUND" object: rssiArray];

    }
}

/*!
 *  @method centralManager:didConnectPeripheral:
 *
 *  @discussion Invoked whenever a connection has been succesfully created with the peripheral.
 *
 */

//中心设备成功连接BLE外围设备
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    
    //NSLog(@"//step_7_1 Connection to peripheral with UUID : %s successfull\r\n",[self UUIDToString:peripheral.UUID]);
    self.activePeripheral = peripheral;

    //点击某个设备后，将这个设备对象作为参数，通知给属性列表窗体，在那个窗体中进行连接以及服务扫描操作。
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName: @"DIDCONNECTEDBLEDEVICE"
                      object: nil];
}

/*!
 *  @method centralManager:didFailToConnectPeripheral:error:
 *
 *  @discussion Invoked whenever a connection has failed to be created with the peripheral.
 *      The failure reason is stored in "error".
 *
 */
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    
}

/*!
 *  @method centralManager:didDisconnectPeripheral:error:
 *
 *  @discussion Invoked whenever an existing connection with the peripheral has been teared down.
 *
 */
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
}

#pragma mark -------BLE 外围设备代理协议方法-------
//----------------------------------------------------------------------------------------------------
//
//CBPeripheralDelegate protocol methods beneeth here
//
//----------------------------------------------------------------------------------------------------

//@optional

/*!
 *  @method peripheralDidUpdateRSSI:error:
 *
 *  @discussion Invoked upon completion of a -[readRSSI:] request.
 *      If successful, "error" is nil and the "RSSI" property of the peripheral has been updated.
 *      If unsuccessful, "error" is set with the encountered failure.
 *
 */
- (void)peripheralDidUpdateRSSI:(CBPeripheral *)peripheral error:(NSError *)error{
//    //NSLog(@"_____ RSSI : %d\r\n",[peripheral.RSSI intValue]);

    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName: @"RSSIUPDATE" object: peripheral.RSSI];
}

/*!
 *  @method peripheral:didDiscoverServices:
 *
 *  @discussion Invoked upon completion of a -[discoverServices:] request.
 *      If successful, "error" is nil and discovered services, if any, have been merged into the
 *      "services" property of the peripheral.
 *      If unsuccessful, "error" is set with the encountered failure.
 *
 */
//- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error;

/*
 *  @method didDiscoverServices
 *
 *  @param peripheral Pheripheral that got updated
 *  @error error Error message if something went wrong
 *
 *  @discussion didDiscoverServices is called when CoreBluetooth has discovered services on a
 *  peripheral aftr the discoverServices routine has been called on the peripheral
 *
 */

//服务发现完成之后的回调方法
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    if (!error) {
        //NSLog(@"//step_8_1 Services of peripheral with UUID : %s found\r\n",[self UUIDToString:peripheral. UUID]);
        //触发获取所有特征值
        [self getAllCharacteristicsFromKeyfob:peripheral];
        //NSLog(@" Discovering Services Finished ! \r\n");
        
        NSNumber *n =  [NSNumber numberWithFloat:1.0];
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc postNotificationName: @"SERVICEFOUNDOVER" object: n];
    }
    else {
        //NSLog(@"Service discovery was unsuccessfull !\r\n");
    }
}

/*!
 *  @method peripheral:didDiscoverIncludedServicesForService:error:
 *
 *  @discussion Invoked upon completion of a -[discoverIncludedServices:forService:] request.
 *      If successful, "error" is nil and discovered services, if any, have been merged into the
 *      "includedServices" property of the service.
 *      If unsuccessful, "error" is set with the encountered failure.
 *
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverIncludedServicesForService:(CBService *)service error:(NSError *)error{
    
}

/*!
 *  @method peripheral:didDiscoverCharacteristicsForService:error:
 *
 *  @discussion Invoked upon completion of a -[discoverCharacteristics:forService:] request.
 *      If successful, "error" is nil and discovered characteristics, if any, have been merged into the
 *      "characteristics" property of the service.
 *      If unsuccessful, "error" is set with the encountered failure.
 *
 */
//- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error;
/*
 *  @method didDiscoverCharacteristicsForService
 *
 *  @param peripheral Pheripheral that got updated
 *  @param service Service that characteristics where found on
 *  @error error Error message if something went wrong
 *
 *  @discussion didDiscoverCharacteristicsForService is called when CoreBluetooth has discovered
 *  characteristics on a service, on a peripheral after the discoverCharacteristics routine has been called on the service
 *
 */

//发现服务的特征值之后的回调方法，主要是打印所有服务的特征值。

- (void)                    peripheral:(CBPeripheral *)peripheral
  didDiscoverCharacteristicsForService:(CBService *)service
                                 error:(NSError *)error {
    static int index = 0 ;
//    float f0 ;
    
    if (!error) {
        //NSLog(@"//step_10 Characteristics of service with UUID : %s found\r\n",[self CBUUIDToString:service.UUID]);
        index ++ ;
        
        //开始打印所有服务UUID的所有特征值UUID
        //NSLog(@"-----------刚扫描到特征参数之后的值---------第1步结束");//Jason++
        
        for(int i=0; i < service.characteristics.count; i++) {
            
            CBCharacteristic *c = [service.characteristics objectAtIndex:i];
            [self SaveToActiveCharacteristic:c];

            //NSLog(@"//step_10_x Found characteristic %s\r\n",[ self CBUUIDToString:c.UUID]);
           
//            [self DisplayCharacteristicMessage:c];
            /*
            //寻找最后一个服务的UUID
            CBService *s = [peripheral.services objectAtIndex:(peripheral.services.count - 1)];
            
            //当前和最后一个进行比较，如果相同则表示已经到了末尾
            if([self compareCBUUID:service.UUID UUID2:s.UUID]) {
//                //NSLog(@"//step_11 Finished discovering characteristics. \r\n");
                //完整地读取所有服务特征值，初始化keyfob(打开各种特征值改变通知使能，设定定时读取事件，等)
                //                [[self delegate] keyfobReady];
                index = 0 ;
                f0 = 1.0 ;
            }
            else{
                f0 = 0.1*(((float)(i+1))/service.characteristics.count) ;
                f0 += (((float)(index))/peripheral.services.count) ;
            }
            //计算获取了多少服务的特征值，每个服务包含个数不同的特征值： 进度 = 第几个/总服务数
//            //NSLog(@"f0 = %3.2f",f0);
             */
        }

        NSNumber *m =  [NSNumber numberWithFloat:0.25];
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc postNotificationName: @"DOWNLOADSERVICEPROCESSSTEP" object: m];
        
        //NSLog(@" Discovering characteristics Finished ! \r\n");
        
    }
    else {
        //NSLog(@"Characteristic discorvery unsuccessfull !\r\n");
        index = 0 ;
    }
    
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"1800"]])
    {
        for (CBCharacteristic *aChar in service.characteristics)//遍历此服务的所有特征值
        {
            if ([aChar.UUID isEqual:[CBUUID UUIDWithString:@"2A04"]])
            {
                [peripheral readValueForCharacteristic:aChar];
                //NSLog(@"//step_10_y Found a Connection Parameters Characteristic");
                //NSLog(@"%@", aChar);
            }
        }
    }
}

/*!
 *  @method peripheral:didUpdateValueForCharacteristic:error:
 *
 *  @discussion Invoked upon completion of a -[readValueForCharacteristic:] request or on the reception of a notification/indication.
 *      If unsuccessful, "error" is set with the encountered failure.
 *
 */
//- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error;


/*
 *  @method didUpdateValueForCharacteristic
 *
 *  @param peripheral Pheripheral that got updated
 *  @param characteristic Characteristic that got updated
 *  @error error Error message if something went wrong
 *
 *  @discussion didUpdateValueForCharacteristic is called when CoreBluetooth has updated a
 *  characteristic for a peripheral. All reads and notifications come here to be processed.
 *
 */

//特征值更新后的回调函数，或者收到通知和提示消息后的回调
//这里会根据特征值的UUID来进行区分是哪一个特征值的更新或者改变通知
//如果这些特征值的UUID的值，事先不确定，必须靠连接后的读取来获得，必须在获取之后保存在某一个可变阵列缓冲中
//事后，根据收到的消息中的UUID和缓冲中的特征值UUID逐个比较，最终改变相应特征值的值

//特征值读取，或者得到更改通知后的回调
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
////////////////////    UInt16 characteristicUUID = [self CBUUIDToInt:characteristic.UUID];

    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    if (!error) {
        if ([self.mode compare:@"UPDATEMODE" ] == NSOrderedSame)
        {
          
//           //NSLog(@"-----------特征值改变通知----------<<<<<<<<<<");//Jason++
            if ([self isAActiveCharacteristic:(characteristic)]==YES) {
                [self UpdateToActiveCharacteristic:characteristic];
                [nc postNotificationName: @"VALUECHANGUPDATE" object: characteristic];
            }
        }else if ([self.mode compare:@"SCANMODE" ] == NSOrderedSame){
//            //NSLog(@"-----------读取特征值的值之后值----------第3步结束");//Jason++
//            if ([self isAActiveCharacteristic:(characteristic)]==YES) {
//                [self SaveToActiveCharacteristic:characteristic];
//                NSNumber *m =  [NSNumber numberWithFloat:0.75];
//                [nc postNotificationName: @"DOWNLOADSERVICEPROCESSSTEP" object: m];
//            }
            return;
        }else if ([self.mode compare:@"IDLEMODE" ] == NSOrderedSame){
//            //NSLog(@"-----------读取特征值的值之后值----------单独读");//Jason++
            if ([self isAActiveCharacteristic:(characteristic)]==YES) {
                [self SaveToActiveCharacteristic:characteristic];
                [nc postNotificationName: @"VALUECHANGUPDATE" object: Nil];
            }
        }
    }
    else {
//        //NSLog(@"Failed to read Characteristic UUID: %x", characteristicUUID);
        if ([self.mode compare:@"UPDATEMODE" ] == NSOrderedSame)
        {
            //NSLog(@"错误-----------特征值改变通知----------<<<<<<<<<<");//Jason++
        }else if ([self.mode compare:@"SCANMODE" ] == NSOrderedSame){
            //NSLog(@"错误---------读取特征值的值之后值----------第3步结束");//Jason++
            NSNumber *m =  [NSNumber numberWithFloat:0.75];
            [nc postNotificationName: @"DOWNLOADSERVICEPROCESSSTEP" object: m];
        }
    }
}
/*!
 *  @method peripheral:didWriteValueForCharacteristic:error:
 *
 *  @discussion Invoked upon completion of a -[writeValue:forCharacteristic:] request.
 *      If unsuccessful, "error" is set with the encountered failure.
 *
 */
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{

}

/*!
 *  @method peripheral:didUpdateNotificationStateForCharacteristic:error:
 *
 *  @discussion Invoked upon completion of a -[setNotifyValue:forCharacteristic:] request.
 *      If unsuccessful, "error" is set with the encountered failure.
 *
 */
//- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error;
/*
 *  @method didUpdateNotificationStateForCharacteristic
 *
 *  @param peripheral Pheripheral that got updated
 *  @param characteristic Characteristic that got updated
 *  @error error Error message if something went wrong
 *
 *  @discussion didUpdateNotificationStateForCharacteristic is called when CoreBluetooth has updated a
 *  notification state for a characteristic
 *
 */

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if (!error) {
        //NSLog(@"Updated notification state for characteristic with UUID %s on service with  UUID %s on peripheral with UUID %s\r\n",[self CBUUIDToString:characteristic.UUID],[self CBUUIDToString:characteristic.service.UUID],[self UUIDToString:peripheral.UUID]);
    }
    else {
        //NSLog(@"Error in setting notification state for characteristic with UUID %s on service with  UUID %s on peripheral with UUID %s\r\n",[self CBUUIDToString:characteristic.UUID],[self CBUUIDToString:characteristic.service.UUID],[self UUIDToString:peripheral.UUID]);
        //NSLog(@"Error code was %s\r\n",[[error description] cStringUsingEncoding:NSStringEncodingConversionAllowLossy]);
    }
}

/*!
 *  @method peripheral:didDiscoverDescriptorsForCharacteristic:error:
 *
 *  @discussion Invoked upon completion of a -[discoverDescriptorsForCharacteristic:] request.
 *      If successful, "error" is nil and discovered descriptors, if any, have been merged into the
 *      "descriptors" property of the characteristic.
 *      If unsuccessful, "error" is set with the encountered failure.
 *
 
 //NSString *strData = [[NSString alloc]initWithData: encoding:NSASCIIStringEncoding];
 //[characteristic.value description] cStringUsingEncoding:NSStringEncodingConversionAllowLossy];
 //1） cStringUsingEncoding：string -->to char
 //2） initWithCString:      char --> string
 
 //NSString 转换为char *
 NSString *blankText = @"sevensoft is a mobile software outsourcing company";
 char *ptr = [blankText cStringUsingEncoding:NSASCIIStringEncoding];
 //NSLog(@"ptr:%s\n", ptr);
 
 //char * 转换为 NSString
 char encode_buf[1024];
 NSString *encrypted = [[NSString alloc] initWithCString:(const char*)encode_buf encoding:NSASCIIStringEncoding];
 //NSLog(@"encrypted:%@", encrypted);

 */

typedef struct _INT{
    char buff[30];
}INT_STRUCT;

typedef struct scanProcessStep{
    char step[20];
}SCANPROCESSSTEP_STRUCT;

#define STEP1   0x01
#define STEP2   0x02
#define STEP3   0x04
#define STEP4   0x08

//每个特征值获取之后的回调,等获取完此服务的所有特征值之后，发出通知分组显示特征值列表

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    if (!error) {
        //NSLog(@"-----------获取特征值的结构描述之后的值---------第2步结束");//Jason++
        
        //  [self SaveToActiveCharacteristic:characteristic];
        
        [self DisplayCharacteristicMessage:characteristic];
        
        NSNumber *m =  [NSNumber numberWithFloat:0.75];//0.5 跳过第三步，不读取属性值，打开列表后手动读取
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc postNotificationName: @"DOWNLOADSERVICEPROCESSSTEP" object: m];
    }
    else {
    }

    /*
    //NSLog(@" service.UUID:%@ (%s)",characteristic.service.UUID,[self CBUUIDToString:characteristic.service.UUID]);
    //NSLog(@"         UUID:%@ (%s)",characteristic.UUID,[self CBUUIDToString:characteristic.UUID]);
    //NSLog(@"   properties:0x%02x",characteristic.properties);

    //- (void)getBytes:(void *)buffer length:(NSUInteger)length;
    //- (void)getBytes:(void *)buffer range:(NSRange)range;
    //NSLog(@" value.length:%d",characteristic.value.length);
//    //NSLog(@"        value:%@",characteristic.value.bytes);

    //如果此特征值的属性为可读，则读取这个特征值的值
//    if ((characteristic.properties&CBCharacteristicPropertyRead)!=0) {
        //并且继续读取，当前特征值的值
//        [peripheral readValueForCharacteristic:characteristic];
//    }

    //NSLog(@"descriptors count:%d",[characteristic.descriptors count]);
    
    for(int i = 0; i < [characteristic.descriptors count]; i++)
    {
//        [peripheral readValueForDescriptor:((CBDescriptor*)[characteristic.descriptors objectAtIndex:i])];
        //NSLog(@"   descriptor:%@",((CBDescriptor*)[characteristic.descriptors objectAtIndex:i]).value);
    }
    
    //NSLog(@"isBroadcasted:%d",characteristic.isBroadcasted);
    //NSLog(@"  isNotifying:%d\r\n",characteristic.isNotifying);
    */
    
//    NSString *str = @"中";
//    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
//    NSString *newStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    //NSLog(@"%@", newStr);
}

/*!
 *  @method peripheral:didUpdateValueForDescriptor:error:
 *
 *  @discussion Invoked upon completion of a -[readValueForDescriptor:] request.
 *      If unsuccessful, "error" is set with the encountered failure.
 *
 */
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error{
    if (!error) {
        //NSLog(@"-----------获取特征值描述值之后的值---------第4步结束");//Jason++
        
        //    [self DisplayCharacteristicDescriptorMessage:descriptor];
        
        //全部转移到 self.activeDescriptors ，里面包含特征值的全部信息
        if ([self.mode compare:@"SCANMODE" ] == NSOrderedSame){
            [self SaveToActiveDescriptors:descriptor];
        }
        NSNumber *m =  [NSNumber numberWithFloat:1];
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc postNotificationName: @"DOWNLOADSERVICEPROCESSSTEP" object: m];
        //descriptor中包含了此服务的所有特征值信息
    }
    else {
        
    }
}


/*!
 *  @method peripheral:didWriteValueForDescriptor:error:
 *
 *  @discussion Invoked upon completion of a -[writeValue:forDescriptor:] request.
 *      If unsuccessful, "error" is set with the encountered failure.
 *
 */
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error{
    
}

-(NSString *)getUUIDString
{
    NSString  *uuidString = nil;
    NSString *auuid = [[NSString alloc]initWithFormat:@"%@", activePeripheral.UUID];
    if (auuid.length >= 36) {
        uuidString = [auuid substringWithRange:NSMakeRange(auuid.length-36, 36)];
        //NSLog(@"uuidString:%@",uuidString);
    }
    return uuidString;
}
@end
