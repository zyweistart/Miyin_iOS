#import <UIKit/UIKit.h>

@interface SubViewController : UIViewController

@property (nonatomic, strong) NSString *szSignal;

- (id)initWithFrame:(CGRect)frame andSignal:(NSString *)szSignal;

@end
