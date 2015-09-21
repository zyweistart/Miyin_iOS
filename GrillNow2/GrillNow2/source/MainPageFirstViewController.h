//
//  MainPageFirstViewController.h
//  Graff Now
//
//  Created by Yang Shubo on 13-8-21.
//  Copyright (c) 2013年 Yang Shubo. All rights reserved.
//

//
//ffa0 <-> 0000ffa0-0000-1000-8000-00805f9b34fb
//2a19<->00002a19-0000-1000-8000-00805f9b34fb

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "BLEDevice.h"
#import "Device.h"

@interface MainPageFirstViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    Device* device;
}
@property (strong, nonatomic) IBOutlet UITableView *tbView;

@end
