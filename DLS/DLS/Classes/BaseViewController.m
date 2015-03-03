#import "BaseViewController.h"
#ifndef TEST
#endif

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)init{
    self=[super init];
    if(self){
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

@end
