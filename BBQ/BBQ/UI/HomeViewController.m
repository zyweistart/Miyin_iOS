//
//  HomeViewController.m
//  BBQ
//
//  Created by Start on 15/7/27.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "HomeViewController.h"
#import "Tools.h"

@interface HomeViewController ()

@end

@implementation HomeViewController{
    long              receiveByteSize;  //返回数据的长度
    int               countPKSSize;     //计算收到数据包的次数
    NSMutableString   *receiveSBString;  //接收到的数据
    Boolean           *isReceive;       //是否继续接收发过来的数据
    NSInteger         SBLength;            //控制显示字符的长度
    BOOL              IsAscii ;          //默认为Ascii显示
}

- (id)init{
    self=[super init];
    if(self){
        [self cTitle:@"Home"];
        
        UIView *bottomView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 120, 40)];
        [self.tableView setTableFooterView:bottomView];
        CButton *bDemo=[[CButton alloc]initWithFrame:CGRectMake1(20, 0, 120, 40) Name:@"Scan" Type:2];
        [bDemo addTarget:self action:@selector(goScan) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:bDemo];
        CButton *bScan=[[CButton alloc]initWithFrame:CGRectMake1(180, 0, 120, 40) Name:@"Stop" Type:2];
        [bScan addTarget:self action:@selector(goStop) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:bScan];
        [self buildTableViewWithView:self.view];
        [self.tableView setTableHeaderView:bottomView];
        
        IsAscii=YES;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.appDelegate.bleManager.peripherals count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier=@"TableCellIdentifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] ;
    }
    CBPeripheral *cbPeripheral = [self.appDelegate.bleManager.peripherals objectAtIndex:[indexPath row]];
    if(cbPeripheral.name !=nil) {
        cell.textLabel.text = [cbPeripheral name];
    } else {
        cell.textLabel.text = @"暂无";
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
        }
    }else {
        [[cell detailTextLabel]setText:@""];
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

//开始扫描
- (void)goScan
{
    [self initNotification];
    [self ScanPeripheral];
    MODEL = MODEL_NORMAL;
}

//停止扫描
- (void)goStop
{
    [self.appDelegate.bleManager notification:0xFFE0 characteristicUUID:0xFFE4 p:self.appDelegate.bleManager.activePeripheral on:YES];
//    [self stopScan];
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
    [nc addObserver: self
           selector: @selector(ValueChangText:)
               name: NOTIFICATION_VALUECHANGUPDATE
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
}

//此方法刷新次数过多，会导致tableview界面无法刷新的情况发生
- (void)bleDeviceWithRSSIFound:(NSNotification *) notification
{
//    NSLog(@" 更新RSSI 值 ！\r\n");
//    [self.tableView reloadData];
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

-(void)ValueChangText:(NSNotification *)notification
{
    //这里取出刚刚从过来的字符串
    CBCharacteristic *tmpCharacter = (CBCharacteristic*)[notification object];
    CHAR_STRUCT buf1;
    //将获取的值传递到buf1中；
    [tmpCharacter.value getBytes:&buf1 length:tmpCharacter.value.length];
    //计算收到的所有数据包的长度
    receiveByteSize += tmpCharacter.value.length;
    countPKSSize++;
    if(IsAscii) {
        for(int i =0;i<tmpCharacter.value.length;i++) {
            [receiveSBString appendString:[Tools stringFromHexString:[NSString stringWithFormat:@"%02X",buf1.buff[i]&0x000000ff]]];
        }
    } else {
        //十六进制显示
        for(int i =0;i<tmpCharacter.value.length;i++) {
            [receiveSBString appendString:[NSString stringWithFormat:@"%02X",buf1.buff[i]&0x000000ff]];
        }
    }
    if(receiveSBString.length<=SBLength) {
        //处理返回的数据，让界面上显示最新的数据，为receiveSBString的后300个
//        [_receiveDataTxt setText:receiveSBString];
        NSLog(@"%@",receiveSBString);
    } else {
        NSInteger index = receiveSBString.length - SBLength;
//        NSLog(@" 截取数据 的长度 %d" ,(int)index);
        NSString *tmpStr = [receiveSBString substringFromIndex:index];
//        [_receiveDataTxt setText:tmpStr];
        NSLog(@"%@",tmpStr);
    }
}

@end