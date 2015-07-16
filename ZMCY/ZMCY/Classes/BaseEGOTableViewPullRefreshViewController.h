#import "BaseViewController.h"
#import "PullTableView.h"

#define PAGESIZE 8

@interface BaseEGOTableViewPullRefreshViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate, PullTableViewDelegate>

@property BOOL isFirstRefresh;
@property NSInteger currentPage;
@property (strong,nonatomic) PullTableView *tableView;
@property (strong,nonatomic) NSMutableArray *dataItemArray;

- (void)refreshTable;
- (void)loadMoreDataToTable;
- (void)loadDone;
- (void)loadHttp;

- (PullTableView *)buildTableViewWithView:(UIView*)view;
- (PullTableView *)buildTableViewWithView:(UIView*)view style:(UITableViewStyle)style;

@end
