#import "BaseViewController.h"
#ifndef TEST
#endif

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)init{
    self=[super init];
    if(self){
        [self.view setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

//- (UIStatusBarStyle)preferredStatusBarStyle{
//    return UIStatusBarStyleLightContent;
//    [[UINavigationBar appearance] setTintColor:[UIColor redColor]];
//}

- (void)viewDidLoad
{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
    [super viewDidLoad];
}

- (void)presentViewController:(UIViewController*)viewController
{
    UINavigationController *myViewControllerNav = [[UINavigationController alloc] initWithRootViewController:viewController];
    [[myViewControllerNav navigationBar]setBarTintColor:NAVBG];
    [[myViewControllerNav navigationBar]setBarStyle:UIBarStyleBlackTranslucent];
    [self presentViewController:myViewControllerNav animated:YES completion:nil];
}

- (void)goBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
}

- (void)requestFailed:(int)reqCode
{
    NSLog(@"网络请求失败");
}

@end
