#import <UIKit/UIKit.h>
#import "HttpRequest.h"
#import "ResultDelegate.h"

//所有UI控制器的父对象
@interface BaseViewController : UIViewController<HttpViewDelegate>

@property (strong,nonatomic) HttpRequest *hRequest;

- (void)goBack:(id)sender;

@end
