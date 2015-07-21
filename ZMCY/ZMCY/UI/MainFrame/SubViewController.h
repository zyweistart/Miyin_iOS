#import <UIKit/UIKit.h>
#import "QHMainGestureRecognizerViewController.h"

@interface SubViewController : UIViewController

@property (nonatomic, strong) NSString *szSignal;

- (id)initWithFrame:(CGRect)frame andSignal:(NSString *)szSignal;

@end
