//
//  AlarmRingSelectViewController.m
//  Grall Now
//
//  Created by Yang Shubo on 13-8-28.
//  Copyright (c) 2013年 Yang Shubo. All rights reserved.
//

#import "AlarmRingSelectViewController.h"
#import "AlermRingCell.h"
#import "AlarmRing.h"
#import "DataCenter.h"
#import "AudioToolbox/AudioToolbox.h"
#define MSG_SEL_RING @"MSG_SEL_ALARMRING"

@interface AlarmRingSelectViewController ()

@end

@implementation AlarmRingSelectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    rings =  [DataCenter getInstance].AlarmRingList;
   
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [lbTitle setText:[NSString stringWithFormat:@"%@ Alarm", self.Prefix]];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return rings.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AlarmRing* ring = [rings objectAtIndex:indexPath.row];
    ring.RingPrefix = self.Prefix;
    ring.IsSelected=YES;
 
    AlermRingCell* cell = (AlermRingCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    [cell SetCheck:YES];
    if(ring){
        if([self.Prefix isEqual:@"Timer"])
        {
            [DataCenter getInstance].TimerAlarm = ring;
        }
        else if([self.Prefix isEqual:@"Temperature"])
        {
            [DataCenter getInstance].TemperatureAlarm  = ring;
        }
        [self PlaySound:ring];
    }
    [tableView reloadData];
}

-(void)PlaySound:(AlarmRing*)ring
{
    NSString *soundFilePath =
    [[NSBundle mainBundle] pathForResource: ring.RingFilePath
                                    ofType: @"wav"];
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
    AVAudioPlayer *newPlayer =
    [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL
                                           error: nil];
    //[fileURL release];
    player = newPlayer;
    //[newPlayer release];
    [player prepareToPlay];
    
    //[player setDelegate: self];
    player.numberOfLoops = -1;    // Loop playback until invoke stop method
    [player play];
    //AudioServicesDisposeSystemSoundID(lastId);
    //SystemSoundID soundID;
    //NSURL *filePath   = [[NSBundle mainBundle] URLForResource:ring.RingFilePath withExtension: @".wav"];
    //AudioServicesCreateSystemSoundID((CFURLRef)CFBridgingRetain(filePath), &soundID);
    //AudioServicesPlaySystemSound(ring.RingId);
    //lastId = ring.RingId;
}
-(void)reload
{
    [tv reloadData];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AlermRingCell* cell = [tableView dequeueReusableCellWithIdentifier:@"AlermRingCell"];
    AlarmRing* ring = [rings objectAtIndex:indexPath.row];
    ring.RingPrefix = self.Prefix;
    
    if(!cell)
    {
         cell = [[[NSBundle mainBundle] loadNibNamed:@"AlermRingCell" owner:self options:nil]lastObject];
        [cell Bind:ring.RingName ID:0];
    }
    if([self.Prefix isEqual:@"Timer"])
    {
        if([[DataCenter getInstance].TimerAlarm.RingName isEqualToString:ring.RingName])
        {
            
            [cell SetCheck:YES];
        }
        else
        {
            [cell SetCheck:NO];
        }
    }
    else if([self.Prefix isEqual:@"Temperature"])
    {
        if([[DataCenter getInstance].TemperatureAlarm.RingName isEqualToString:ring.RingName])
        {
            [cell SetCheck:YES];
        }
        else
        {
            [cell SetCheck:NO];
        }
    }
    
    
    return cell;
}

- (IBAction)OnExit:(id)sender {
    if(player)
    {
        [player stop];
    }
    [UIView animateWithDuration:.2f animations:^{
        self.view.alpha = 0;
    } completion:^(BOOL finish){
        [self.view removeFromSuperview];
    }];
}

- (IBAction)OnOK:(id)sender {
    [self OnExit:sender];
}
@end
