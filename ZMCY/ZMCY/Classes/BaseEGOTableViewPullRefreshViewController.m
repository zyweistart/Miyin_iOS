#import "BaseEGOTableViewPullRefreshViewController.h"
#import "UIButton+TitleImage.h"

@implementation BaseEGOTableViewPullRefreshViewController

- (id)init{
    self=[super init];
    if(self){
        self.currentPage=0;
        self.isFirstRefresh=YES;
        self.dataItemArray=[[NSMutableArray alloc]init];
//        [self.dataItemArray addObject:@"a1"];
//        [self.dataItemArray addObject:@"a2"];
//        [self.dataItemArray addObject:@"a3"];
//        [self.dataItemArray addObject:@"a4"];
        [self buildTableViewWithView:self.view];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(self.isFirstRefresh){
        self.isFirstRefresh=NO;
        if(!self.tableView.pullTableIsRefreshing) {
            self.tableView.pullTableIsRefreshing=YES;
            [self performSelector:@selector(refreshTable) withObject:nil afterDelay:1.0f];
        }
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
    [self refreshTable];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView
{
    [self loadMoreDataToTable];
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
        return self.tableView.bounds.size.height-self.tableView.tableHeaderView.frame.size.height;
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
        cell.textLabel.text = @"数据项";
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        return cell;
    }else{
        static NSString *CNOCell = @"NOCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CNOCell];
        if(!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CNOCell];
        }
        CGFloat height=[self tableView:tableView heightForRowAtIndexPath:indexPath];
        UIButton *noData=[[UIButton alloc]initWithFrame:CGRectMake(CGWidth(110), height/2-CGHeight(40), CGWidth(100), CGHeight(80))];
        [noData.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [noData setTitle:@"暂无数据" forImage:[UIImage imageNamed:@"暂无数据"]];
        [noData setTitleColor:DEFAUL1COLOR forState:UIControlStateNormal];
        [cell addSubview:noData];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

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
    //注:子类必须重写该方法完成网络请求
    [self performSelector:@selector(loadDone) withObject:nil afterDelay:3.0f];
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
                if([self currentPage]==1){
                    [[self dataItemArray] removeAllObjects];
                }
                [[self dataItemArray] addObjectsFromArray:nsArr];
            }
        }
    }
    [self loadDone];
}

- (void)requestFailed:(int)reqCode
{
    [self loadDone];
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
    return [self buildTableViewWithView:view style:UITableViewStylePlain];
}

- (PullTableView *)buildTableViewWithView:(UIView*)view style:(UITableViewStyle)style
{
    if(self.tableView==nil){
        self.tableView=[[PullTableView alloc]initWithFrame:view.bounds style:style];
        [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
        [self.tableView setPullDelegate:self];
        [view addSubview:self.tableView];
    }
    return self.tableView;
}

@end
