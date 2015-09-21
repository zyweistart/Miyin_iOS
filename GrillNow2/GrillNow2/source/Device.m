//
//  Device.m
//  Graff Now
//
//  Created by Yang Shubo on 13-8-21.
//  Copyright (c) 2013年 Yang Shubo. All rights reserved.
//

#import "Device.h"
#import "DataCenter.h"
#import "SBJson.h"

@implementation Device
 
-(id) init
{
    self.manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    self.manager.delegate = self;
    self.sensorTags = [[NSMutableArray alloc]init];
    isConnected2Device = NO;
    
    return [super init];
}
-(void)Connect:(CBPeripheral*)p
{
    [self.manager connectPeripheral:p options:nil];
}

-(void)dispatchMessage:(CBCharacteristic*)characteristic
{
    
}

-(void)Reset
{
    self.manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    self.manager.delegate = self;
    
    [self.sensorTags removeAllObjects];
    
}
-(void)Start
{
    [self scanForDevice:self.manager];
    [self.sensorTags removeAllObjects];
    betteryTimer = 999;
    rssiTimer = 999;
    temperatureTimer = 999;
}

-(void)Stop
{
    if(updateTimer)
    {
        [updateTimer invalidate];
    }
    self.IsConnected = NO;
    if(self.Peripheral)
    {
        [self.manager cancelPeripheralConnection:self.Peripheral];
    }
}

-(void)UpdateValues:(NSTimer *)theTimer
{
    if(!self.IsConnected)
    {
        if(!self.ManualDisconnectd)
        {
            
        }
        return;
    }//return;
    if(self.Peripheral)
    {
        rssiTimer++;
        if(rssiTimer>=5)
        {
            [self.Peripheral readRSSI];
            
        }
        betteryTimer++;
        if(betteryTimer>=15)
        {
            betteryTimer = 0;
            // 读取某个特征值
            [BLEUtility readCharacteristic:self.Peripheral sUUID:@"180F" cUUID:@"2A19"];
        }
        temperatureTimer++;
        if(temperatureTimer>=5)
        {
            temperatureTimer=0;
            [self FunStartGetTemperature:YES]; // 写数据
        }
        //
        //DISPATCHMESSAGE(MSG_DEVICE_UPDATE,nil);
    }
}
-(void)scanForDevice:(CBCentralManager*)central
{
    //CBUUID* uuid2 = [CBUUID UUIDWithString:@"FFE5"]; // 写特征
    //CBUUID* uuid1 = [CBUUID UUIDWithString:@"FFE0"]; //读特征
    //@[uuid1,uuid2]
    
//    [central scanForPeripheralsWithServices:nil options:nil];//1
    [central scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey:@YES}];//2
}
//检测中央设备状态
-(void)centralManagerDidUpdateState:(CBCentralManager *)central {
    if (central.state != CBCentralManagerStatePoweredOn) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"BLE not supported" message:@"Please turn on your blueteeth" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    else if(central.state == CBCentralManagerStatePoweredOn){
        [self scanForDevice:central];
        _num = 0;
    }
}

