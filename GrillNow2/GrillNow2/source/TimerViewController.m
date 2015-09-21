//
//  TimerViewController.m
//  Graff Now
//
//  Created by Yang Shubo on 13-8-27.
//  Copyright (c) 2013年 Yang Shubo. All rights reserved.
//

#import "TimerViewController.h"
#import "CircularProgressView.h"
#import "Marcro.h"
#import "AlarmRing.h"
#import "DataCenter.h"

@interface TimerViewController ()

@end

@implementation TimerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dealloc
{
    
}

-(void)viewWillAppear:(BOOL)animated
{
    if(intro==nil)
    {
        intro = [[VCTimerIntroduce alloc] initWithView:@[btnAddTimer,self.view,btnStart] Images:@[@"hand_cursor.png",@"hand_circle.png",@"hand_cursor.png"]];
        if(intro!=nil)
        {
            [self.view addSubview:intro.view];
        }
    }
    //circule.maxDuring = [DataCenter getInstance].CurrentFood.CookTime;
    [super viewWillAppear:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //set backcolor & progresscolor
    
    // 存储设定的时间数据
    _TimeUs = [NSUserDefaults standardUserDefaults];
    
    timerArray = [[NSMutableArray alloc] init];
    
    UIColor *progressColor  = RGBMAKE(0xFA,0xA6,0x6,0xFF);//[UIColor colorWithRed:236.0/255.0 green:236.0/255.0 blue:236.0/255.0 alpha:1.0];
    UIColor *backColor = RGBMAKE(0xF9,0x7F,0x12,0xFF);
    
    //alloc CircularProgressView instance
    CGRect frame =CGRectMake(0, 90, 321, 321);
    // 转盘（三方库）
    circule = [[CircularProgressView alloc] initWithFrame:frame backColor:backColor progressColor:progressColor lineWidth:35];
    circule.delegate = self;
    [self.view insertSubview:circule belowSubview:btnAddTimer];
    //[self.view addSubview:circule];
    tbDuring.delegate = self;
    tbDuringMin.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onMsgSelTimer:) name:MSG_ON_SEL_TIMER object:nil];
  
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onMsgTimeTick:) name:MSG_TIMER_TICK object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onMsgTimeFinish:) name:MSG_TIMER_FINISH object:nil];
    
    [self reloadTimers];
    
//    Timer * t = [[Timer alloc] init];
//    t.during =  1; // 初始设定时间
    
    if ([[_TimeUs objectForKey:@"cellNum"] intValue]>0) {
        for (int r = 1; r<=[[_TimeUs objectForKey:@"cellNum"] intValue]; r++) {
            Timer * t = [[Timer alloc] init];
            t.during =  1; // 初始设定时间
            
        VCTimerCell* cell = [[VCTimerCell alloc ] initWithTimer:t Index:[NSString stringWithFormat:@"%d",r]];
        [timerArray addObject:cell]; // 添加定时器
        currentTimer = cell;
        [self reloadTimers];
        [self setTimerProperty:t];
        }
    } else {
        Timer * t = [[Timer alloc] init];
        t.during =  1; // 初始设定时间
        
    VCTimerCell* cell = [[VCTimerCell alloc ] initWithTimer:t Index:[NSString stringWithFormat:@"%lu",(unsigned long)timerArray.count+1]];
    [timerArray addObject:cell]; // 添加定时器
    currentTimer = cell;
    [self reloadTimers];
    [self setTimerProperty:t];
    }
    // Do any additional setup after loading the view from its nib.

}

