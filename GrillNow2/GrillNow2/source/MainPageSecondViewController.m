//
//  MainPageSecondViewController.m
//  Graff Now
//
//  Created by Yang Shubo on 13-8-21.
//  Copyright (c) 2013年 Yang Shubo. All rights reserved.
//

#import "MainPageSecondViewController.h"



@interface MainPageSecondViewController ()

@end

@implementation MainPageSecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Second", @"Second");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
