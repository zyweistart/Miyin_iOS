#import "AppDelegate.h"
#import "MainViewController.h"
#import "SliderViewController.h"
#import "MainAppViewController.h"
#import "QHMainGestureRecognizerViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //计算各屏幕XY大小
    AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if(ScreenHeight > 480){
        myDelegate.autoSizeScaleX = ScreenWidth/320;
        myDelegate.autoSizeScaleY = ScreenHeight/568;
    }else{
        myDelegate.autoSizeScaleX = 1.0;
        myDelegate.autoSizeScaleY = 1.0;
    }
    //状态栏
    [application setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance]setBarTintColor:NAVBG];
    [[UINavigationBar appearance]setBarStyle:UIBarStyleBlackTranslucent];
    UINavigationController *frameViewControllerNav=[[UINavigationController alloc]initWithRootViewController:[[MainViewController alloc] init]];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController=frameViewControllerNav;
    [self.window makeKeyAndVisible];
    
    
    
    
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    // Override point for customization after application launch.
//    self.window.backgroundColor = [UIColor whiteColor];
//    
//    QHMainGestureRecognizerViewController *mainViewController = [[QHMainGestureRecognizerViewController alloc] init];
//    
//    UINavigationController *frameViewControllerNav=[[UINavigationController alloc]initWithRootViewController:mainViewController];
//    
//    self.window.rootViewController = frameViewControllerNav;
//    mainViewController.moveType = moveTypeMove;
//    
//    [SliderViewController sharedSliderController].MainVC = [[MainAppViewController alloc] init];
//    [SliderViewController sharedSliderController].RightSContentOffset=260;
//    [SliderViewController sharedSliderController].RightSContentScale=0.68;
//    [SliderViewController sharedSliderController].RightSJudgeOffset=160;
//    [mainViewController addViewController2Main:[SliderViewController sharedSliderController]];
//    
//    [self.window makeKeyAndVisible];

    
    
    
    return YES;
}

@end