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

- (id)initWithParams:(NSDictionary*)data{
    self=[self init];
    if(self){
        self.paramData=[NSMutableDictionary  dictionaryWithDictionary:data];
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

- (void)presentViewController:(BaseViewController*)viewController
{
    [viewController setResultDelegate:self];
    [self presentViewController:viewController animated:YES completion:nil];
}

- (void)presentViewControllerNav:(BaseViewController*)viewController
{
    [viewController setResultDelegate:self];
    UINavigationController *viewControllerNav = [[UINavigationController alloc] initWithRootViewController:viewController];
//    [[viewControllerNav navigationBar]setBarTintColor:NAVBG];
    [[viewControllerNav navigationBar]setBarStyle:UIBarStyleBlackTranslucent];
    [self presentViewController:viewControllerNav animated:YES completion:nil];
}

- (void)goBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onControllerResult:(NSInteger)resultCode data:(NSMutableDictionary*)result
{
    
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
}

- (void)requestFailed:(int)reqCode
{
    NSLog(@"网络请求失败");
}

@end
