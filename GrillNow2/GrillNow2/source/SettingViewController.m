//
//  SettingViewController.m
//  Grall Now
//
//  Created by Yang Shubo on 13-8-28.
//  Copyright (c) 2013年 Yang Shubo. All rights reserved.
//

#import "SettingViewController.h"
#import "Marcro.h"
#import "DataCenter.h"
#import "RenameSensorViewController.h"
#import "AudioToolbox/AudioToolbox.h"
@interface SettingViewController ()

@end

@implementation SettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
  
    [super viewWillAppear:animated];
}
- (void)viewDidLoad
{
    //776b5f 2693
    
    //[self.segment setDividerImage:[UIImage imageNamed:@"segmentBackground"]
     //         forLeftSegmentState:UIControlStateNormal
     //           rightSegmentState:UIControlStateNormal
     //                  barMetrics:UIBarMetricsDefault];

   
    [super viewDidLoad];
    
    //[self.segment setBackgroundImage:[UIImage imageNamed:@"segmentBackground"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 

//- (IBAction)OnSegmentChange:(id)sender {
//    
//    if(!self.segment.selectedSegmentIndex){
//        [DataCenter getInstance].IsC = NO;
//    }
//    else{
//        [DataCenter getInstance].IsC = YES;
//    }
//    
//    [[DataCenter getInstance].CurrentDevice ModifyUnit];
//}

- (IBAction)OnBtnRename:(id)sender {
    if(!renameView)
    {
        renameView = [[RenameSensorViewController alloc] init];
    }
    renameView.view.alpha=0;
    
    [self.view addSubview:renameView.view];
    [UIView animateWithDuration:0.2f animations:^{
        renameView.view.alpha = 1;
    }];
}

- (IBAction)OnBtnTempAlarm:(id)sender {
    alarmRingView = [[AlarmRingSelectViewController alloc] init];
    alarmRingView.Prefix = @"Temperature";
    alarmRingView.view.alpha=0;
    //[alarmRingView reload];
    [self.view addSubview:alarmRingView.view];
    [UIView animateWithDuration:0.2f animations:^{
        alarmRingView.view.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

- (IBAction)OnBtnTimer:(id)sender {
    
    alarmRingView = [[AlarmRingSelectViewController alloc] init];
    alarmRingView.Prefix = @"Timer";
    alarmRingView.view.alpha=0;
    //[alarmRingView reload];
    
    [self.view addSubview:alarmRingView.view];
    [UIView animateWithDuration:0.2f animations:^{
        alarmRingView.view.alpha = 1;
    } completion:^(BOOL finished) {
       
    }];

}
@end

  