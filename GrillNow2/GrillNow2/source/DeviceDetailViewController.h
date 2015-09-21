
//
//  DeviceDetailViewController.h
//  Graff Now
//
//  Created by Yang Shubo on 13-8-22.
//  Copyright (c) 2013年 Yang Shubo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Device.h"
#import "BLEDevice.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface DeviceDetailViewController : UIViewController
{
    
}
- (IBAction)onTest4:(id)sender;
- (IBAction)onTest3:(id)sender;
- (IBAction)onTest:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lbText;
- (IBAction)onTest2:(id)sender;
@property(nonatomic,retain)Device* Device;
@property(nonatomic,retain)BLEDevice* BLEDevice;
@end
