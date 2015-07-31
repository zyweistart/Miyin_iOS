#import "TIBLECBStandand.h"

#define STEP1   0x01
#define STEP2   0x02
#define STEP3   0x04
#define STEP4   0x08

@implementation TIBLECBStandand

#pragma mark -------BLE 结构体-------

typedef struct {
    int index;
    int RSSI;
}PERIPHERALS_RSSI;

typedef struct _INT{
    char buff[30];
}INT_STRUCT;

typedef struct scanProcessStep{
    char step[20];
}SCANPROCESSSTEP_STRUCT;

#pragma mark -------BLE 通讯模型类的方法-------

- (void)writeValue:(int)serviceUUID characteristicUUID:(int)characteristicUUID p:(CBPeripheral *)p data:(NSData *)data
{
    UInt16 s = [self swap:serviceUUID];
    UInt16 c = [self swap:characteristicUUID];
    NSData *sd = [[NSData alloc] initWithBytes:(char *)&s length:2];
    NSData *cd = [[NSData alloc] initWithBytes:(char *)&c length:2];
    CBUUID *su = [CBUUID UUIDWithData:sd];
    CBUUID *cu = [CBUUID UUIDWithData:cd];
    
    CBService *service = [self findServiceFromUUID:su p:p];
    if (!service) {
        return;
    }
    
    CBCharacteristic *characteristic = [self findCharacteristicFromUUID:cu service:service];
    if (!characteristic) {
        return;
    }
    [p writeValue:data forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
}

- (void)readValue:(int)serviceUUID characteristicUUID:(int)characteristicUUID p:(CBPeripheral *)p
{
    UInt16 s = [self swap:serviceUUID];
    UInt16 c = [self swap:characteristicUUID];
    NSData *sd = [[NSData alloc] initWithBytes:(char *)&s length:2];
    NSData *cd = [[NSData alloc] initWithBytes:(char *)&c length:2];
    CBUUID *su = [CBUUID UUIDWithData:sd];
    CBUUID *cu = [CBUUID UUIDWithData:cd];
    CBService *service = [self findServiceFromUUID:su p:p];
    if (!service) {
        return;
    }
    CBCharacteristic *characteristic = [self findCharacteristicFromUUID:cu service:service];
    if (!characteristic) {
        return;
    }
    [p readValueForCharacteristic:characteristic];
}

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
        return;
    }
    CBCharacteristic *characteristic = [self findCharacteristicFromUUID:cu service:service];
    if (!characteristic) {
        return;
    }
    [p setNotifyValue:on forCharacteristic:characteristic];
}


- (int) controlSetup: (int) s{
    self.CM = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    return 0;
}

//开始扫描传入超时秒数
- (int)findBLEPeripherals:(int)timeout
{
    if (self.CM.state  != CBCentralManagerStatePoweredOn) {
        return -1;
    }
    if (scanKeepTimer==nil) {
        scanKeepTimer = [NSTimer scheduledTimerWithTimeInterval:(float)timeout
                                         target:self
                                       selector:@selector(scanEndTimer:)
                                       userInfo:nil
                                        repeats:NO];
    }
    [self.CM stopScan];
    [self.CM scanForPeripheralsWithServices:nil options:0];
    isScan = YES;
    return 0;
}

//定时扫描结束，打印BLE设备信息
- (void)scanEndTimer:(NSTimer *)timer
{
    [self.CM stopScan];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:NOTIFICATION_STOPSCAN object: nil];
    scanKeepTimer = nil ;
}

- (void)stopScan
{
    [self.CM stopScan];
    isScan  = NO;
}

//连接指定的BLE外围设备
- (void)connectPeripheral:(CBPeripheral *)peripheral
{
    self.activePeripheral = peripheral;
    self.activePeripheral.delegate = self;
    [self.CM connectPeripheral:self.activePeripheral options:nil];
}