// 本地通知
- (void)ffnotification:(NSString *)name
{
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.fireDate=[NSDate dateWithTimeIntervalSinceNow:0];
        notification.timeZone=[NSTimeZone defaultTimeZone];
        notification.alertBody=[NSString stringWithFormat:@"time%@ has been completed",name];
        notification.category = @"alert";
    notification.repeatInterval = 0;// 0为不重复发送通知
    notification.soundName= UILocalNotificationDefaultSoundName; // 提示声音为默认的
        [[UIApplication sharedApplication]  scheduleLocalNotification:notification];
    
}
-(void)onMsgTimeFinish:(NSNotification*)noti
{ // 时间器到达设定时间
    Timer* t = (Timer*)noti.object;
    [t stop];
    [self ffnotification:t.Name];// 添加本地通知
    [self AlertTimerFinish:[NSString stringWithFormat:@"Timer %@ Finished",t.Name]];
}
-(void)AlertTimerFinish:(NSString*)text
{
    UIAlertView* av = [[UIAlertView alloc] initWithTitle:@"Warning" message:text delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [av show];
    
    //GNAlertView *gav = [[GNAlertView alloc] initWithText:@"" Icon:@"icon114.png" Delegate:self];
    //[gav show];
    
    [self PlaySound: [DataCenter getInstance].TimerAlarm];
}
// 运行时间
-(void)onMsgTimeTick:(NSNotification*)noti
{
    Timer* t = (Timer*)noti.object;
    if([t isEqual:currentTimer.timer])
    {
        NSLog(@"%d",t.currentDuring);
        [circule changeCurrentDuring:t.currentDuring];
        [self updateTime:t.currentDuring];
    }
}
// 点击cell的事件
-(void)onMsgSelTimer:(NSNotification*)noti
{
    VCTimerCell * cell =(VCTimerCell*) noti.object;
    NSLog(@"name---  %@",cell.timerName);
    cell.timer.Name = cell.timerName;
    currentTimer = cell;
    [self reloadTimers];
    [self setTimerProperty:cell.timer];
    
    if (player.playing==NO) {
        [self updateTime:currentTimer.timer.during];
    }

}
// 设定的时间
-(void)setTimerProperty:(Timer*)obj
{
    if ([_TimeUs objectForKey:obj.Name]) {
        [circule changeMaxDuring:[[_TimeUs objectForKey:obj.Name] intValue]];
    } else {
    //[self updateTime:obj.during];
    [circule changeMaxDuring:obj.during];
    }
    [circule changeCurrentDuring:obj.currentDuring];
    circule.CanChange = !obj.isEnable;
    [self updateTime:obj.currentDuring];
    [self setButton];
}
-(void)reloadTimers
{
    for(UIView *View in svTimer.subviews){
        [View removeFromSuperview];
    }
    
    int width = 0;
    for (int i=0; i<timerArray.count; i++)
    {
        VCTimerCell * cell =(VCTimerCell*) [timerArray objectAtIndex:i];
        [cell selected:NO];
    }
    for (int i=0; i<timerArray.count; i++)
    {
       
        VCTimerCell * cell =(VCTimerCell*) [timerArray objectAtIndex:i];
        CGRect rect = cell.view.frame;
        rect.origin.x = width;
        cell.view.frame = rect;
        width = width + rect.size.width;
        //NSLog(@"width:%d",width);
        cell.timerName = [NSString stringWithFormat:@"%d",(i+1)];
        [svTimer addSubview:cell.view];
        if([cell isEqual:currentTimer])
            [cell selected:YES];
        else
            [cell selected:NO];
    }
    svTimer.contentSize = CGSizeMake(width, 0);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
-(void)updateTime:(double)time
{
    timerSecond = time ;
    int s = (int)timerSecond;
    s = s % 60;
    int m = (int)timerSecond;
    m = m / 60;
    m = m % 60;
    int h = (int)timerSecond;
    h = h / 3600;
    
    circule.currentDuring = time;
    
    self.lbSecond.text = [NSString stringWithFormat:@"%02d",s];
    self.lbHour.text = [NSString stringWithFormat:@"%02d:%02d",h,m];
}

#pragma mark - 转盘Delegate
- (void)didUpdateProgressView
{
    [self updateTime:circule.currentDuring];
}
- (void)didFinishProgressView
{
    if([DataCenter getInstance].TimerAlarm){
        [self PlaySound:[DataCenter getInstance].TimerAlarm];
        //[self PlaySound:[DataCenter getInstance].TimerAlarm];
    }
}
-(void)didChangeTime:(double)time
{
    [self updateTime:time];
}


-(void)GNAlertViewHiden:(GNAlertView *)view
{
    [[DataCenter getInstance].CurrentDevice CannelAlert]; // 机子停止报警
    if(player)
    {
        [player stop];
        //btnStart.backgroundColor = RGBMAKE(0x77, 0x6b, 0x5f, 0xFF);
        [btnStart setTitle:@"Start" forState:UIControlStateNormal];
        [circule stop];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [[DataCenter getInstance].CurrentDevice CannelAlert]; // 机子停止报警
    if(player)
    {
        [player stop];
        //btnStart.backgroundColor = RGBMAKE(0x77, 0x6b, 0x5f, 0xFF);
        [btnStart setTitle:@"Start" forState:UIControlStateNormal];
        [circule stop];
    }
    //player = nil;
    if (!player.playing) {
        [self updateTime:currentTimer.timer.during];
    }
}

- (IBAction)btnCancelInput:(id)sender {
    
    if(popInputOwn)
    {
        [popInputOwn resignFirstResponder];
        
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
        self.view.frame = rect;
        [UIView commitAnimations];
    }
}

-(void)PlaySound:(AlarmRing*)ring
{
    
    NSString *soundFilePath =
    [[NSBundle mainBundle] pathForResource: ring.RingFilePath
                                    ofType: @"wav"];
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
    AVAudioPlayer *newPlayer =
    [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL
                                           error: nil];
    //[fileURL release];
    player = newPlayer;
    //[newPlayer release];
    [player prepareToPlay];
    
    //[player setDelegate: self];
    player.numberOfLoops = -1;    // Loop playback until invoke stop method
    [player play];
    
    [[DataCenter getInstance].CurrentDevice Alert]; // 机子报警，写数据
    
    /*
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Time up!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
     */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setButton
{
    if(currentTimer==nil)
    {
        [btnStart setTitle:@"Start" forState:UIControlStateNormal];
        return;
    }
    if(currentTimer.timer.isEnable)
    {
        [btnStart setTitle:@"Stop" forState:UIControlStateNormal];
    }
    else
    {
        [btnStart setTitle:@"Start" forState:UIControlStateNormal];
    }
    
}
- (IBAction)OnBtnStart:(id)sender {
    
    if(currentTimer==nil)
        return;
    
    //currentTimer.timer.during;
    if(currentTimer.timer.isEnable) // 已经启用
    {
        //currentTimer.timer.isEnable = NO;
        [currentTimer.timer pause];
    }
    else
    {
        currentTimer.timer.during = circule.maxDuring; // 定时器的设定时间
        [currentTimer.timer start];
    // 保存设定的时间数据
        [_TimeUs setObject:[NSString stringWithFormat:@"%d",currentTimer.timer.during] forKey:currentTimer.timer.Name];
        [_TimeUs synchronize];
    }
    circule.CanChange = !currentTimer.timer.isEnable;
    [self setButton];
}

- (IBAction)OnBtnReset:(id)sender {
    if(currentTimer==nil)
        return;

    currentTimer.timer.currentDuring = 0;
    
}


// 删除定时器
- (IBAction)onDeleteTimer:(id)sender {
    
    // 删除保存的时间值
    [_TimeUs removeObjectForKey:currentTimer.timer.Name];
    [_TimeUs synchronize];
   
    if(currentTimer==nil)
        return;
    [currentTimer.timer dispose];
    [timerArray removeObject:currentTimer];
    currentTimer.timer  = nil;
    currentTimer = nil;
    
    [_TimeUs setObject:[NSString stringWithFormat:@"%lu",(unsigned long)timerArray.count] forKey:@"cellNum"];
    [_TimeUs synchronize];
    
    [self reloadTimers];
    [self setButton];
    
    
}
// 添加定时器
- (IBAction)onAddTimer:(id)sender {
    Timer * t = [[Timer alloc] init];
    t.during =  1;
    VCTimerCell* cell = [[VCTimerCell alloc ] initWithTimer:t Index:[NSString stringWithFormat:@"%lu",(unsigned long)timerArray.count+1]];
    [timerArray addObject:cell];
    currentTimer = cell;
    [self reloadTimers];
    [self setTimerProperty:t];
    // 保存定时器的个数
    [_TimeUs setObject:currentTimer.timer.Name forKey:@"cellNum"];
    [_TimeUs synchronize];

    }
@end
