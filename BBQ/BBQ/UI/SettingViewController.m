#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (id)init{
    self=[super init];
    if(self){
        [self cTitle:@"Setting"];
        
        [self.dataItemArray addObject:@"心情轨迹"];
        [self.dataItemArray addObject:@"我发布的"];
        [self.dataItemArray addObject:@"设置"];
        
        [self buildTableViewWithView:self.view];
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"SAMPLECell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSString *content=[self.dataItemArray objectAtIndex:indexPath.row];
    cell.textLabel.text = content;
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

@end
