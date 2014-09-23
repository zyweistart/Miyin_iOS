//
//  STUserExperienceViewController.h
//  ElectricianRun
//
//  Created by Start on 1/24/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STBaseUserExperienceViewController.h"


@interface STUserExperienceViewController : STBaseUserExperienceViewController

@property NSTimer *countdown;

@property (strong, nonatomic) UILabel *lblCountdown;

- (id)initWithUserType:(int)userType;

@end
