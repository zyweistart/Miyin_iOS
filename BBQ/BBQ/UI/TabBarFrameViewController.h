#import <UIKit/UIKit.h>
#import "EAIntroView.h"
#import "HttpRequest.h"

@interface TabBarFrameViewController : UITabBarController<UITabBarControllerDelegate,EAIntroDelegate,HttpViewDelegate>

@property (strong,nonatomic) HttpRequest *hRequest;

@end

