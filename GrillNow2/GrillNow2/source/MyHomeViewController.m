//
//  MyHomeViewController.m
//  GrillNow2
//
//  Created by JWD on 15/5/3.
//  Copyright (c) 2015年 com.efancy. All rights reserved.
//

#import "MyHomeViewController.h"
#import "DataCenter.h"
#import "FoodSelectViewController.h"
#import "Marcro.h"
#import "FootTemperatureList.h"
#import "AudioToolbox/AudioToolbox.h"
#import "AVFoundation/AVAudioPlayer.h"
//#import "DeviceSelecterViewController.h"
#import "Device.h"

@interface MyHomeViewController ()

@end

@implementation MyHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  
    _backgroundImage.userInteractionEnabled = YES; // 接受点击事件
    
    _P1View.hidden = YES; // 隐藏View
    _P2View.hidden = YES;
//    _threeButton.hidden = YES;
    _foodView.hidden = YES;
    _p1FourLabel.hidden = YES;
    _p2FourLabel.hidden = YES;

    
    _isFoodView = NO;
    lastAlertTime = 0;
    
    _foodNameButton.backgroundColor = RGBMAKE(0xfa, 0x78, 0x08, 0xFF);
    
    _P1FoodDictionary = [[NSMutableDictionary alloc] init];
    _p2FoodDictionary = [[NSMutableDictionary alloc] init];
    
    // 插针温度
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(OnTemperatureRecv:) name:MSG_TEMPERATURE object:nil];
    // 电量
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(OnPOWERRecv:) name:@"33" object:nil];
    // 蓝牙信号
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(OnRSSIRecv:) name:MSG_RSSI_VALUE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onTargetTemp:) name:MSG_ONTARGETTEMP object:nil]; // 食物温度点击通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onDisconnected:) name:MSG_DEVICE_DISCONNECTED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(OnMsgSelectFood:) name:MSG_SELECT_FOOD object:nil]; // 食物温度
    // 蓝牙连接断开时
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notNumberWithShow) name:MSG_CONNECT object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cfWithShow) name:@"cf" object:nil];
    
    [[DataCenter getInstance].CurrentDevice FunStartGetTemperature:YES]; // 订阅特征并写数据，蓝牙信号
    [DataCenter getInstance].MainMenu = self;
    
    currentFood = [DataCenter getInstance].CurrentFood;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _foodNameShow.backgroundColor = [UIColor colorWithRed:0.97f green:0.47f blue:0.02f alpha:1.00f];
    _P1SetT.text = @"72℃";
    _P2SetT.text = @"72℃";
    isP1 = 0;
    _p1ViewY = _P1View.frame.origin.y; // 保存p1的Y
    _p2ViewY = _P2View.frame.origin.y;
    _foodViewY = _foodView.frame.origin.y; // 保存食物view的Y

    if (self.isDemo == 2) {
        
        _p1T = 32;
        _p2T = 33;
        
        [DataCenter getInstance].Temperature = _p1T;
        CompareTargetTimeDuring++;
        if([DataCenter getInstance].IsC)
        {
            _P1TPLabel.text =[NSString stringWithFormat:@"%d℃", (uint)_p1T];
            _P2TPLabel.text = [NSString stringWithFormat:@"%d℃", (uint)_p2T];
            NSRange ran1 = [_P1SetT.text rangeOfString:@"℉"]; // 食物温度展示的转换
            NSRange ran2 = [_P2SetT.text rangeOfString:@"℉"];
            if (ran1.length && ran2.length) {
                NSString *str1 = [_P1SetT.text substringToIndex:ran1.location];
                int p1 = ((([str1 intValue]-32)/1.8)*10+5)/10;
                _P1SetT.text = [NSString stringWithFormat:@"%d℃",p1];
                
                NSString *str2 = [_P2SetT.text substringToIndex:ran2.location];
                int p2 = ((([str2 intValue]-32)/1.8)*10+5)/10;
                _P2SetT.text = [NSString stringWithFormat:@"%d℃",p2];
            }
        }
        else
        {
            _P1TPLabel.text =[NSString stringWithFormat:@"%d℉",  (int)[[DataCenter getInstance] ConvertC2F:_p1T]];
            _P2TPLabel.text =[NSString stringWithFormat:@"%d℉",  (int)[[DataCenter getInstance] ConvertC2F:_p2T]];
            NSRange ran1 = [_P1SetT.text rangeOfString:@"℃"]; // 食物温度展示的转换
            NSRange ran2 = [_P2SetT.text rangeOfString:@"℃"];
            if (ran1.length && ran2.length) {
                NSString *str1 = [_P1SetT.text substringToIndex:ran1.location];
                int p1 = (([str1 intValue]*1.8+32)*10+5)/10;
                _P1SetT.text = [NSString stringWithFormat:@"%d℉",p1];
                
                NSString *str2 = [_P2SetT.text substringToIndex:ran2.location];
                int p2 = (([str2 intValue]*1.8+32)*10+5)/10;
                _P2SetT.text = [NSString stringWithFormat:@"%d℉",p2];
            }
            
        }
        
        
        if (_p1T) {
            _P1View.hidden = NO;
            //        _threeButton.hidden = NO;
            _notNumber.hidden = YES;
            _p2RedView.hidden = NO;
            CGRect rect2 = _P2View.frame;
            rect2.origin.y = _p2ViewY;
            _P2View.frame = rect2;
            // 食物view
            CGRect foodViewRect2 = _foodView.frame;
            foodViewRect2.origin.y = _foodViewY;
            _foodView.frame = foodViewRect2;
            if (_p2T == 0) {
                _P2View.hidden = YES;
                CGRect rect = _P1View.frame;
                rect.origin.y = [UIScreen mainScreen].bounds.size.height/4.8;
                _P1View.frame = rect;
                // 食物view
                CGRect foodViewRect = _foodView.frame;
                foodViewRect.origin.y = [UIScreen mainScreen].bounds.size.height/2;
                _foodView.frame = foodViewRect;
            }
        }
        
        if (_p2T) {
            _P2View.hidden = NO;
            //        _threeButton.hidden = NO;
            _notNumber.hidden = YES;
            CGRect rect = _P1View.frame;
            rect.origin.y = _p1ViewY;
            _P1View.frame = rect;
            // 食物view
            CGRect foodViewRect = _foodView.frame;
            foodViewRect.origin.y = _foodViewY;
            _foodView.frame = foodViewRect;
            
            if (_p1T == 0) {
                _p2RedView.hidden = YES;
                _P1View.hidden = YES;
                CGRect rect2 = _P2View.frame;
                rect2.origin.y = [UIScreen mainScreen].bounds.size.height/4.8;
                _P2View.frame = rect2;
                // 食物view
                CGRect foodViewRect2 = _foodView.frame;
                foodViewRect2.origin.y = [UIScreen mainScreen].bounds.size.height/2;
                _foodView.frame = foodViewRect2;
            }
            
        }
    }