- (const char *)centralManagerStateToString:(int)state
{
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

- (void)getAllServicesFromKeyfob:(CBPeripheral *)p
{
    [p discoverServices:nil];
}

//获取所有服务的特征值
- (void)getAllCharacteristicsFromKeyfob:(CBPeripheral *)p
{
    //读取所有服务的特征值
    for (int i=0; i < p.services.count; i++) {
        CBService *s = [p.services objectAtIndex:i];
        //开始读取当前服务的特征值
        [p discoverCharacteristics:nil forService:s];
    }
}

- (CBService *)findServiceFromUUID:(CBUUID *)UUID p:(CBPeripheral *)p
{
    for(int i = 0; i < p.services.count; i++) {
        CBService *s = [p.services objectAtIndex:i];
        if ([self compareCBUUID:s.UUID UUID2:UUID]){
            return s;
        }
    }
    return nil;
}

- (CBCharacteristic *)findCharacteristicFromUUID:(CBUUID *)UUID service:(CBService*)service
{
    for(int i=0; i < service.characteristics.count; i++) {
        CBCharacteristic *c = [service.characteristics objectAtIndex:i];
        if ([self compareCBUUID:c.UUID UUID2:UUID]) return c;
    }
    return nil;
}

- (void)SaveToActiveCharacteristic:(CBCharacteristic *)c
{
    if (!self.activeCharacteristics){
        //列表为空，第一次发现新设备
        self.activeCharacteristics = [[NSMutableArray alloc] initWithObjects:c,nil];
    } else {
        //列表中有曾经发现的设备，如果重复发现则刷新，
        for(int i = 0; i < self.activeCharacteristics.count; i++) {
            CBCharacteristic *p = [self.activeCharacteristics objectAtIndex:i];
            if (p.UUID == c.UUID) {
                [self.activeCharacteristics replaceObjectAtIndex:i withObject:c];
                return ;
            }
        }
        //发现的外围设备，被保存在对象的peripherals 缓冲中
        [self.activeCharacteristics addObject:c];
    }
}

- (void)UpdateToActiveCharacteristic:(CBCharacteristic *)c
{
    if (!self.activeCharacteristics){
        //列表为空，第一次发现新设备
    }
    for(int i = 0; i < self.activeCharacteristics.count; i++) {
        CBCharacteristic *p = [self.activeCharacteristics objectAtIndex:i];
        if (p.UUID == c.UUID) {
            [self.activeCharacteristics replaceObjectAtIndex:i withObject:c];
            [self DisplayCharacteristicMessage:c];
            return ;
        }
    }
}

- (BOOL)isAActiveCharacteristic:(CBCharacteristic *)c
{
    for(int i = 0; i < self.activeCharacteristics.count; i++) {
        CBCharacteristic *p = [self.activeCharacteristics objectAtIndex:i];
        if (p.UUID == c.UUID) {
            return YES;
        }
    }
    return NO;
}

-(void)SaveToActiveDescriptors:(CBDescriptor *)descriptor
{
    //列表中有曾经发现的设备，如果重复发现则刷新，
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
}

- (id)GetCharcteristicDiscriptorFromActiveDescriptorsArray:(CBCharacteristic *)characteristic
{
    for(int i = 0; i < self.activeDescriptors.count; i++) {
        CBDescriptor *p = [self.activeDescriptors objectAtIndex:i];
        if (p.characteristic.UUID == characteristic.UUID) {
            return p.value;
        }
    }
    return nil;
}

//中心设备发现外围BLE设备后的回调，包含广播数据包，如果发现已经在列表中的设备，则覆盖保存一次
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    NSArray *rssiArray;
    NSNotificationCenter *nc;
    //过滤搜索的设备
    if(![peripheral.name containsString:@"Grill Now"]){
        return;
    }
    int i = 0 ;
    if (!self.peripherals) {
        //列表为空，第一次发现新设备
        self.peripherals = [[NSMutableArray alloc] initWithObjects:peripheral,nil];
    } else {
        //列表中有曾经发现的设备，如果重复发现则刷新，
        for(i = 0; i < self.peripherals.count; i++) {
            CBPeripheral *p = [self.peripherals objectAtIndex:i];
              if (p.UUID == peripheral.UUID) {
                [self.peripherals replaceObjectAtIndex:i withObject:peripheral];
                //发送外围设备的序号，以及RSSI通知
                rssiArray = [NSArray arrayWithObjects:[NSNumber numberWithInt:i],RSSI, nil];
                if(isScan) {
                    nc = [NSNotificationCenter defaultCenter];
                    [nc postNotificationName:NOTIFICATION_BLEDEVICEWITHRSSIFOUND object: rssiArray];
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
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    self.activePeripheral = peripheral;
    //点击某个设备后，将这个设备对象作为参数，通知给属性列表窗体，在那个窗体中进行连接以及服务扫描操作。
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:NOTIFICATION_DIDCONNECTEDBLEDEVICE object: nil];
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    //断开连接
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName: NOTIFICATION_DISCONNECTPERIPHERAL object: peripheral.RSSI];
}

#pragma mark -------BLE 外围设备代理协议方法-------

- (void)peripheralDidUpdateRSSI:(CBPeripheral *)peripheral error:(NSError *)error{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName: @"RSSIUPDATE" object: peripheral.RSSI];
}

//服务发现完成之后的回调方法
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    if (!error) {
        //触发获取所有特征值
        [self getAllCharacteristicsFromKeyfob:peripheral];
        
        NSNumber *n =  [NSNumber numberWithFloat:1.0];
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc postNotificationName:NOTIFICATION_SERVICEFOUNDOVER object: n];
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
        //遍历此服务的所有特征值
        for (CBCharacteristic *aChar in service.characteristics) {
            if ([aChar.UUID isEqual:[CBUUID UUIDWithString:@"2A04"]]) {
                [peripheral readValueForCharacteristic:aChar];
            }
        }
    }
}