// 蓝牙连接断开时调用
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    
    NSLog(@"蓝牙连接断开");
    DISPATCHMESSAGE(MSG_CONNECT,nil);
    if(!self.ManualDisconnectd){
        self.ManualDisconnectd=NO;
//        DISPATCHMESSAGE(MSG_RSSI_VALUE,[NSNumber numberWithInt:999]);
        
        self.IsConnected = NO;
        [self scanForDevice:central];
        
    }
    else
    {
        self.CurrentUUID = nil;
    }
    
    [updateTimer invalidate];
    updateTimer = NULL;
}
// RSSI蓝牙信号强度
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {

    
    NSString* pUUID = [peripheral.identifier UUIDString];
     NSLog(@" %@",RSSI);
    NSLog(@"Found a BLE Device : %@",peripheral);
    _ValueRSSI = [RSSI intValue];
    if([pUUID isEqualToString:self.CurrentUUID])
    {
        [self.manager connectPeripheral:peripheral options:     nil];
        return;
    }
    
    BOOL isExist = NO;
    
    for (CBPeripheral* p in self.sensorTags) {
        if(p.identifier==NULL)
            continue;
        NSString* pStr =  [p.identifier UUIDString];//CFBridgingRelease(CFUUIDCreateString(nil,p.UUID));
        NSString* perStr = [peripheral.identifier UUIDString];//CFBridgingRelease(CFUUIDCreateString(nil,peripheral.UUID));
        if([pStr isEqualToString:perStr])
        {
            isExist=true;
            break;
        }
    }
    if(!isExist){
        [self.sensorTags addObject:peripheral];
        [[NSNotificationCenter defaultCenter] postNotificationName:MSG_NEW_DEVICE object:peripheral];
    }
}
//连接到外围设备
-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {

    NSLog(@"didConnectPeripheral");
    isConnected2Device=YES;
    peripheral.delegate = self;
    CBUUID* uuid1 = [CBUUID UUIDWithString:@"FFE0"];
    CBUUID* uuid2 = [CBUUID UUIDWithString:@"FFE5"];
    //CBUUID* uuid3 = [CBUUID UUIDWithString:@"180F"];
    //@[uuid1,uuid2]
     [peripheral discoverServices:@[uuid1,uuid2]]; // 外围设备开始寻找服务
    self.Peripheral = peripheral;
    innerPeripheral = peripheral;
    self.CurrentUUID = [peripheral.identifier UUIDString];
    // 定时读取特征 180F服务的特征
    updateTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(UpdateValues:) userInfo:updateTimer repeats:YES];
    
    [updateTimer fire];

}

// 找到服务后
-(void) peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
   
    for (CBService *s in peripheral.services) {
        NSLog(@"Discovered Service: %@",s.UUID);
        if ([s.UUID isEqual:[CBUUID UUIDWithString:@"FFE5"]] ||
            [s.UUID isEqual:[CBUUID UUIDWithString:@"FFE0"]])
        {
            self.IsConnected = YES;
            [peripheral discoverCharacteristics:nil forService:s]; // 查找服务中得特征

        }
            
        //if([[s.UUID UUIDString] isEqualToString:@"FFE5"] || [[s.UUID UUIDString] isEqualToString:@"FFE0"]){
        //    [peripheral discoverCharacteristics:nil forService:s];
        //}
    }

    self.IsConnected = YES;
}
//外围设备寻找到特征后
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    int t = 0;
    for (CBCharacteristic* ch in service.characteristics) {
        NSLog(@"Discovered Characteristics: %@",ch.UUID);
        t++;
        if(SAMEUUID(ch.UUID,@"FFE4")){
        //if([[ch.UUID UUIDString] isEqualToString:@"FFE4"]){
            // 情景一：通知：调用此方法会触发外围设备的订阅代理方法
            // (订阅特征)
            [self setNotification:[service.UUID representativeString] chUUID:[ch.UUID representativeString] value:YES];// 打开特征值通知使能开关 // 1
//            [peripheral setNotifyValue:YES forCharacteristic:ch]; // 2
            
            //情景二：读取false        [peripheral readValueForCharacteristic:ch];
        if(ch.value){
        NSString *value=[[NSString alloc]initWithData:ch.value encoding:NSUTF8StringEncoding];
        NSLog(@"温度--读取到特征值：%@",value);
            }
            
        }
        
        if (SAMEUUID(ch.UUID, @"FFE9")) {  // 写数据（发送数据）
            _writeCharacteristic = ch;
            self.discovedPeripheral = peripheral;
//            NSString *str = @"{\"alarm\":\"p1\"}";
//            NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
//            NSLog(@"Find Characteristic and Write %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
//            [peripheral writeValue:data forCharacteristic:ch type:CBCharacteristicWriteWithResponse];
        }
        
        if(SAMEUUID(ch.UUID,@"2A19")) // 订阅电池电量的特征
        {
//            [self setNotification:[service.UUID representativeString] chUUID:[ch.UUID representativeString] value:YES];
//            
//            [peripheral readValueForCharacteristic:ch];
//            if(ch.value){
//                NSString *value=[[NSString alloc]initWithData:ch.value encoding:NSUTF8StringEncoding];
//                NSLog(@"电池--读取到特征值：%@",value);
//            }
        }
    
    }
    
    
    //NSArray *characteristics    = [service characteristics];
    //CBCharacteristic *characteristic;
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    
}
// 特征值被更新后
-(void) peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    NSLog(@"UpdateNotificationStateForCharacteristic[%@] value=[%@] %@ error = %@",characteristic.UUID,characteristic.value, characteristic,error);
    
   // [self dispatchMessage:characteristic];
    
}

