#import <UIKit/UIKit.h>
#import "HttpRequest.h"
#import "ResultDelegate.h"

//所有UI控制器的父对象
@interface BaseViewController : UIViewController<HttpViewDelegate,ResultDelegate>

@property (strong,nonatomic) HttpRequest *hRequest;
@property (assign) NSObject<ResultDelegate> *resultDelegate;

- (void)goBack:(id)sender;
- (void)presentViewController:(BaseViewController*)viewController;
- (void)presentViewControllerNav:(UIViewController*)viewController;

@end
