//
//  ConnectViewController.m
//  BBQ
//
//  Created by Start on 15/7/28.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "ConnectViewController.h"
#import "TabBarFrameViewController.h"
#import "PeripheralCell.h"
#import "Tools.h"

@interface ConnectViewController ()

@end

@implementation ConnectViewController{
    UILabel *lblState;
}

- (id)init
{
    self=[super init];
    if(self){
        [self ConnectedState:NO];
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"背景3"]]];
        [self RefreshStateNormal];
        [self buildTableViewWithView:self.view style:UITableViewStyleGrouped];
        [self.tableView setBackgroundColor:[UIColor clearColor]];
        lblState=[[UILabel alloc]initWithFrame:CGRectMake1(0, 0, 320, 100)];
        [lblState setFont:[UIFont systemFontOfSize:40]];
        [lblState setTextColor:[UIColor whiteColor]];
        [lblState setTextAlignment:NSTextAlignmentCenter];
        [self.tableView setTableHeaderView:lblState];
        
        CGFloat height=self.view.bounds.size.height-CGHeight(130);
        UIView *bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, height, CGWidth(320), CGHeight(40))];
        ;
        CButton *bDemo=[[CButton alloc]initWithFrame:CGRectMake1(40, 0, 100, 40) Name:NSLocalizedString(@"Demo",nil) Type:1];
        [bDemo addTarget:self action:@selector(goDemo) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:bDemo];
        CButton *bScan=[[CButton alloc]initWithFrame:CGRectMake1(180, 0, 100, 40) Name:NSLocalizedString(@"Scan",nil) Type:1];
        [bScan addTarget:self action:@selector(startScan) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:bScan];
        [self.view addSubview:bottomView];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self performSelector:@selector(startScan) withObject:nil afterDelay:0.5];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.appDelegate.bleManager setDelegate:self];
    if([self.appDelegate.bleManager.peripherals count]>0){
        if(self.appDelegate.bleManager.activePeripheral){
            if(self.appDelegate.bleManager.activePeripheral.state!=CBPeripheralStateConnected){
                if(![@"" isEqualToString:[[Data Instance]getAutoConnected]]){
                    [self startScan];
                    return;
                }
            }
        }
        [self.tableView reloadData];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.appDelegate.bleManager.peripherals count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CGHeight(60);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier=@"TableCellIdentifier";
    PeripheralCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell==nil){
        cell = [[PeripheralCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] ;
    }
    CBPeripheral *cbPeripheral = [self.appDelegate.bleManager.peripherals objectAtIndex:[indexPath section]];
    if(cbPeripheral.name !=nil) {
        cell.lblTitle.text = [cbPeripheral name];
    } else {
        cell.lblTitle.text = NSLocalizedString(@"Unknown",nil);
    }
    NSString *uuid=cbPeripheral.identifier.UUIDString;
    [cell.lblAddress setText:uuid];
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    if(self.appDelegate.bleManager.activePeripheral){
        if ([uuid isEqualToString:self.appDelegate.bleManager.activePeripheral.identifier.UUIDString]) {
            if(self.appDelegate.bleManager.activePeripheral.state==CBPeripheralStateConnected){
                [lblState setText:@""];
                [self ConnectedState:YES];
                //如果已经连接则显示连接状态
                [cell.lblAddress setText:NSLocalizedString(@"Connected",nil)];
                [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            } else if(self.appDelegate.bleManager.activePeripheral.state==CBPeripheralStateConnecting){
                [cell.lblAddress setText:NSLocalizedString(@"Connecting",nil)];
            }
        }
    }
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //发出通知新页面，对指定外围设备进行连接
    CBPeripheral *cbPeripheral=[self.appDelegate.bleManager.peripherals objectAtIndex:[indexPath section]];
    //判断是否已经连接
    if (self.appDelegate.bleManager.activePeripheral){
        NSString *uuid=cbPeripheral.identifier.UUIDString;
        if ([uuid isEqualToString:self.appDelegate.bleManager.activePeripheral.identifier.UUIDString]) {
            if(self.appDelegate.bleManager.activePeripheral.state==CBPeripheralStateConnected){
                [self goMainPage];
                return;
            }else if(self.appDelegate.bleManager.activePeripheral.state==CBPeripheralStateConnecting){
                [Common alert:NSLocalizedString(@"Connecting...",nil)];
                return;
            }
        }
    }
    [self.appDelegate.bleManager connectPeripheral:cbPeripheral];
}

- (void)RefreshStateStart
{
    self.mMBProgressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.mMBProgressHUD];
    self.mMBProgressHUD.dimBackground = NO;
    self.mMBProgressHUD.square = YES;
    [self.mMBProgressHUD show:YES];
    [lblState setText:NSLocalizedString(@"Scan...",nil)];
}

