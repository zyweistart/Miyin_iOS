#import <UIKit/UIKit.h>
#import "User.h"
#import "Common.h"
#import "HttpRequest.h"
#import "HttpDownload.h"
#import "ResultDelegate.h"

//所有UI控制器的父对象
@interface BaseViewController : UIViewController<HttpViewDelegate,ResultDelegate,HttpDownloadDelegate>{
    
}

@property (strong,nonatomic) NSDictionary *data;
@property (strong,nonatomic) HttpRequest *hRequest;
@property (strong,nonatomic) HttpDownload *hDownload;
@property (strong,nonatomic) AppDelegate *appDelegate;
@property (strong,nonatomic) UIView *mConnectedPanel;
@property (strong,nonatomic) UILabel *lblMessage;

@property (strong,nonatomic) NSObject<ResultDelegate> *resultDelegate;

- (id)initWithData:(NSDictionary*)data;

- (void)goBack:(id)sender;
- (void)cTitle:(NSString*)title;

@end
