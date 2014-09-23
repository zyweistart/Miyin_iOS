//
//  STUserExperienceSelectViewController.m
//  ElectricianRun
//
//  Created by Start on 2/28/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STUserExperienceSelectViewController.h"
#import "STUserExperienceAlarmViewController.h"
#import "STUserExperienceViewController.h"

@interface STUserExperienceSelectViewController ()

@end

@implementation STUserExperienceSelectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"用户体验";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    float height=self.view.frame.size.height-64;
    self.automaticallyAdjustsScrollViewInsets=NO;
    UIScrollView *control=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, 320, height)];
    control.contentSize = CGSizeMake(640,height);
    [control setScrollEnabled:YES];
    UIView *firstView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, height)];
    
    UIView *firstViewGB=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 347)];
    [firstViewGB setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ty"]]];
    [firstView addSubview:firstViewGB];
    
    UIButton *btnAlarm=[[UIButton alloc]initWithFrame:CGRectMake(70, 360, 180, 30)];
    [btnAlarm setTitle:@"立即体验" forState:UIControlStateNormal];
    [btnAlarm setBackgroundColor:BTNCOLORGB];
    [btnAlarm addTarget:self action:@selector(alarm:) forControlEvents:UIControlEventTouchUpInside];
    [firstView addSubview:btnAlarm];
    
    UIImageView *ftop=[[UIImageView alloc]initWithFrame:CGRectMake(150, 400, 19, 7)];
    [ftop setImage:[UIImage imageNamed:@"d1"]];
    [firstView addSubview:ftop];
    [control addSubview:firstView];
    
    UIView *secondView=[[UIView alloc]initWithFrame:CGRectMake(320, 0, 320, height)];
    
    UIView *secondViewGB=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 276)];
    [secondViewGB setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"ty1"]]];
    [secondView addSubview:secondViewGB];
    
    UIButton *btnBusiness=[[UIButton alloc]initWithFrame:CGRectMake(22, 290, 128, 91.5)];
    [btnBusiness setBackgroundImage:[UIImage imageNamed:@"sy"] forState:UIControlStateNormal];
    [btnBusiness addTarget:self action:@selector(business:) forControlEvents:UIControlEventTouchUpInside];
    [secondView addSubview:btnBusiness];

    UIButton *btnIndustrial=[[UIButton alloc]initWithFrame:CGRectMake(172, 290, 128, 91.5)];
    [btnIndustrial setBackgroundImage:[UIImage imageNamed:@"dsy"] forState:UIControlStateNormal];
    [btnIndustrial addTarget:self action:@selector(industrial:) forControlEvents:UIControlEventTouchUpInside];
    [secondView addSubview:btnIndustrial];
    
    UIImageView *stop=[[UIImageView alloc]initWithFrame:CGRectMake(150, 400, 19, 7)];
    [stop setImage:[UIImage imageNamed:@"d2"]];
    [secondView addSubview:stop];
    [control addSubview:secondView];
    
    [self.view addSubview:control];
}

- (void)alarm:(id)sender
{
    UINavigationController *userExperienceAlarmViewControllerNav = [[UINavigationController alloc] initWithRootViewController:[[STUserExperienceAlarmViewController alloc]init]];
    [self presentViewController:userExperienceAlarmViewControllerNav animated:YES completion:nil];
}

- (void)business:(id)sender
{
    UINavigationController *userExperienceViewControllerNav = [[UINavigationController alloc] initWithRootViewController:[[STUserExperienceViewController alloc]initWithUserType:2]];
    [self presentViewController:userExperienceViewControllerNav animated:YES completion:nil];
}

- (void)industrial:(id)sender
{
    UINavigationController *userExperienceViewControllerNav = [[UINavigationController alloc] initWithRootViewController:[[STUserExperienceViewController alloc]initWithUserType:1]];
    [self presentViewController:userExperienceViewControllerNav animated:YES completion:nil];
}

@end
