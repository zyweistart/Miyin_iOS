//
//  DeviceSelecterViewController.m
//  Graff Now
//
//  Created by Yang Shubo on 13-8-26.
//  Copyright (c) 2013年 Yang Shubo. All rights reserved.
//
#import "Marcro.h"
#import "DeviceSelecterViewController.h"
#import "DeviceSeleterCell.h"
#import "Device.h"
#import "TimerViewController.h"
#import "DataCenter.h"
#import "SettingViewController.h"
#import "AboutViewController.h"
#import "MyHomeViewController.h"

@interface DeviceSelecterViewController ()

@end

@implementation DeviceSelecterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.tvDevice reloadData];
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    self.navigationController.navigationBarHidden=YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(msgNewDevice:) name:MSG_NEW_DEVICE object:nil];
    [DataCenter getInstance].CurrentDevice = [[Device alloc] init];
    //[device Start];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)msgNewDevice:(NSNotification*) notify
{

    //NSLog("111");
    [self.tvDevice reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [DataCenter getInstance].CurrentDevice.sensorTags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //tableView
   
    DeviceSeleterCell * cell = [tableView dequeueReusableCellWithIdentifier:@"DeviceSeleterCell"];
    if(!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DeviceSelecterCell" owner:self options:nil]lastObject];
    }
    
    //[cell.indicatorView stopAnimating];
    CBPeripheral *p = [[DataCenter getInstance].CurrentDevice.sensorTags objectAtIndex:indexPath.row];
    //NSString* name= @"Grill Now Touch";
    //cell.lbIndex.text = [NSString stringWithFormat:@"%d",indexPath.row+1];
    if([DataCenter getInstance].CurrentDevice.sensorTags.count> indexPath.row){
        //CBPeripheral* p = [[DataCenter getInstance].CurrentDevice.sensorTags objectAtIndex:indexPath.row];
        //name = p.name;
    }
    
    [cell SetContent:[NSString stringWithFormat:@"%ld",(long)indexPath.row+1] Name:p.name];
    
    cell.BindPeripheral = [[DataCenter getInstance].CurrentDevice.sensorTags objectAtIndex:indexPath.row];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(checkConnectiongtimer)
    {
        [checkConnectiongtimer invalidate];
    }

    CBPeripheral* p = [[DataCenter getInstance].CurrentDevice.sensorTags objectAtIndex:indexPath.row];
    [[DataCenter getInstance].CurrentDevice Connect:p];
    
    checkConnectiongtimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(OnCheckConnect) userInfo:nil repeats:YES];
    checkTimeout=0;
    [viewWait setHidden:NO];
    
}
-(void)OnCheckConnect
{
    checkTimeout++;
    //[DataCenter getInstance].CurrentDevice.Peripheral.
    //NSLog(@"Connected: %d",[DataCenter getInstance].CurrentDevice.Peripheral.isConnected);
    if([DataCenter getInstance].CurrentDevice.IsConnected)
    {
        [viewWait setHidden:YES];
        [checkConnectiongtimer invalidate];
        
        [[DataCenter getInstance].CurrentDevice.manager stopScan];
        
        [DataCenter getInstance].CurrentDevice.ManualDisconnectd=NO;
        
        [[DataCenter getInstance].CurrentDevice Start];
        //[self.navigationController pushViewController:tbc animated:YES];
        
        checkTimeout=0;
        [self NavMainView];
        return;
        //[[DataCenter getInstance].CurrentDevice FunStartGetTemperature:YES];
    }
    if(checkTimeout>5)
    {
        [checkConnectiongtimer invalidate];
        [viewWait setHidden:YES];
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Connecting time out" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
   
}
- (IBAction)OnScan:(id)sender {
    if([DataCenter getInstance].CurrentDevice!=nil)
    {
        [[DataCenter getInstance].CurrentDevice  Start];
    }
    [self.tvDevice reloadData];
}
-(void)NavMainView
{
    UITabBarController *tbc = [[UITabBarController alloc] init];
    tbc.tabBar.backgroundColor = RGBMAKE(0x76, 0x6c, 0x5e, 0xFF);
    tbc.tabBar.tintColor = RGBMAKE(0x76, 0x6c, 0x5e, 0xFF);
    //#f97806
    [tbc.tabBar setTintColor:RGBMAKE(0xf9, 0x80, 0x06,0xFF)];
    
    
    MyHomeViewController * main = [[MyHomeViewController alloc] init];
    main.title = @"Home";
    if (self.isDemo == 3) {
        main.isDemo = 2;
    }
    main.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Home" image:[UIImage imageNamed:@"bottom_ico_index"] tag:1];
    
    TimerViewController* timer = [[TimerViewController alloc] init];
    timer.title = @"Timer";
    timer.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Timer" image:[UIImage imageNamed:@"bottom_ico_timer"] tag:2];
    
    SettingViewController * setting = [[SettingViewController alloc] init];
    setting.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Setting" image:[UIImage imageNamed:@"bottom_ico_setup"] tag:3];
    
    AboutViewController* about = [[AboutViewController alloc] init];
    about.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Info" image:[UIImage imageNamed:@"bottom_ico_about"] tag:3];
    
    tbc.viewControllers = [NSArray arrayWithObjects:main, timer, setting, about,nil];
    
    [self.navigationController pushViewController:tbc animated:YES];
    
}
- (IBAction)onTestMode:(id)sender {
    self.isDemo = 3;
    [self NavMainView];
}
@end