//特征值更新后的回调函数，或者收到通知和提示消息后的回调
//这里会根据特征值的UUID来进行区分是哪一个特征值的更新或者改变通知
//如果这些特征值的UUID的值，事先不确定，必须靠连接后的读取来获得，必须在获取之后保存在某一个可变阵列缓冲中
//事后，根据收到的消息中的UUID和缓冲中的特征值UUID逐个比较，最终改变相应特征值的值
//特征值读取，或者得到更改通知后的回调
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {

    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    if (!error) {
        if ([self.mode compare:@"UPDATEMODE" ] == NSOrderedSame) {
            if ([self isAActiveCharacteristic:(characteristic)]==YES) {
                [self UpdateToActiveCharacteristic:characteristic];
                [nc postNotificationName:NOTIFICATION_VALUECHANGUPDATE object: characteristic];
            }
        } else if ([self.mode compare:@"SCANMODE" ] == NSOrderedSame){
            return;
        } else if ([self.mode compare:@"IDLEMODE" ] == NSOrderedSame){
            if ([self isAActiveCharacteristic:(characteristic)]==YES) {
                [self SaveToActiveCharacteristic:characteristic];
                [nc postNotificationName:NOTIFICATION_VALUECHANGUPDATE object: Nil];
            }
        }
    } else {
        if ([self.mode compare:@"UPDATEMODE" ] == NSOrderedSame) {
        } else if ([self.mode compare:@"SCANMODE" ] == NSOrderedSame){
            NSNumber *m =  [NSNumber numberWithFloat:0.75];
            [nc postNotificationName:NOTIFICATION_DOWNLOADSERVICEPROCESSSTEP object: m];
        }
    }
}

//每个特征值获取之后的回调,等获取完此服务的所有特征值之后，发出通知分组显示特征值列表
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    if (!error) {
        [self DisplayCharacteristicMessage:characteristic];
        //0.5 跳过第三步，不读取属性值，打开列表后手动读取
        NSNumber *m =  [NSNumber numberWithFloat:0.75];
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc postNotificationName:NOTIFICATION_DOWNLOADSERVICEPROCESSSTEP object: m];
    } else {
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error
{
    if (!error) {
        //全部转移到 self.activeDescriptors ，里面包含特征值的全部信息
        if ([self.mode compare:@"SCANMODE" ] == NSOrderedSame){
            [self SaveToActiveDescriptors:descriptor];
        }
        NSNumber *m =  [NSNumber numberWithFloat:1];
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc postNotificationName: NOTIFICATION_DOWNLOADSERVICEPROCESSSTEP object: m];
    }
}