- (void)RefreshStateNormal
{
    [lblState setText:@""];
    if (self.mMBProgressHUD) {
        [self.mMBProgressHUD hide:YES];
    }
}

- (void)ConnectedState:(BOOL)state
{
    if(state){
        [self cTitle:NSLocalizedString(@"BBQ Connected",nil)];
    }else{
        [self cTitle:NSLocalizedString(@"BBQ Unconnected",nil)];
    }
}

//开始扫描
- (void)startScan
{
    if(self.appDelegate.bleManager.CM.state==CBCentralManagerStatePoweredOn){
        [self RefreshStateStart];
        //定时扫描持续时间10秒
        [self.appDelegate.bleManager findBLEPeripherals:10];
    }
}

//发现设备
- (void)bleDeviceWithRSSIFound
{
    NSLog(@"发现设备");
    [self.tableView reloadData];
    for(CBPeripheral *cp in self.appDelegate.bleManager.peripherals){
        //判断是否存在自动连接设备
        if([cp.identifier.UUIDString isEqualToString:[[Data Instance]getAutoConnected]]){
            [self.appDelegate.bleManager connectPeripheral:cp];
            [self RefreshStateNormal];
            return;
        }
    }
}

//连接成功
- (void)didConectedbleDevice
{
    NSLog(@"连接成功");
    [self.tableView reloadData];
    //自动存储连接信息方便下次连接
    NSString *uuid=self.appDelegate.bleManager.activePeripheral.identifier.UUIDString;
    [[Data Instance]setAutoConnected:uuid];
    //连接成功后需立即查询蓝牙服务
    [self.appDelegate.bleManager.activePeripheral discoverServices:nil];
}

//停止设备扫描
- (void)stopScanBLEDevice
{
    [self stopScan];
    [self.tableView reloadData];
    [self RefreshStateNormal];
}

//服务发现完成之后的回调方法
- (void)ServiceFoundOver
{
    [self performSelector:@selector(goMainPage) withObject:nil afterDelay:1.0];
}

- (void)stopScan
{
    if(self.appDelegate.bleManager.scanKeepTimer){
        [self.appDelegate.bleManager.scanKeepTimer invalidate];
        self.appDelegate.bleManager.scanKeepTimer=nil;
    }
    [self.appDelegate.bleManager stopScan];
}

- (void)goDemo
{
    [[Data Instance] setIsDemo:YES];
    TabBarFrameViewController *mTabBarFrameViewController=[[TabBarFrameViewController alloc]init];
    [[Data Instance]setMTabBarFrameViewController:mTabBarFrameViewController];
    [self presentViewController:mTabBarFrameViewController animated:YES completion:^{
    }];
}

- (void)goMainPage
{
    [[Data Instance] setIsDemo:NO];
    TabBarFrameViewController *mTabBarFrameViewController=[[TabBarFrameViewController alloc]init];
    [[Data Instance]setMTabBarFrameViewController:mTabBarFrameViewController];
    [self presentViewController:mTabBarFrameViewController animated:YES completion:^{
        [self stopScan];
    }];
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

@end