//    Device *devc = [[Device alloc] init];
//    NSLog(@"value----%d",devc.ValueRSSI);
//    [self OnRSSIRecv:devc.ValueRSSI];
    
}

// 蓝牙连接断开时
- (void)notNumberWithShow
{
    _notNumber.selected = YES;
    _notNumber.hidden = NO;
    _P1View.hidden = YES; // 隐藏View
    _P2View.hidden = YES;
//    _threeButton.hidden = YES;
    _foodView.hidden = YES;
    _p1FourLabel.hidden = YES;
    _p2FourLabel.hidden = YES;

}

// 食物温度
-(void)OnMsgSelectFood:(NSNotification*)msg
{
    if (_isP1orP2 == 1) {
        _isOK = NO; // 开启食物报警
    }else  if (_isP1orP2 == 2) {
        _isOK2 = NO;
    }
    
    
    currentFood = (FoodType*)msg.object;
//    _foodNameImage.image = [UIImage imageNamed:currentFood.icoImageName];
    [_foodNameButton setImage:[UIImage imageNamed:currentFood.icoImageName] forState:0];
    
    _foodNameShow.text = currentFood.FoodName; // 食物名称
    if (_isP1orP2 == 1) {
        _P1FoodName.text = currentFood.FoodName;
    } else if (_isP1orP2 == 2)
    {
       _P2FoodName.text = currentFood.FoodName;
    }
    
    int t = [DataCenter getInstance].CurrentTempTarget;
    // 设置温度值，lbMaxTemperature--温度值
    if([DataCenter getInstance].IsC){
        _showTNumber.text =[NSString stringWithFormat:@"%d℃",t];
        if (_isP1orP2 == 1) {
            _P1SetT.text =[NSString stringWithFormat:@"%d℃",t];
             // 存续各自的数据
            [_P1FoodDictionary removeAllObjects];
            [_P1FoodDictionary setObject:currentFood forKey:@"myFood"];

        } else if (_isP1orP2 == 2)
        {
           _P2SetT.text =[NSString stringWithFormat:@"%d℃",t];
            [_p2FoodDictionary removeAllObjects];
            [_p2FoodDictionary setObject:currentFood forKey:@"myFood"];
        }
    
    }
    else{
        _showTNumber.text =[NSString stringWithFormat:@"%d℉",(int)[[DataCenter getInstance] ConvertC2F:t]];
        if (_isP1orP2 == 1) {
            _P1SetT.text =[NSString stringWithFormat:@"%d℉",(int)[[DataCenter getInstance] ConvertC2F:t]];
            // 存续各自的数据
            [_P1FoodDictionary removeAllObjects];
            [_P1FoodDictionary setObject:currentFood forKey:@"myFood"];
        } else if(_isP1orP2 == 2)
        {
          _P2SetT.text =[NSString stringWithFormat:@"%d℉",(int)[[DataCenter getInstance] ConvertC2F:t]];
            [_p2FoodDictionary removeAllObjects];
            [_p2FoodDictionary setObject:currentFood forKey:@"myFood"];
        }
        
    }
    
    _foodSetTNameLabel.text = [DataCenter getInstance].CurrentTempName;
    if (_isP1orP2 == 1) {
        _P1setTName.text = [DataCenter getInstance].CurrentTempName;
        
    } else if(_isP1orP2 == 2)
    {
        _P2SetTName.text = [DataCenter getInstance].CurrentTempName;
    }
    
   }