#pragma mark -------BLE 自定义方法-------

- (UInt16)swap:(UInt16)s
{
    UInt16 temp = s << 8;
    temp |= (s >> 8);
    return temp;
}

- (NSString *)getUUIDString
{
    NSString  *uuidString = nil;
    NSString *auuid = [[NSString alloc]initWithFormat:@"%@", self.activePeripheral.UUID];
    if (auuid.length >= 36) {
        uuidString = [auuid substringWithRange:NSMakeRange(auuid.length-36, 36)];
    }
    return uuidString;
}

- (int)UUIDSAreEqual:(CFUUIDRef)u1 u2:(CFUUIDRef)u2
{
    CFUUIDBytes b1 = CFUUIDGetUUIDBytes(u1);
    CFUUIDBytes b2 = CFUUIDGetUUIDBytes(u2);
    if (memcmp(&b1, &b2, 16) == 0) {
        return 1 ;
    }
    return 0 ;
}

- (const char *)CBUUIDToString:(CBUUID *)UUID
{
    return [[UUID.data description] cStringUsingEncoding:NSStringEncodingConversionAllowLossy];
}

- (const char *)UUIDToString:(CFUUIDRef)UUID
{
    if (!UUID) return "NULL";
    CFStringRef s = CFUUIDCreateString(NULL, UUID);
    return CFStringGetCStringPtr(s, 0);
    
}

- (int)compareCBUUID:(CBUUID *)UUID1 UUID2:(CBUUID *)UUID2
{
    char b1[16];
    char b2[16];
    [UUID1.data getBytes:b1];
    [UUID2.data getBytes:b2];
    if (memcmp(b1, b2, UUID1.data.length) == 0)return 1;
    else return 0;
}

- (int)compareCBUUIDToInt:(CBUUID *)UUID1 UUID2:(UInt16)UUID2
{
    char b1[16];
    [UUID1.data getBytes:b1];
    UInt16 b2 = [self swap:UUID2];
    if (memcmp(b1, (char *)&b2, 2) == 0) return 1;
    else return 0;
}

- (UInt16)CBUUIDToInt:(CBUUID *)UUID
{
    char b1[16];
    [UUID.data getBytes:b1];
    return ((b1[0] << 8) | b1[1]);
}

- (CBUUID *)IntToCBUUID:(UInt16)UUID
{
    char t[16];
    t[0] = ((UUID >> 8) & 0xff); t[1] = (UUID & 0xff);
    NSData *data = [[NSData alloc] initWithBytes:t length:16];
    return [CBUUID UUIDWithData:data];
}

#pragma mark -------BLE 空方法方法-------
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error
{
    
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (!error) {
    } else {
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    
}

- (void)DisplayCharacteristicDescriptorMessage:(CBDescriptor *)d
{
    CBCharacteristic *c = d.characteristic;
    INT_STRUCT buf1;
    [c.value getBytes:&buf1 length:c.value.length];
    for(int i=0; i < c.value.length; i++) {
        
    }
    
}

-(void) DisplayCharacteristicMessage:(CBCharacteristic *)c{
    return;
}

#pragma mark -------BLE 中心设备代理协议方法-------
//中心设备管理器状态更新回调函数
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    
}

- (void)centralManager:(CBCentralManager *)central didRetrievePeripherals:(NSArray *)peripherals
{
    
}

- (void)centralManager:(CBCentralManager *)central didRetrieveConnectedPeripherals:(NSArray *)peripherals
{
    
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverIncludedServicesForService:(CBService *)service error:(NSError *)error{
    
}

@end
