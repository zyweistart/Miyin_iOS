#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreBluetooth/CBService.h>

//连接设备成功
#define NOTIFICATION_DIDCONNECTEDBLEDEVICE @"DIDCONNECTEDBLEDEVICE"
//扫描结束发出
#define NOTIFICATION_STOPSCAN @"STOPSCAN"
//
#define NOTIFICATION_BLEDEVICEWITHRSSIFOUND @"BLEDEVICEWITHRSSIFOUND"
//服务发现完成之后的回调方法
#define NOTIFICATION_SERVICEFOUNDOVER @"SERVICEFOUNDOVER"
//成功扫描所有服务特征值
#define NOTIFICATION_DOWNLOADSERVICEPROCESSSTEP @"DOWNLOADSERVICEPROCESSSTEP"
//
#define NOTIFICATION_VALUECHANGUPDATE @"VALUECHANGUPDATE"


@interface TIBLECBStandanda : NSObject<CBCentralManagerDelegate, CBPeripheralDelegate>{
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
- (void)connectPeripheral:(CBPeripheral*)peripheral;
-(void) notification:(int)serviceUUID characteristicUUID:(int)characteristicUUID p:(CBPeripheral *)p on:(BOOL)on;

@end
