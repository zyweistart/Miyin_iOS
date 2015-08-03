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
    CButton *bDemo;
    CButton *bScan;
}

- (id)init
{
    self=[super init];
    if(self){
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
        bDemo=[[CButton alloc]initWithFrame:CGRectMake1(40, 0, 100, 40) Name:LOCALIZATION(@"Demo") Type:1];
        [bDemo addTarget:self action:@selector(goDemo) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:bDemo];
        bScan=[[CButton alloc]initWithFrame:CGRectMake1(180, 0, 100, 40) Name:LOCALIZATION(@"Scan") Type:1];
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
    [self ConnectedState];
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
    if([self.appDelegate.bleManager.peripherals count]>0){
        return [self.appDelegate.bleManager.peripherals count];
    }else{
        return 1;
    }
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
    if([self.appDelegate.bleManager.peripherals count]>0){
        
        CBPeripheral *cbPeripheral = [self.appDelegate.bleManager.peripherals objectAtIndex:[indexPath section]];
        if(cbPeripheral.name !=nil) {
            cell.lblTitle.text = [cbPeripheral name];
        } else {
            cell.lblTitle.text = LOCALIZATION(@"Unknown");
        }
        NSString *uuid=cbPeripheral.identifier.UUIDString;
        [cell.lblAddress setText:uuid];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        if(self.appDelegate.bleManager.activePeripheral){
            if ([uuid isEqualToString:self.appDelegate.bleManager.activePeripheral.identifier.UUIDString]) {
                if(self.appDelegate.bleManager.activePeripheral.state==CBPeripheralStateConnected){
                    [self ConnectedState];
                    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
                } else if(self.appDelegate.bleManager.activePeripheral.state==CBPeripheralStateConnecting){
                }
            }
        }
        return  cell;
    }else{
        cell.lblTitle.text = @"暂无设备";
        [cell.lblAddress setText:@""];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.appDelegate.bleManager.peripherals count]>0){
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
                    return;
                }
            }
        }
        [self RefreshStateConnecting];
        [self.appDelegate.bleManager connectPeripheral:cbPeripheral];
    }else{
        [self startScan];
    }
}

- (void)RefreshStateStart
{
    [lblState setText:LOCALIZATION(@"Scan...")];
}

- (void)RefreshStateConnecting
{
    if(self.mTimer){
        [self.mTimer invalidate];
        self.mTimer=nil;
    }
    self.mTimer=[NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(connectTimerout) userInfo:nil repeats:NO];
    [lblState setText:LOCALIZATION(@"Connecting...")];
}

- (void)RefreshStateNormal
{
    if(self.mTimer){
        [self.mTimer invalidate];
        self.mTimer=nil;
    }
    [lblState setText:@""];
}

- (void)connectTimerout
{
    [self RefreshStateNormal];
    if(self.appDelegate.bleManager.activePeripheral!=nil){
        if(self.appDelegate.bleManager.activePeripheral.state==CBPeripheralStateConnecting){
            [Common alert:LOCALIZATION(@"The connection timeout, please try again")];
            [self startScan];
        }
    }
}

- (void)ConnectedState
{
    [self cTitle:LOCALIZATION(@"BBQ Unconnected")];
    if(self.appDelegate.bleManager.activePeripheral){
        if(self.appDelegate.bleManager.activePeripheral.state==CBPeripheralStateConnected){
            [self cTitle:LOCALIZATION(@"BBQ Connected")];
        }
    }
}

//开始扫描
- (void)startScan
{
    if(self.appDelegate.bleManager.CM.state==CBCentralManagerStatePoweredOn){
        [self RefreshStateStart];
        //定时扫描持续时间7秒
        [self.appDelegate.bleManager.peripherals removeAllObjects];
        [self.tableView reloadData];
        [self.appDelegate.bleManager findBLEPeripherals:10];
    }
}

//发现设备
- (void)bleDeviceWithRSSIFound
{
    [self.tableView reloadData];
    for(CBPeripheral *cp in self.appDelegate.bleManager.peripherals){
        //判断是否存在自动连接设备
        if([cp.identifier.UUIDString isEqualToString:[[Data Instance]getAutoConnected]]){
            [self RefreshStateNormal];
            [self RefreshStateConnecting];
            [self.appDelegate.bleManager connectPeripheral:cp];
            return;
        }
    }
}

//停止设备扫描
- (void)stopScanBLEDevice
{
    [self stopScan];
}

//服务发现完成之后的回调方法
- (void)ServiceFoundOver
{
    [self stopScan];
    [self RefreshStateNormal];
    [self.tableView reloadData];
    //自动存储连接信息方便下次连接
    NSString *uuid=self.appDelegate.bleManager.activePeripheral.identifier.UUIDString;
    [[Data Instance]setAutoConnected:uuid];
//    [self goMainPage];
    [self performSelector:@selector(goMainPage) withObject:nil afterDelay:0.5];
}

- (void)stopScan
{
    [self RefreshStateNormal];
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

- (void)changeLanguageText
{
    [bDemo setTitle:LOCALIZATION(@"Demo") forState:UIControlStateNormal];
    [bScan setTitle:LOCALIZATION(@"Scan") forState:UIControlStateNormal];
    [self.tableView reloadData];
}

@end