-(void) peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if(error){
        NSLog(@"didWriteValueForCharacteristic[%@] %@ error = %@",characteristic.UUID, characteristic,error);
    }
    NSLog(@"Write Data:%@",characteristic);
}

// 蓝牙连接失败
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    self.IsConnected = NO;
    [self scanForDevice:central];
}

// 插针温度特征   //更新特征值后（调用readValueForCharacteristic:方法或者外围设备在订阅后更新特征值都会调用此代理方法）
-(void) peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (error) {
        
        NSLog(@"Error didUpdateValueForCharacteristic:%@", error);
    }
    
    Byte *testByte = (Byte *)[characteristic.value bytes];
    for(int i=0;i<[characteristic.value length];i++)
    {
        NSLog(@"testByte = %d\n",testByte[i]);
    }
    
     DISPATCHMESSAGE(MSG_RSSI_VALUE,[NSNumber numberWithInt:_ValueRSSI]); // 蓝牙强度
    NSLog(@"rssi--2  %d",_ValueRSSI);
    _num++;
    NSString *bleNumber = [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
    NSLog(@"characteristic.value---  %@",bleNumber);
//    NSData *adata = [bleNumber dataUsingEncoding:NSUTF8StringEncoding];
    // 拼接完整地数据
//    NSMutableDictionary *dd = [[NSMutableDictionary alloc] init];
    if (characteristic.value.length>0) {
        if (_num == 1 && characteristic.value.length<20) {// 其他数据
            _myStr = bleNumber;
            _num = 0;
//            [dd setObject:@"false" forKey:@"battery"];
        }
        if (_num == 1 && characteristic.value.length == 20 && ![bleNumber hasSuffix:@"}\r\n"]) { // 插针温度数
            _fStr = bleNumber;
        }else if (_num == 1 && characteristic.value.length == 20 && [bleNumber hasSuffix:@"}\r\n"]) {
            _myStr = bleNumber;
            _num = 0;
        }
        if (_num == 2 && characteristic.value.length<20){
            _myStr = [NSString stringWithFormat:@"%@%@",_fStr,bleNumber];
            _num = 0;
//            [dd setObject:@"true" forKey:@"battery"];
        }
        if (_num == 2 && characteristic.value.length == 20){
            _sStr = bleNumber;
        }
        if(_num == 3){
            _myStr = [NSString stringWithFormat:@"%@%@%@",_fStr,_sStr,bleNumber];
            _num = 0;
        }
        
        
        
}
        NSLog(@"蓝牙数据---%@", _myStr);
    
    if (_num == 0) {
    
        
    //NSLog(@"didUpdateValueForCharacteristic");
    NSDictionary *jsonDict = [_myStr JSONValue];
    if ([jsonDict objectForKey:@"t"]) {
        NSArray *appArray = [jsonDict objectForKey:@"t"];
        DISPATCHMESSAGE(MSG_TEMPERATURE, appArray);
    }
    if([jsonDict objectForKey:@"battery"])
    {   // 电池电量
        NSString *battery = [jsonDict objectForKey:@"battery"];
        NSLog(@"电池电量%@",battery);
        DISPATCHMESSAGE(@"33",battery);
    }
    if ([jsonDict objectForKey:@"cf"])
    {
        NSString *str = [jsonDict objectForKey:@"cf"];
        if ([str isEqualToString:@"f"]) {
            [DataCenter getInstance].IsC = NO;
        } else
        {
            [DataCenter getInstance].IsC = YES;
        }
        DISPATCHMESSAGE(@"cf",nil);
        NSLog(@"单位---%@",str);
         // 温度单位，发送F，或C   {"cf": "f"}
    }
  }
}

