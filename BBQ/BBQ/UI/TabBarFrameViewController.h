#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "HomeViewController.h"
#import "InfoViewController.h"
#import "SettingViewController.h"
#import "TimerViewController.h"
#import "AlertView.h"

@interface TabBarFrameViewController : UITabBarController<UITabBarControllerDelegate,AVAudioPlayerDelegate>

@property (strong,nonatomic) HomeViewController *mHomeViewController;
@property (strong,nonatomic) InfoViewController *mInfoViewController;
@property (strong,nonatomic) SettingViewController *mSettingViewController;
@property (strong,nonatomic) TimerViewController *mTimerViewController;

@property (strong,nonatomic) AppDelegate *appDelegate;
@property (strong,nonatomic) UIView *bgFrame;
@property (strong,nonatomic) AlertView *mAlertView;
@property (strong,nonatomic) AVAudioPlayer *mAVAudioPlayer;

- (void)playAlarm;
- (void)AlertShow;

@end