#import "BaseEGOTableViewPullRefreshViewController.h"
#import "UIButton+TitleImage.h"

@implementation BaseEGOTableViewPullRefreshViewController

- (id)init{
    self=[super init];
    if(self){
        self.dataItemArray=[[NSMutableArray alloc]init];
//        [self.dataItemArray addObject:@"a1"];
//        [self.dataItemArray addObject:@"a2"];
//        [self.dataItemArray addObject:@"a3"];
//        [self.dataItemArray addObject:@"a4"];
        self.currentPage=0;
    }
    return self;
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self buildTableViewWithView:self.view];
}

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
    [self.tableView reloadData];
    if(self.tableView.pullTableIsRefreshing){
        self.tableView.pullLastRefreshDate = [NSDate date];
        self.tableView.pullTableIsRefreshing = NO;
    }else if(self.tableView.pullTableIsLoadingMore){
        self.tableView.pullTableIsLoadingMore = NO;
    }
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
    if([[self dataItemArray] count]>0){
        return [[self dataItemArray] count];
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[self dataItemArray] count]>0){
        return CGHeight(45);
    }else{
        return self.tableView.bounds.size.height;
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[self dataItemArray] count]>0){
        static NSString *cellIdentifier = @"SAMPLECell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"Row %ld", indexPath.row];
        return cell;
    }else{
        static NSString *CNOCell = @"NOCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CNOCell];
        if(!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CNOCell];
        }
        UIButton *noData=[[UIButton alloc]initWithFrame:CGRectMake1(110, self.tableView.bounds.size.height/2-40, 100, 80)];
        [noData.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [noData setTitle:@"暂无数据" forImage:[UIImage imageNamed:@"nocollection"]];
        [noData setTitleColor:[UIColor colorWithRed:(140/255.0) green:(140/255.0) blue:(140/255.0) alpha:1] forState:UIControlStateNormal];
        [cell addSubview:noData];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if([response successFlag]){
        NSDictionary *rData=[[response resultJSON] objectForKey:@"Results"];
        if(rData){
            //当前页
            self.currentPage=[[NSString stringWithFormat:@"%@",[rData objectForKey:@"PageIndex"]] intValue];
        }
        NSArray *tData=[[response resultJSON] objectForKey:@"table1"];
        if(tData){
            if([self currentPage]==1){
                [[self dataItemArray] removeAllObjects];
            }
            [[self dataItemArray] addObjectsFromArray:tData];
        }
    }
    [self loadDone];
}

- (void)requestFailed:(int)reqCode
{
    [self loadDone];
}

@end
