#import <UIKit/UIKit.h>
#import "User.h"
#import "Common.h"
#import "HttpRequest.h"
#import "ResultDelegate.h"

//所有UI控制器的父对象
@interface BaseViewController : UIViewController<HttpViewDelegate,ResultDelegate>

@property (strong,nonatomic) NSDictionary *data;
@property (strong,nonatomic) HttpRequest *hRequest;
@property (strong,nonatomic) NSObject<ResultDelegate> *resultDelegate;

- (id)initWithData:(NSDictionary*)data;

- (void)goBack:(id)sender;
- (void)cTitle:(NSString*)title;

@end
