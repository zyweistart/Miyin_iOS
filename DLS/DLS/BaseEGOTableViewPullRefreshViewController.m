#import "BaseEGOTableViewPullRefreshViewController.h"

@implementation BaseEGOTableViewPullRefreshViewController

#pragma mark - View lifecycle
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    [self buildTableViewWithView:self.view];
//}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    if(!self.tableView.pullTableIsRefreshing) {
//        self.tableView.pullTableIsRefreshing = YES;
//        [self performSelector:@selector(refreshTable) withObject:nil afterDelay:3.0f];
//    }
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [super viewDidUnload];
}

#pragma mark - PullTableViewDelegate

- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView
{
//    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:3.0f];
    [self refreshTable];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView
{
//    [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:3.0f];
    [self loadMoreDataToTable];
}

#pragma mark - Refresh and load more methods

- (void)refreshTable
{
    /*
     *子类重写该方法完成下拉刷新的功能
     */
    self.currentPage=1;
    [self loadHttp];
}

- (void)loadMoreDataToTable
{
    /*
     *子类重写该方法完成更多刷新的功能
     */
    self.currentPage++;
    [self loadHttp];
}

- (void)loadHttp
{
    
}
//调用该方法完成刷新状态
- (void)loadDone
{
    if(self.tableView.pullTableIsRefreshing){
        self.tableView.pullLastRefreshDate = [NSDate date];
        self.tableView.pullTableIsRefreshing = NO;
    }else if(self.tableView.pullTableIsLoadingMore){
        self.tableView.pullTableIsLoadingMore = NO;
    }
    [self.tableView reloadData];
}

//创建PullTableView
- (PullTableView *)buildTableViewWithView:(UIView*)view;
{
    if(self.tableView==nil){
        self.tableView=[[PullTableView alloc]initWithFrame:view.bounds];
        [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
        [self.tableView setPullDelegate:self];
        [view addSubview:self.tableView];
    }
    return self.tableView;
}

#pragma mark - UITableViewDataSource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataItemArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"Row %d", indexPath.row];
    return cell;
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if([response successFlag]){
        NSDictionary *rData=[[response resultJSON] objectForKey:@"Data"];
        if(rData){
            //当前页
            self.currentPage=[[NSString stringWithFormat:@"%@",[rData objectForKey:@"PageIndex"]] intValue];
            //获取数据列表
            NSDictionary *tabData=[rData objectForKey:@"Tab"];
            if(tabData){
                NSMutableArray *nsArr=[[NSMutableArray alloc]init];
                for(id data in tabData){
                    [nsArr addObject:data];
                }
                if(self.currentPage==1){
                    if(!self.dataItemArray){
                        self.dataItemArray=[[NSMutableArray alloc]init];
                    }else{
                        [self.dataItemArray removeAllObjects];
                    }
                }
                [self.dataItemArray addObjectsFromArray:nsArr];
            }
        }
    }
    [self loadDone];
}

- (void)requestFailed:(int)reqCode
{
    [self loadDone];
}

@end
