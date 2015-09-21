//
//  TimerViewController.h
//  Graff Now
//
//  Created by Yang Shubo on 13-8-27.
//  Copyright (c) 2013年 Yang Shubo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircularProgressView.h"
#import "AudioToolbox/AudioToolbox.h"
#import "AlarmRing.h"
#import "VCTimerCell.h"
#import "VCTimerIntroduce.h"
#import "GNAlertView.h"

@interface TimerViewController : UIViewController<CircularProgressDelegate,UIAlertViewDelegate,UITextFieldDelegate,GNAlertViewDelegate>
{
    IBOutlet UIScrollView *svTimer;
     
    CircularProgressView* circule;
    float timerSecond;
    IBOutlet UIButton *btnStart;
    
    IBOutlet UITextField *tbDuringMin;
    IBOutlet UITextField *tbDuring;
    SystemSoundID soundID;
    
    UITextField* popInputOwn;
    AVAudioPlayer* player;
    IBOutlet UIImageView *imgRing;
    
    
    NSMutableArray * timerArray;
    
    VCTimerCell* currentTimer;
    IBOutlet UIButton *btnAddTimer;
    
    VCTimerIntroduce * intro ;
    
    NSUserDefaults *_TimeUs;
    NSString *_timePlistPath;
}

- (IBAction)onAddTimer:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *imgSurface;
- (IBAction)OnBtnStart:(id)sender;
- (IBAction)OnBtnReset:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lbSecond;
@property (strong, nonatomic) IBOutlet UILabel *lbHour;
- (IBAction)btnCancelInput:(id)sender;

-(void)PlaySound:(AlarmRing*)ring;
-(void)updateTime:(double)time;
@end
