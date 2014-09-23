#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"

@interface BaseMJRefreshViewController : BaseTableViewController<HttpRequestDelegate> {
    //当前页
    int _currentPage;
}

@property BOOL isLoadCache;
@property (strong,nonatomic) NSString *cacheTagName;
@property (strong,nonatomic) HttpRequest *hRequest;

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;
- (void)autoRefresh;

@end