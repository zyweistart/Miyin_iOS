#import "AppDelegate.h"
#import "MainAppViewController.h"

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
    UINavigationController *frameViewControllerNav=[[UINavigationController alloc]initWithRootViewController:[[MainAppViewController alloc] init]];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController=frameViewControllerNav;
    [self.window makeKeyAndVisible];
    return YES;
}

@end