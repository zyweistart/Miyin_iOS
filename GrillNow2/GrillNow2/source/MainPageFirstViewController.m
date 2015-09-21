//
//  MainPageFirstViewController.m
//  Graff Now
//
//  Created by Yang Shubo on 13-8-21.
//  Copyright (c) 2013年 Yang Shubo. All rights reserved.
//
//https://developer.apple.com/library/ios/samplecode/TemperatureSensor/Listings/TemperatureSensor_LeTemperatureAlarmService_m.html#//apple_ref/doc/uid/DTS40012194-TemperatureSensor_LeTemperatureAlarmService_m-DontLinkElementID_9

#import "MainPageFirstViewController.h"
#import "DeviceDetailViewController.h"
#import "Device.h"
@interface MainPageFirstViewController ()

@end

@implementation MainPageFirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
       
    }
    return self;
}



- (void)viewDidLoad
{
    device = [[Device alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(On_MSG_NEW_DEVICE:) name:MSG_NEW_DEVICE object:nil];
    [super viewDidLoad];
}
-(void)On_MSG_NEW_DEVICE:(NSNotification*)notice
{
    [self.tbView reloadData];
}
-(void)viewDidAppear:(BOOL)animated
{
    [device Start];
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return device.sensorTags.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    
    CBPeripheral* p = [device.sensorTags objectAtIndex:indexPath.row];
    
    cell.textLabel.text = p.name;
    //cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",CFUUIDCreateString(nil, p.UUID)];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CBPeripheral *p = [device.sensorTags objectAtIndex:indexPath.row];
    BLEDevice *d = [[BLEDevice alloc]init];
    d.p = p;
    d.manager = device.manager;
    d.setupData = nil;//[self makeSensorTagConfiguration];
    
    DeviceDetailViewController * nextView = [[DeviceDetailViewController alloc] init];
    nextView.BLEDevice = d;
    nextView.Device = device;
    
    [d.manager connectPeripheral:p options:nil];
    
    [self.navigationController pushViewController:nextView animated:YES];
}

@end
