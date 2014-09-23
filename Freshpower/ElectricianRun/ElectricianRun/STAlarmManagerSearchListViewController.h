#import <UIKit/UIKit.h>
#import "BaseMJRefreshViewController.h"
#import "RMPickerViewController.h"

@interface STAlarmManagerSearchListViewController : BaseMJRefreshViewController<RMPickerViewControllerDelegate>


-(id)initWithData:(NSDictionary*)data;

@end
