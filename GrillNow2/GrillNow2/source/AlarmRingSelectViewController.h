//
//  AlarmRingSelectViewController.h
//  Grall Now
//
//  Created by Yang Shubo on 13-8-28.
//  Copyright (c) 2013年 Yang Shubo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudioToolbox/AudioToolbox.h"
#import "AlarmRing.h"
#import "AVFoundation/AVAudioPlayer.h"
@interface AlarmRingSelectViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray* rings;
    SystemSoundID lastId;
    AVAudioPlayer* player;
    IBOutlet UITableView *tv;
    IBOutlet UIButton *tbTitle;
    IBOutlet UILabel *lbTitle;
}
@property(nonatomic,strong)NSString* Prefix;

- (IBAction)OnExit:(id)sender;
-(void)PlaySound:(AlarmRing*)ring;
-(void)reload;
@end
