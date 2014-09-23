#import "BaseUIViewController.h"

static NSString *cellReuseIdentifier=@"Cell";

@interface BaseTableViewController : BaseUIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) UITableView *tableView;

@property (strong,nonatomic) NSMutableArray *dataItemArray;

@end