-(void)onDisconnected:(NSNotification*)msg
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)onTargetTemp:(NSNotification*)sender // 食物温度点击通知
{
    [self setLabel:_showTNumber Content:[DataCenter getInstance].CurrentTempTarget];
    _foodSetTNameLabel.text = [DataCenter getInstance].CurrentTempName;
    
    if (_isP1orP2 == 1) {
        [self setLabel:_P1SetT Content:[DataCenter getInstance].CurrentTempTarget];
        _P1setTName.text = [DataCenter getInstance].CurrentTempName;
        _isOK = NO;
    } else if (_isP1orP2 == 2)
    {
        [self setLabel:_P2SetT Content:[DataCenter getInstance].CurrentTempTarget];
        _P2SetTName.text = [DataCenter getInstance].CurrentTempName;
        _isOK2 = NO;
    }
    
    if (_isP1orP2 == 1) {
         _p1FourLabel.hidden = NO;
    }else if (_isP1orP2 ==2){
         _p2FourLabel.hidden = NO;
    }
}


// 蓝牙信号强度
-(void)OnRSSIRecv:(NSNotification *)sender
{
    int value = ([((NSNumber*)sender.object) intValue]) * (-1);
    if(value<=55)
    {
        [_wirelessButton setBackgroundImage:[UIImage imageNamed:@"signal_3.png"] forState:0];
        //主界面_右侧图标_无线信号_3格.png
    }
    else if(value>55 && value <=90){
        [_wirelessButton setBackgroundImage:[UIImage imageNamed:@"signal_2.png"] forState:0];
    }
    else if(value>90){
        [_wirelessButton setBackgroundImage:[UIImage imageNamed:@"signal_1.png"] forState:0];
    }
}

