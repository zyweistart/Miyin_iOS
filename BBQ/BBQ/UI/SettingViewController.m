#import "SettingViewController.h"
#import "SwitchCell.h"
#import "AboutViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (id)init{
    self=[super init];
    if(self){
        [self cTitle:@"Setting"];
        
        [self.dataItemArray addObject:@"Temp Unit"];
        [self.dataItemArray addObject:@"Alarm"];
        [self.dataItemArray addObject:@"Language"];
        [self.dataItemArray addObject:@"About"];
        
        [self buildTableViewWithView:self.view];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataItemArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CGHeight(45);
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row=[indexPath row];
    NSString *content=[self.dataItemArray objectAtIndex:row];
    if(row==0){
        static NSString *cellIdentifier = @"SWITCHCELL";
        SwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell) {
            cell = [[SwitchCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        }
        [cell.textLabel setText:content];
        [cell.rightButton addTarget:self action:@selector(goSetSwitch:) forControlEvents:UIControlEventTouchUpInside];
        if([@"c" isEqualToString:[[Data Instance]getCf]]){
            [cell.rightButton setSelected:YES];
        }else{
            [cell.rightButton setSelected:NO];
        }
        return cell;
    }else{
        static NSString *cellIdentifier = @"SAMPLECell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        }
        
        [cell.textLabel setText:content];
        if(row==1){
            [cell.detailTextLabel setText:[[Data Instance]getAlarm]];
        }else if(row==2){
            [cell.detailTextLabel setText:[[Data Instance]getLanguage]];
        }
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row=[indexPath row];
    if(row==1){
        UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                 delegate:self
                                                        cancelButtonTitle:@"Cancel"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"Beep1", @"Beep2", @"Beep3", nil];
        [choiceSheet setTag:1];
        [choiceSheet showInView:self.view];
    }else if(row==2){
        UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                 delegate:self
                                                        cancelButtonTitle:@"Cancel"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"English", @"Chinese", @"Espanol", nil];
        [choiceSheet setTag:2];
        [choiceSheet showInView:self.view];
    }else if(row==3){
        [self.navigationController pushViewController:[[AboutViewController alloc]init] animated:YES];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(actionSheet.tag==1){
        if(buttonIndex==0){
            [[Data Instance]setAlarm:@"Beep1"];
        }else if(buttonIndex==1){
            [[Data Instance]setAlarm:@"Beep2"];
        }else if(buttonIndex==2){
            [[Data Instance]setAlarm:@"Beep3"];
        }
        [self.tableView reloadData];
    }else if(actionSheet.tag==2){
        if(buttonIndex==0){
            [[Data Instance]setLanguage:@"English"];
        }else if(buttonIndex==1){
            [[Data Instance]setLanguage:@"Chinese"];
        }else if(buttonIndex==2){
            [[Data Instance]setLanguage:@"Espanol"];
        }
        [self.tableView reloadData];
    }
}

- (void)goSetSwitch:(UIButton*)sender
{
    [sender setSelected:!sender.selected];
    if(sender.selected){
        [[Data Instance] setCf:@"c"];
        NSString *json=@"{\"cf\":\"c\"}";
        [self.appDelegate sendData:json];
    }else{
        [[Data Instance] setCf:@"f"];
        NSString *json=@"{\"cf\":\"f\"}";
        [self.appDelegate sendData:json];
    }
}

@end
