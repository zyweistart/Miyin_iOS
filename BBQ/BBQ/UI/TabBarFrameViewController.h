#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "InfoViewController.h"
#import "SettingViewController.h"
#import "TimerViewController.h"
#import "AlertView.h"

@interface TabBarFrameViewController : UITabBarController<UITabBarControllerDelegate>

@property (strong,nonatomic) HomeViewController *mHomeViewController;
@property (strong,nonatomic) InfoViewController *mInfoViewController;
@property (strong,nonatomic) SettingViewController *mSettingViewController;
@property (strong,nonatomic) TimerViewController *mTimerViewController;

@property (strong,nonatomic)UIView *bgFrame;
@property (strong,nonatomic)AlertView *mAlertView;

@end