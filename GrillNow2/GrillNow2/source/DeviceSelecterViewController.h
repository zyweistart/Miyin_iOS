//
//  DeviceSelecterViewController.h
//  Graff Now
//
//  Created by Yang Shubo on 13-8-26.
//  Copyright (c) 2013年 Yang Shubo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Device.h"
@interface DeviceSelecterViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *deviceList;
    NSTimer* checkConnectiongtimer;
    IBOutlet UIView *viewWait;
    int checkTimeout;
}
@property (strong, nonatomic) IBOutlet UITableView *tvDevice;
@property (nonatomic,assign) int isDemo;
- (IBAction)OnScan:(id)sender;

- (IBAction)onTestMode:(id)sender;
-(void)NavMainView;
@end

