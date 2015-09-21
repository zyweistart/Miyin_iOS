//
//  DeviceDetailViewController.m
//  Graff Now
//
//  Created by Yang Shubo on 13-8-22.
//  Copyright (c) 2013年 Yang Shubo. All rights reserved.
//

#import "DeviceDetailViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "BLEUtility.h"
@interface DeviceDetailViewController ()

@end

@implementation DeviceDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTest4:(id)sender {
    //[self.Device writeInt16:@"FFA0" CID:@"FFA3" Value:1];
    // 读取某个特征值
    [BLEUtility readCharacteristic:self.Device.Peripheral sUUID:@"FFA0" cUUID:@"2803"];
    
    
}

- (IBAction)onTest3:(id)sender {
    //[self.Device writeByte:@"1802" CID:@"2A06" Value:2];
       // 读取某个特征值
    [BLEUtility readCharacteristic:self.Device.Peripheral sUUID:@"FFA0" cUUID:@"FFA1"];
    // [self.Device writeByte:@"FFA0" CID:@"FFA1" Value:2];
}

- (IBAction)onTest:(id)sender {
        // 读取某个特征值
    [BLEUtility readCharacteristic:self.Device.Peripheral sUUID:@"FFA0" cUUID:@"2803"];
    
    [self.BLEDevice.p readRSSI];
     
}
- (IBAction)onTest2:(id)sender { // 写数据
    [self.Device writeByte:@"FFA0" CID:@"FFA1" Value:1];
    

    //[BLEUtility readCharacteristic:self.BLEDevice.p sUUID:@"FFA0" cUUID:@"FFA1"];
}
@end
