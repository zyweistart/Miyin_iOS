//
//  BaseMJRefreshViewController.m
//  ElectricianRun
//
//  Created by Start on 2/20/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "BaseMJRefreshViewController.h"

@interface BaseMJRefreshViewController ()

@end

@implementation BaseMJRefreshViewController

- (id)init {
    self=[super init];
    if(self){
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _isPage=YES;
    _currentPage=0;
    // 集成刷新控件
    // 下拉刷新
    [self addHeader];
    // 上拉加载更多
    [self addFooter];
    if(self.isLoadCache){
        NSString *responseString=[Common getCache:self.cachetag!=nil?self.cachetag:CACHE_DATA];
        if(responseString!=nil) {
            NSDictionary *resultJSON=[NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
            NSArray *tmpData=[resultJSON objectForKey:@"table1"];
            if([tmpData count]>0){
                self.dataItemArray=[[NSMutableArray alloc]initWithArray:tmpData];
                [self.tableView reloadData];
                return;
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
        _currentPage=(int)count/PAGESIZE;
        if(count%PAGESIZE>=0){
            _currentPage++;
        }
        if(_pageCount>0){
            if(_totalCount==count){
                _currentPage--;
                [Common alert:@"亲，没有最新数据，请下拉刷新试试!"];
                [self doneLoadingTableViewData];
                return;
            }
        }
        
        [self reloadTableViewDataSource];
        
    };
    _footer = footer;
}

/**
 为了保证内部不泄露，在dealloc中释放占用的内存
 */
- (void)dealloc
{
    //    NSLog(@"MJTableViewController--dealloc---");
    [_header free];
    [_footer free];
}

- (void)reloadTableViewDataSource {
    
}

- (void)requestFinishedByResponse:(Response*)response responseCode:(int)repCode{
    NSDictionary *data=[response resultJSON];
    if(data!=nil){
        NSDictionary *pageinfo=[data objectForKey:@"Rows"];
        
        int result=[[pageinfo objectForKey:@"result"] intValue];
        if(result>0){
            _pageCount=[[pageinfo objectForKey:@"PageCount"] intValue];
            _totalCount=[[pageinfo objectForKey:@"TotalCount"] intValue];
            if(_pageCount<_currentPage&&self.isPage) {
                if(_pageCount==0){
                    [self.dataItemArray removeAllObjects];
                    _currentPage=1;
                }else{
                    _currentPage=_pageCount;
                }
            } else {
                NSArray *tmpData=[data objectForKey:@"table1"];
                if(_currentPage==1){
                    self.dataItemArray=[[NSMutableArray alloc]initWithArray:tmpData];
                } else {
                    if(self.dataItemArray==nil){
                        self.dataItemArray=[[NSMutableArray alloc]init];
                    }
                    [self.dataItemArray addObjectsFromArray:tmpData];
                }
            }
            if(self.isLoadCache){
                if(_currentPage==1){
                    if(self.isLoadCache){
                        [Common setCache:self.cachetag!=nil?self.cachetag:CACHE_DATA data:[response responseString]];
                    }
                }
            }
            // 刷新表格
            [self.tableView reloadData];
        } else {
            NSString *remark=[pageinfo objectForKey:@"remark"];
            [Common alert:remark];
            [[self dataItemArray]removeAllObjects];
            [self.tableView reloadData];
            if(self.isLoadCache){
                [Common setCache:self.cachetag!=nil?self.cachetag:CACHE_DATA data:@""];
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
//        [Common alert:[error description]];
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
    [self.header beginRefreshing];
}

@end
