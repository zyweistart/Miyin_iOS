#import "BaseTableViewController.h"
#import "EGORefreshTableHeaderView.h"

#define PAGESIZE 8

@interface BaseRefreshTableViewController:BaseTableViewController<EGORefreshTableHeaderDelegate,ResultDelegate,HttpViewDelegate>{
    //当前页数
    int _currentPage;
    //是否处于加载中
	BOOL _reloading;
    //是否加载完毕
    BOOL _loadOver;
    EGORefreshTableHeaderView *_refreshHeaderView;
}

- (void)autoRefresh;
- (void)doneManualRefresh;
- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

@end