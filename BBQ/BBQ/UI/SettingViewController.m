#import "SettingViewController.h"
#import "SwitchCell.h"
#import "AboutViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (id)init{
    self=[super init];
    if(self){
        [self cTitle:LOCALIZATION(@"Setting")];
        
        [self.dataItemArray addObject:LOCALIZATION(@"Temp Unit")];
        [self.dataItemArray addObject:LOCALIZATION(@"Alarm")];
        [self.dataItemArray addObject:LOCALIZATION(@"Language")];
        [self.dataItemArray addObject:LOCALIZATION(@"About")];
        
        [self buildTableViewWithView:self.view style:UITableViewStyleGrouped];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveLanguageChangedNotification:)
                                                     name:kNotificationLanguageChanged
                                                   object:nil];
        [[Localisator sharedInstance] setSaveInUserDefaults:YES];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
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
            [cell.detailTextLabel setText:LOCALIZATION(@"CurrentLanguage")];
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
                                                        cancelButtonTitle:LOCALIZATION(@"Cancel")
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"Beep1", @"Beep2", @"Beep3", nil];
        [choiceSheet setTag:1];
        [choiceSheet showInView:self.view];
    }else if(row==2){
        UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                                 delegate:self
                                                        cancelButtonTitle:LOCALIZATION(@"Cancel")
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"English",@"简体中文", nil];
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
            [[Localisator sharedInstance] setLanguage:@"en"];
        }else if(buttonIndex==1){
            [[Localisator sharedInstance] setLanguage:@"zh-Hans"];
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
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:NOTIFICATION_REFRESHDATA object: nil];
}

- (void)receiveLanguageChangedNotification:(NSNotification *)notification
{
    if ([notification.name isEqualToString:kNotificationLanguageChanged]) {
        [Common alert:@"修改语言成功请重启应用生效"];
    }
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationLanguageChanged object:nil];
}

@end
