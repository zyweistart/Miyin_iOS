//
//  SettingViewController.h
//  Grall Now
//
//  Created by Yang Shubo on 13-8-28.
//  Copyright (c) 2013年 Yang Shubo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RenameSensorViewController.h"
#import "AlarmRingSelectViewController.h"
@interface SettingViewController : UIViewController
{
    

    IBOutlet UISwitch *swMeasure;
    RenameSensorViewController * renameView;
    
    AlarmRingSelectViewController*
    alarmRingView;
    
   
}
//@property (strong, nonatomic) IBOutlet UISegmentedControl *segment;
//- (IBAction)OnSegmentChange:(id)sender;
- (IBAction)OnBtnRename:(id)sender;
- (IBAction)OnBtnTempAlarm:(id)sender;
- (IBAction)OnBtnTimer:(id)sender;

@end
 