//// 插针数据来源
//-(void)dispatchMessage:(NSTimer*)timer
//{
//    NSArray* array = (NSArray *)timer.userInfo;
//    NSNumber* bat = [array objectAtIndex:0]; // p1温度插针
//    bat = [NSNumber numberWithInt: (100 - [bat intValue]*100) ];
//    NSNumber* temp =  [array objectAtIndex:1]; // p2温度插针
////    DISPATCHMESSAGE(MSG_POWER_VALUE, bat); // 这里是电量的通知
////    DISPATCHMESSAGE(MSG_TEMPERATURE, temp);
//}
-(void)CommandWithTempFlag:(BOOL)tempFlag AlertFlag:(BOOL)alertFlag{
    
    
    
    Byte buffer[4];
    buffer[0] = 0xEB;
    buffer[1] = tempFlag == YES? 0 : 1;
    if(alertFlag)
    {
        buffer[2] = 1;
    }
    else
    {
        buffer[2] = 0;
    }
    buffer[3] = (buffer[1] + buffer[2]) & 0xFF;
    NSData* data = [NSData dataWithBytes:buffer length:4];
     NSLog(@"Find Characteristic and Write %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    //[BLEUtility writeCharacteristic:innerPeripheral sUUID:@"FFE5" cUUID:@"FFE9" data:data];
    for ( CBService *service in innerPeripheral.services ) {
        if ([service.UUID isEqual:[CBUUID UUIDWithString:@"FFE5"]]) {
            for ( CBCharacteristic *characteristic in service.characteristics ) {
                if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"FFE9"]]) {
                    /* EVERYTHING IS FOUND, WRITE characteristic ! */
                    [innerPeripheral writeValue:data forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
                    NSLog(@"Find Characteristic and Write %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                }
            }
        }
    }
    
}
-(void)ModifyUnit
{
    [self CommandWithTempFlag:[DataCenter getInstance].IsC  AlertFlag:NO ];
}

-(void)Disconnct:(CBPeripheral*)p
{
    if(p)
    {
        [self.manager cancelPeripheralConnection:p];
    }
    self.CurrentUUID = @"";
}
-(void)Alert{ // 机子报警
    [self CommandWithTempFlag:[DataCenter getInstance].IsC  AlertFlag:YES];
}
-(void)CannelAlert // 机子停止报警
{
    [self CommandWithTempFlag:[DataCenter getInstance].IsC  AlertFlag:NO];
    //[self writeByteNP:@"1802" CID:@"2A06" Value:0];
}
-(void)setNotification:(NSString*)sUUID chUUID:(NSString*)cUUID value:(bool)v
{
    // 打开特征值通知使能开关 (订阅特征)
    [BLEUtility setNotificationForCharacteristic:self.Peripheral sUUID:sUUID cUUID:cUUID enable:v];
}
// 订阅并写数据 蓝牙信号
-(void)FunStartGetTemperature:(BOOL)Flag
{
    if(Flag){
        // 打开特征值通知使能开关 (订阅特征)
        [BLEUtility setNotificationForCharacteristic:self.Peripheral sUUID:@"FFA0" cUUID:@"FFA1" enable:YES];
        [self writeByte:@"FFA0" CID:@"FFA1" Value:1];
    }
    else{
        [self writeByte:@"FFA0" CID:@"FFA1" Value:0];
    }
    //
}
// 写机子报警通知
-(void)gillNow2:(BOOL)Flag andP:(int)p
{
    NSString *str;
    if(Flag){
        
        if (p == 1) {
            str = @"{\"alarm\":\"p1\"}";
        }
        if(p == 2)
        {
           str = @"{\"alarm\":\"p2\"}";
        }
        
        NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"Find Characteristic and Write %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        //[BLEUtility writeCharacteristic:innerPeripheral sUUID:@"FFE5" cUUID:@"FFE9" data:data];
        for ( CBService *service in innerPeripheral.services ) {
            if ([service.UUID isEqual:[CBUUID UUIDWithString:@"FFE5"]]) {
                for ( CBCharacteristic *characteristic in service.characteristics ) {
                    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"FFE9"]]) {
                        /* EVERYTHING IS FOUND, WRITE characteristic ! */
                        [innerPeripheral writeValue:data forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
                        NSLog(@"Find Characteristic and Write %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                    }
                }
            }
        }
        
    }
    else{
        
        NSString *str = @"{\"alarm\":false}";
        NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"Find Characteristic and Write %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        //[BLEUtility writeCharacteristic:innerPeripheral sUUID:@"FFE5" cUUID:@"FFE9" data:data];
        for ( CBService *service in innerPeripheral.services ) {
            if ([service.UUID isEqual:[CBUUID UUIDWithString:@"FFE5"]]) {
                for ( CBCharacteristic *characteristic in service.characteristics ) {
                    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"FFE9"]]) {
                        /* EVERYTHING IS FOUND, WRITE characteristic ! */
                        [innerPeripheral writeValue:data forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
                        NSLog(@"Find Characteristic and Write %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                    }
                }
            }
        }
    }
    //
}

// 写数据，没有被调用
-(void)writeInt16:(NSString*)sid CID:(NSString*)cid Value:(int)value
{
    int16_t v   = (int16_t)value;
    NSData *data = [NSData dataWithBytes:&v length:sizeof(v)];
    //NSLog(@"Data: %@",data);
    [BLEUtility writeCharacteristic:self.Peripheral sUUID:sid cUUID:cid data:data];
}
// 写数据
-(void)writeByte:(NSString*)sid CID:(NSString*)cid Value:(int8_t)value
{
    int8_t v   = (int8_t)value;
    NSData *data = [NSData dataWithBytes:&v length:sizeof(v)];
    [BLEUtility writeCharacteristic:self.Peripheral sUUID:sid cUUID:cid data:data];
}
// 没有响应写数据
-(void)writeByteNP:(NSString*)sid CID:(NSString*)cid Value:(int8_t)value
{
    int8_t v   = (int8_t)value;
    NSData *data = [NSData dataWithBytes:&v length:sizeof(v)];
    [BLEUtility writeCharacteristicNoResponse:self.Peripheral sUUID:sid cUUID:cid data:data];
}
- (void)peripheralDidUpdateRSSI:(CBPeripheral *)peripheral error:(NSError *)error
{ 
//    _ValueRSSI = -1*[peripheral.RSSI intValue];
//    DISPATCHMESSAGE(MSG_RSSI_VALUE,[NSNumber numberWithInt:_ValueRSSI]);
}
@end

@implementation CBUUID (StringExtraction)

- (NSString *)representativeString;
{
    NSData *data = [self data];
    
    NSUInteger bytesToConvert = [data length];
    const unsigned char *uuidBytes = [data bytes];
    NSMutableString *outputString = [NSMutableString stringWithCapacity:16];
    
    for (NSUInteger currentByteIndex = 0; currentByteIndex < bytesToConvert; currentByteIndex++)
    {
        switch (currentByteIndex)
        {
            case 3:
            case 5:
            case 7:
            case 9:[outputString appendFormat:@"%02x-", uuidBytes[currentByteIndex]]; break;
            default:[outputString appendFormat:@"%02x", uuidBytes[currentByteIndex]];
        }
        
    }
    
    return outputString;
    
    NSLog(@"outputString----%@",outputString);
}

@end
