//
//  Device.h
//  Graff Now
//
//  Created by Yang Shubo on 13-8-21.
//  Copyright (c) 2013年 Yang Shubo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "BLEDevice.h"
#import "BLEUtility.h"

#define UUIDSTR(__XX__) CFUUIDCreateString(nil,(__bridge CFUUIDRef)(__XX__))
#define UUIDSAME(__XX__,__YY__) [__XX__ isEqual:[CBUUID UUIDWithString:__YY__]]
#define DISPATCHMESSAGE(___XX___,___YY___) [[NSNotificationCenter defaultCenter] postNotificationName:___XX___ object:___YY___]

#define SAMEUUID(__xx__,__yy__) [__xx__ isEqual:[CBUUID UUIDWithString:__yy__]]

#define MSG_POWER_VALUE @"MSG_UPDATE_POWER_VALUE"
#define MSG_TEMPERATURE @"MSG_UPDATE_TEMPERATURE_VALUE"
#define MSG_RSSI_VALUE @"MSG_UPDATE_RSSI_VALUE"
#define MSG_NEW_DEVICE @"MSG_NEW_DEVICE"
#define MSG_DEVICE_UPDATE @"MSG_DEVICE_UPDATE" 
#define MSG_DEVICE_DISCONNECTED @"MSG_DEVICE_DISCONNECTED"
#define MSG_CONNECT @"MSG_CONNECT"

@interface Device : NSObject<CBCentralManagerDelegate,CBPeripheralDelegate>
{
    NSTimer * updateTimer;
    NSTimer * loopConnectTimer;
    int betteryTimer;
    int rssiTimer;
    int temperatureTimer;
    BOOL isConnected2Device;
    CBPeripheral* innerPeripheral;
    int _num;
    NSString *_fStr;
    NSString *_sStr;
    NSString *_myStr;
    NSDictionary *_itemDict;
    CBCharacteristic *_writeCharacteristic;
}
@property(nonatomic)BOOL ManualDisconnectd;
@property(atomic)BOOL IsConnected;
@property (strong,atomic) CBCentralManager *manager;
@property (strong,atomic) NSMutableArray *sensorTags;
@property(atomic,strong)CBPeripheral* Peripheral;
@property(atomic,strong)NSString* CurrentUUID;
@property(nonatomic,readonly)int ValuePowerLevel;
@property(nonatomic,assign)int ValueRSSI;
@property(nonatomic,readonly)int ValueTemperature;

@property(nonatomic,strong)CBPeripheral *discovedPeripheral;

-(void)setNotification:(NSString*)sUUID chUUID:(NSString*)cUUID value:(bool)v;
-(BOOL)IsConnected;
-(void)Reset;
-(void)FunStartGetTemperature:(BOOL)Flag;
-(void)Disconnct:(CBPeripheral*)p;
-(void)Connect:(CBPeripheral*)p;
-(void)dispatchMessage:(CBCharacteristic*)characteristic;
-(void)Start;
-(void)Stop;

-(void)ModifyUnit;

-(void)Alert;
-(void)CannelAlert;

-(void)writeInt16:(NSString*)sid CID:(NSString*)cid Value:(int)value;
-(void)writeByte:(NSString*)sid CID:(NSString*)cid Value:(int8_t)value;

-(void)gillNow2:(BOOL)Flag andP:(int)p;

@end

@interface CBUUID (StringExtraction)

- (NSString *)representativeString;

@end


