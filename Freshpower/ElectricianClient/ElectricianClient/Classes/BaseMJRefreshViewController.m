#import "BaseMJRefreshViewController.h"
#import "MJRefresh.h"

@interface BaseMJRefreshViewController ()

@end

@implementation BaseMJRefreshViewController {
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
    int totalCount;
}

- (id)init {
    self=[super init];
    if(self){
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 集成刷新控件
    // 下拉刷新
    [self addHeader];
    // 上拉加载更多
    [self addFooter];
    if(self.isLoadCache){
        NSString *responseString=[Common getCache:self.cacheTagName!=nil?self.cacheTagName:CACHE_DATA];
        if(responseString!=nil) {
            NSDictionary *resultJSON=[NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
            
            for(NSString *key in resultJSON){
                if(![@"Rows" isEqualToString:key]){
                    self.dataItemArray=[[NSMutableArray alloc]initWithArray:[resultJSON objectForKey:key]];
                    [self.tableView reloadData];
                    return;
                }
            }
        }
        [self autoRefresh];
    }
}

- (void)addHeader
{
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.tableView;
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        // 进入刷新状态就会回调这个Block
        _currentPage=1;
        
//        NSLog(@"%@----开始进入刷新状态", refreshView.class);
        
        [self reloadTableViewDataSource];
        
    };
    header.endStateChangeBlock = ^(MJRefreshBaseView *refreshView) {
        // 刷新完毕就会回调这个Block
//        NSLog(@"%@----刷新完毕", refreshView.class);
    };
    header.refreshStateChangeBlock = ^(MJRefreshBaseView *refreshView, MJRefreshState state) {
        // 控件的刷新状态切换了就会调用这个block
        switch (state) {
            case MJRefreshStateNormal:
//                NSLog(@"%@----切换到：普通状态", refreshView.class);
                break;
                
            case MJRefreshStatePulling:
//                NSLog(@"%@----切换到：松开即可刷新的状态", refreshView.class);
                break;
                
            case MJRefreshStateRefreshing:
//                NSLog(@"%@----切换到：正在刷新状态", refreshView.class);
                break;
            default:
                break;
        }
    };
//    [header beginRefreshing];
//    [self autoRefresh];
    _header = header;
}

- (void)addFooter
{
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.tableView;
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        long count=[self.dataItemArray count];
        if(totalCount>0){
            if(count>=totalCount){
                [Common alert:@"已没有最新数据"];
                [self doneLoadingTableViewData];
                return;
            }
        }
        _currentPage=(int)count/PAGESIZE;
        if(count%PAGESIZE>=0){
            _currentPage++;
        }
        [self reloadTableViewDataSource];
    };
    _footer = footer;
}

//为了保证内部不泄露，在dealloc中释放占用的内存
- (void)dealloc
{
//    NSLog(@"MJTableViewController--dealloc---");
    [_header free];
    [_footer free];
}

- (void)reloadTableViewDataSource {
    
}

- (void)requestFinishedByResponse:(Response*)response responseCode:(int)repCode{
    if(self.dataItemArray==nil){
        self.dataItemArray=[[NSMutableArray alloc]init];
    }
    NSDictionary *data=[response resultJSON];
    if(data!=nil){
        NSDictionary *rows=[data objectForKey:@"Rows"];
        int result=[[rows objectForKey:@"result"] intValue];
        if(result==1){
            totalCount=[[rows objectForKey:@"TotalCount"]intValue];
            
            if(totalCount==0){
                [[self dataItemArray]removeAllObjects];
                [self.tableView reloadData];
            }else{
                for(NSString *key in data){
                    if(![@"Rows" isEqualToString:key]){
                        NSArray *tmpData=[data objectForKey:key];
                        if(_currentPage==1){
                            self.dataItemArray=[[NSMutableArray alloc]initWithArray:tmpData];
                        } else {
                            [self.dataItemArray addObjectsFromArray:tmpData];
                        }
                        if([tmpData count]>0){
                            // 刷新表格
                            [self.tableView reloadData];
                        }
                        break;
                    }
                }
            }
        } else {
            [Common alert:[rows objectForKey:@"remark"]];
            if(_currentPage==1){
                [[self dataItemArray]removeAllObjects];
                [self.tableView reloadData];
            }
        }
        if(_currentPage==1){
            if(self.isLoadCache){
                [Common setCache:self.cacheTagName!=nil?self.cacheTagName:CACHE_DATA data:[response responseString]];
            }
        }
    }else{
        [Common alert:@"数据解析异常"];
    }
    [self doneLoadingTableViewData];
}

- (void)requestFailed:(int)repCode didFailWithError:(NSError *)error
{
    if(error!=nil){
        [Common alert:@"网络连接异常"];
    }
    [self doneLoadingTableViewData];
}

- (void)doneLoadingTableViewData {
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [_header endRefreshing];
    [_footer endRefreshing];
}

- (void)autoRefresh {
    [self performSelector:@selector(refresh) withObject:nil afterDelay:0.5];
}

- (void)refresh {
    [_header beginRefreshing];
}

@end