// 电量
-(void)OnPOWERRecv:(NSNotification*)sender
{
//    int value = [((NSNumber*)sender.object) intValue];
    NSString *batteryStr = (NSString *)sender.object;
    if([batteryStr intValue] == 1) // 电量满
    {
        [_electricityButton setBackgroundImage:[UIImage imageNamed:@"battery_4.png"] forState:0];
    } else
   // if([batteryStr isEqualToString:@"false"]) // 电量低
    {
        [_electricityButton setBackgroundImage:[UIImage imageNamed:@"battery_1.png"] forState:0];
    }
}
- (void)cfWithShow
{
    [self resetUI];
}
// 摄氏度转化
-(void)setLabel:(UILabel*)lb Content:(float)content
{
    if([DataCenter getInstance].IsC){
        lb.text =[NSString stringWithFormat:@"%d℃",(int)content];
    }
    else{
        lb.text =[NSString stringWithFormat:@"%d℉",(int)[[DataCenter getInstance] ConvertC2F:content]];
    }
}
// 插针温度
-(void)OnTemperatureRecv:(NSNotification*)sender
{
    int countArray = 0;
    NSArray *myArray = (NSArray *)sender.object;
    if (myArray.count == 1) {
        for ( NSDictionary *itemDict in myArray) {
                _p1TNum = [itemDict objectForKey:@"p1"]; // p1的温度
                _p2TNum = [itemDict objectForKey:@"p2"]; // p2的温度
        }

    }else {
    for ( NSDictionary *itemDict in myArray) {
        if (countArray == 0) {
            _p1TNum = [itemDict objectForKey:@"p1"]; // p1的温度
            countArray = 1;
        }else
        _p2TNum = [itemDict objectForKey:@"p2"]; // p2的温度
    }
    }
        
    _p1T = [_p1TNum intValue];
    _p2T = [_p2TNum intValue];
    
    [DataCenter getInstance].Temperature = _p1T;
    CompareTargetTimeDuring++;
    if([DataCenter getInstance].IsC)
    {
        _P1TPLabel.text =[NSString stringWithFormat:@"%d℃", (uint)_p1T];
        _P2TPLabel.text = [NSString stringWithFormat:@"%d℃", (uint)_p2T];
       NSRange ran1 = [_P1SetT.text rangeOfString:@"℉"]; // 食物温度展示的转换
       NSRange ran2 = [_P2SetT.text rangeOfString:@"℉"];
        if (ran1.length && ran2.length) {
            NSString *str1 = [_P1SetT.text substringToIndex:ran1.location];
            int p1 = ((([str1 intValue]-32)/1.8)*10+5)/10;
            _P1SetT.text = [NSString stringWithFormat:@"%d℃",p1];
            
            NSString *str2 = [_P2SetT.text substringToIndex:ran2.location];
            int p2 = ((([str2 intValue]-32)/1.8)*10+5)/10;
            _P2SetT.text = [NSString stringWithFormat:@"%d℃",p2];
        }
    }
    else
    {
        _P1TPLabel.text =[NSString stringWithFormat:@"%d℉",  (int)[[DataCenter getInstance] ConvertC2F:_p1T]];
        _P2TPLabel.text =[NSString stringWithFormat:@"%d℉",  (int)[[DataCenter getInstance] ConvertC2F:_p2T]];
        NSRange ran1 = [_P1SetT.text rangeOfString:@"℃"]; // 食物温度展示的转换
        NSRange ran2 = [_P2SetT.text rangeOfString:@"℃"];
        if (ran1.length && ran2.length) {
            NSString *str1 = [_P1SetT.text substringToIndex:ran1.location];
            int p1 = (([str1 intValue]*1.8+32)*10+5)/10;
            _P1SetT.text = [NSString stringWithFormat:@"%d℉",p1];
            
            NSString *str2 = [_P2SetT.text substringToIndex:ran2.location];
            int p2 = (([str2 intValue]*1.8+32)*10+5)/10;
            _P2SetT.text = [NSString stringWithFormat:@"%d℉",p2];
        }

    }
    
    int p1T = 0;
    // p1插针温度达到设定温度报警
    NSRange ranC = [_P1SetT.text rangeOfString:@"℃"];
    NSRange ranF = [_P1SetT.text rangeOfString:@"℉"];
    if (ranC.length) {
        _resultStr = [_P1SetT.text substringToIndex:ranC.location]; // 截取字符串中的数字
        p1T = _p1T;
        
    } else if (ranF.length)
    {
       _resultStr = [_P1SetT.text substringToIndex:ranF.location];
        p1T = [[DataCenter getInstance] ConvertC2F:_p1T];
    }
    int foodp1 = [_resultStr intValue];
    //（二次报警） 温度报警一次后，当温度再次低于报警温度后，打开温度报警的条件
    if (p1T < foodp1) {
        _isOK = NO;
    }
    
    // 要判断是否关闭警报
    if (![DataCenter getInstance].IsC) {
        if (foodp1>32) {
            
            if(p1T >= foodp1  && _isOK == NO )
            {
                [self ffnotification:[NSString stringWithFormat:@"P1"]];// 添加本地通知
                
                if(lastAlertTime==0){
                    lastAlertTime = 1;
                    [self PlaySound:[DataCenter getInstance].TemperatureAlarm andP:1];
                }
                _isOK = YES;
            }
            else{
                lastAlertTime = 0;
            }
        }

    } else {
        if (foodp1>0) {
            
            if(p1T >= foodp1  && _isOK == NO )
            {
                [self ffnotification:[NSString stringWithFormat:@"P1"]];// 添加本地通知
                
                if(lastAlertTime==0){
                    lastAlertTime = 1;
                    [self PlaySound:[DataCenter getInstance].TemperatureAlarm andP:1];
                }
                _isOK = YES;
            }
            else{
                lastAlertTime = 0;
            }
        }

    }
    
    int p2T = 0;
    // p2插针温度达到设定温度报警
    NSRange ranC2 = [_P2SetT.text rangeOfString:@"℃"];
    NSRange ranF2 = [_P2SetT.text rangeOfString:@"℉"];
    if (ranC2.length) {
        _resultStr2 = [_P2SetT.text substringToIndex:ranC2.location]; // 截取字符串中的数字
        p2T = _p2T;
    } else if (ranF2.length)
    {
        _resultStr2 = [_P2SetT.text substringToIndex:ranF2.location];
        p2T = [[DataCenter getInstance] ConvertC2F:_p2T];
    }
    int foodp2 = [_resultStr2 intValue];
    // 二次报警
    if (p2T < foodp2) {
        _isOK2 = NO;
    }
    
    if (![DataCenter getInstance].IsC) {
        if (foodp2>32) {
            if(p2T >= foodp2  && _isOK2 == NO )
            {
                [self ffnotification:[NSString stringWithFormat:@"P2"]];// 添加本地通知
                
                if(lastAlertTime==0){
                    lastAlertTime = 1;
                    [self PlaySound:[DataCenter getInstance].TemperatureAlarm andP:2];
                }
                _isOK2 = YES;
            }
            else{
                lastAlertTime = 0;
            }
            
        }

    } else {
        if (foodp2>0) {
            if(p2T >= foodp2  && _isOK2 == NO )
            {
                [self ffnotification:[NSString stringWithFormat:@"P2"]];// 添加本地通知
                
                if(lastAlertTime==0){
                    lastAlertTime = 1;
                    [self PlaySound:[DataCenter getInstance].TemperatureAlarm andP:2];
                }
                _isOK2 = YES;
            }
            else{
                lastAlertTime = 0;
            }
            
        }

    }
    
  // 插针有温度时才能显示view
    if (myArray.count == 0) {
        _P1View.hidden = YES; // 隐藏View
        _P2View.hidden = YES;
//        _threeButton.hidden = YES;
        _foodView.hidden = YES;
        _p1FourLabel.hidden = YES;
        _p2FourLabel.hidden = YES;
        _notNumber.hidden = NO;
        
        _p1T = 0;
        _p2T = 0;
    }

    if (_p1T) {
        _P1View.hidden = NO;
//        _threeButton.hidden = NO;
        _notNumber.hidden = YES;
        _p2RedView.hidden = NO;
        CGRect rect2 = _P2View.frame;
        rect2.origin.y = _p2ViewY;
        _P2View.frame = rect2;
        // 食物view
        CGRect foodViewRect2 = _foodView.frame;
        foodViewRect2.origin.y = _foodViewY;
        _foodView.frame = foodViewRect2;
        if (_p2T == 0) {
            _P2View.hidden = YES;
            CGRect rect = _P1View.frame;
            rect.origin.y = [UIScreen mainScreen].bounds.size.height/4.8;
            _P1View.frame = rect;
            // 食物view
            CGRect foodViewRect = _foodView.frame;
            foodViewRect.origin.y = [UIScreen mainScreen].bounds.size.height/2;
            _foodView.frame = foodViewRect;
        }
    }
    
    if (_p2T) {
        _P2View.hidden = NO;
//        _threeButton.hidden = NO;
        _notNumber.hidden = YES;
        CGRect rect = _P1View.frame;
        rect.origin.y = _p1ViewY;
        _P1View.frame = rect;
        // 食物view
        CGRect foodViewRect = _foodView.frame;
        foodViewRect.origin.y = _foodViewY;
        _foodView.frame = foodViewRect;
        
        if (_p1T == 0) {
            _p2RedView.hidden = YES;
            _P1View.hidden = YES;
            CGRect rect2 = _P2View.frame;
            rect2.origin.y = [UIScreen mainScreen].bounds.size.height/4.8;
            _P2View.frame = rect2;
            // 食物view
            CGRect foodViewRect2 = _foodView.frame;
            foodViewRect2.origin.y = [UIScreen mainScreen].bounds.size.height/2;
            _foodView.frame = foodViewRect2;
        }

    }
    
    [self resetUI];
}

