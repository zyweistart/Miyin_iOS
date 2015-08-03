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
        
        [self.dataItemArray addObject:@"Temp Unit"];
        [self.dataItemArray addObject:@"Alarm"];
        [self.dataItemArray addObject:@"Language"];
        [self.dataItemArray addObject:@"About"];
        
        [self buildTableViewWithView:self.view style:UITableViewStyleGrouped];
        [[Localisator sharedInstance] setSaveInUserDefaults:YES];
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self stopAlarm];
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
        [cell.textLabel setText:LOCALIZATION(content)];
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
        
        [cell.textLabel setText:LOCALIZATION(content)];
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
        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.wav",[[Data Instance]getAlarm]]];
        NSURL *URL=[NSURL fileURLWithPath:path];
        self.mAVAudioPlayer=[[AVAudioPlayer alloc] initWithContentsOfURL:URL error:nil];
        [self.mAVAudioPlayer setDelegate:self];
        [self.mAVAudioPlayer setVolume:1.0];
        [self.mAVAudioPlayer setNumberOfLoops:0];
        if([self.mAVAudioPlayer prepareToPlay]){
            [self.mAVAudioPlayer play];
        }
    }else if(actionSheet.tag==2){
        if(buttonIndex==0){
            [[Localisator sharedInstance] setLanguage:@"en"];
        }else if(buttonIndex==1){
            [[Localisator sharedInstance] setLanguage:@"zh-Hans"];
        }
        [self.tableView reloadData];
    }
}

//播放结束时执行的动作
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer*)player successfully:(BOOL)flag{
    if (flag) {
    }
}

//报警声音停止
- (void)stopAlarm
{
    if(self.mAVAudioPlayer){
        [self.mAVAudioPlayer stop];
        self.mAVAudioPlayer=nil;
        //        [[AVAudioSession sharedInstance] setActive:NO error:nil];
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

- (void)changeLanguageText
{
    [self cTitle:LOCALIZATION(@"Setting")];
    [self setTitle:LOCALIZATION(@"Setting")];
    [self.tableView reloadData];
    //    [Common alert:@"修改语言成功请重启应用生效"];
}

@end
