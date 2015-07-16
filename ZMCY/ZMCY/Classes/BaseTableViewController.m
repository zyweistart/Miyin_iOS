#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (id)init{
    self=[super init];
    if(self){
        self.dataItemArray=[[NSMutableArray alloc]init];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     return [self.dataItemArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGHeight(45);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"SAMPLECell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = @"数据项";
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

//创建UITableView
- (UITableView *)buildTableViewWithView:(UIView*)view;
{
    return [self buildTableViewWithView:view style:UITableViewStylePlain];
}

- (UITableView *)buildTableViewWithView:(UIView*)view style:(UITableViewStyle)style
{
    if(self.tableView==nil){
        self.tableView=[[UITableView alloc]initWithFrame:view.bounds style:style];
        [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
        [view addSubview:self.tableView];
    }
    return self.tableView;
}

@end