// 本地通知
- (void)ffnotification:(NSString *)name
{
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate=[NSDate dateWithTimeIntervalSinceNow:0];
    notification.timeZone=[NSTimeZone defaultTimeZone];
    notification.alertBody=[NSString stringWithFormat:@"%@ is finished",name];
    notification.category = @"alert";
    notification.repeatInterval = 0;// 0为不重复发送通知
    notification.soundName= UILocalNotificationDefaultSoundName; // 提示声音为默认的
    [[UIApplication sharedApplication]  scheduleLocalNotification:notification];
    
}


-(void)PlaySound:(AlarmRing*)ring andP:(int)p
{
    if(player){
        return;
    } else {
    NSString *soundFilePath =
    [[NSBundle mainBundle] pathForResource: ring.RingFilePath
                                    ofType: @"wav"];
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
    AVAudioPlayer *newPlayer =
    [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL
                                           error: nil];
    player = newPlayer;
    [player prepareToPlay];
    
    player.numberOfLoops = -1;    // Loop playback until invoke stop method
    [player play];
    }
    
//    if([ring.RingPrefix isEqual:@"Timer"])
//    {
//        /*
//         if(!alertTemp)
//         alertTemp = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Time up!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
//         [alertTemp show];
//         */
//    }
//    else{
        if(!alertTimer)
        {
            //alertTimer = [[GNAlertView alloc]  initWithText:@"" Icon:@"" Delegate:self];
            alertTimer = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Temperature is too high!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        }
    
        [alertTimer show];
        [[DataCenter getInstance].CurrentDevice Alert];
//    }
    [[DataCenter getInstance].CurrentDevice gillNow2:YES andP:p]; // 机子报警
    
}
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(player)
    {
        [player stop];
        player = nil;
        [[DataCenter getInstance].CurrentDevice CannelAlert];
        [[DataCenter getInstance].CurrentDevice gillNow2:NO andP:5]; // 机子停止报警
    }
}
-(void)GNAlertViewHiden:(GNAlertView *)view
{
    //AudioServicesDisposeSystemSoundID(soundID);
    //[[DataCenter getInstance].CurrentDevice CannelAlert];
    if(player)
    {
        [player stop];
    }
    player = nil;
    //AudioServicesPlaySystemSound(0);
    soundID = 0;
    [[DataCenter getInstance].CurrentDevice gillNow2:NO andP:5]; // 机子停止报警
}


