#import "BaseViewController.h"

@interface BaseTableViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *dataItemArray;

- (UITableView *)buildTableViewWithView:(UIView*)view;

@end
