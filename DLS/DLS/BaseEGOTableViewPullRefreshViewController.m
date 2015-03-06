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
    if(!self.tableView.pullTableIsRefreshing) {
        self.tableView.pullTableIsRefreshing = YES;
        [self performSelector:@selector(refreshTable) withObject:nil afterDelay:3.0f];
    }
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [super viewDidUnload];
}

#pragma mark - PullTableViewDelegate

- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView
{
    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:3.0f];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView
{
    [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:3.0f];
}

#pragma mark - Refresh and load more methods

- (void) refreshTable
{
    /*
     *子类重写该方法完成下拉刷新的功能
     */
    self.tableView.pullLastRefreshDate = [NSDate date];
    self.tableView.pullTableIsRefreshing = NO;
}

- (void) loadMoreDataToTable
{
    /*
     *子类重写该方法完成更多刷新的功能
     */
    self.tableView.pullTableIsLoadingMore = NO;
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
    return 10;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"Row %i", indexPath.row];
    return cell;
}

@end