-(void)resetUI
{
    [self setLabel:_showTNumber Content:[DataCenter getInstance].CurrentTempTarget];
    _foodSetTNameLabel.text = [DataCenter getInstance].CurrentTempName;
    
    if (_isP1orP2 == 1) {
        [self setLabel:_P1SetT Content:[DataCenter getInstance].CurrentTempTarget];
        _P1setTName.text =[DataCenter getInstance].CurrentTempName;
        
    } else if (_isP1orP2 == 2)
    {
        [self setLabel:_P2SetT Content:[DataCenter getInstance].CurrentTempTarget];
        _P2SetTName.text = [DataCenter getInstance].CurrentTempName;
    }

}
-(void)viewWillAppear:(BOOL)animated
{
    
    [self resetUI];
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)refreshButtonChange {
    
    if([DataCenter getInstance].CurrentDevice){
        [DataCenter getInstance].CurrentDevice.ManualDisconnectd=YES;
        [[DataCenter getInstance].CurrentDevice Disconnct:[DataCenter getInstance].CurrentDevice.Peripheral];
        [[DataCenter getInstance].CurrentDevice  Stop];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)electricityButtonChange {
    
}
- (IBAction)P1TPChange {
    
    _isP1orP2 = 1; // p1的食物数据
    if (_P1FoodName.text.length) {
//        _foodNameImage.image = [UIImage imageNamed:_P1FoodName.text];
        [_foodNameButton setImage:[UIImage imageNamed:_P1FoodName.text] forState:0];
        _foodNameShow.text = _P1FoodName.text;
        _showTNumber.text = _P1SetT.text;
        _foodSetTNameLabel.text = _P1setTName.text;
    }
    
    _p1Image.hidden = NO;
    _p2Image.hidden = YES;
//    _p1FourLabel.hidden = NO;
    
    // foodVeiw出现
    if (_isFoodView == NO) {
//        _foodView.hidden = NO;
        _isFoodView = YES; // 判断食物View是否开启
        
        // 动画
        
        CGRect foodRect = _foodView.frame;
        foodRect.origin.y = 100;
        _foodView.frame = foodRect;
        _foodView.hidden = NO;
        [UIView animateWithDuration:0.5 animations:^{
            if (_p2T == 0) {
                CGRect foodViewRect = _foodView.frame;
                foodViewRect.origin.y = [UIScreen mainScreen].bounds.size.height/2;
                _foodView.frame = foodViewRect;
            } else {
            CGRect foodRect2 = _foodView.frame;
            foodRect2.origin.y = _foodViewY;
            _foodView.frame = foodRect2;
            }
        }];

        } else if(_isFoodView)
    {  // 消失
//       _foodView.hidden = YES;
        _isFoodView = NO;
        _foodView.hidden = YES;
        // 动画
        [UIView animateWithDuration:0.5 animations:^{
            CGRect foodRect2 = _foodView.frame;
            foodRect2.origin.y = 100;
            _foodView.frame = foodRect2;
            _foodView.hidden = YES;
        }];

    }
}

//- (IBAction)backButtonChange {
//    [self.navigationController popViewControllerAnimated:YES];
//}

- (IBAction)P2TPChange {
    
    _isP1orP2 = 2; // p2的食物数据
    if (_P2FoodName.text.length) {
//        _foodNameImage.image = [UIImage imageNamed:_P2FoodName.text];
        [_foodNameButton setImage:[UIImage imageNamed:_P2FoodName.text] forState:0];
        _foodNameShow.text = _P2FoodName.text;
        _showTNumber.text = _P2SetT.text;
        _foodSetTNameLabel.text = _P2SetTName.text;
        
    }
    
    _p2Image.hidden = NO; // 指向箭头
    _p1Image.hidden = YES;
//    _p2FourLabel.hidden = NO;
    if (_isFoodView == NO) { // foodVeiw出现
//        _foodView.hidden = NO;
        _isFoodView = YES;
        
        // 动画
        CGRect foodRect = _foodView.frame;
        foodRect.origin.y = 100;
        _foodView.frame = foodRect;
        _foodView.hidden = NO;
        [UIView animateWithDuration:0.5 animations:^{
            if (_p1T == 0) {
                CGRect foodViewRect2 = _foodView.frame;
                foodViewRect2.origin.y = [UIScreen mainScreen].bounds.size.height/2;
                _foodView.frame = foodViewRect2;
            } else {
            CGRect foodRect2 = _foodView.frame;
            foodRect2.origin.y = _foodViewY;
            _foodView.frame = foodRect2;
            }
        }];

    } else if(_isFoodView)
    {  // 消失
//        _foodView.hidden = YES;
        _isFoodView = NO;
         _foodView.hidden = YES;
        // 动画
        [UIView animateWithDuration:0.5 animations:^{
            CGRect foodRect2 = _foodView.frame;
            foodRect2.origin.y = 100;
            _foodView.frame = foodRect2;
            _foodView.hidden = YES;
        }];
    }

}

- (IBAction)foodName {
    
    FoodSelectViewController* ctl = [[FoodSelectViewController alloc] init];
    [self.navigationController pushViewController:ctl animated:YES];
}

- (IBAction)foodSetT {
    if (_isP1orP2 == 1) {
        list = [[FootTemperatureList alloc] initWithFood:[_P1FoodDictionary objectForKey:@"myFood"]];
        [self.view addSubview:list.view];
    } else if (_isP1orP2)
    {
        list = [[FootTemperatureList alloc] initWithFood:[_p2FoodDictionary objectForKey:@"myFood"]];
        [self.view addSubview:list.view];
    }
    
}
@end
