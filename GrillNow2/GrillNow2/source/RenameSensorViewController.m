//
//  RenameSensorViewController.m
//  Grall Now
//
//  Created by Yang Shubo on 13-8-28.
//  Copyright (c) 2013年 Yang Shubo. All rights reserved.
//

#import "RenameSensorViewController.h"
#import "DataCenter.h"
#import "Device.h"
@interface RenameSensorViewController ()

@end

@implementation RenameSensorViewController

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
    lbName.placeholder = [DataCenter getInstance].CurrentDevice.Peripheral.name;
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)OnBtnClose:(id)sender {
    
    [UIView animateWithDuration:.2f animations:^{
        self.view.alpha = 0;
    } completion:^(BOOL finish){
        [self.view removeFromSuperview];
    }];
}
@end
