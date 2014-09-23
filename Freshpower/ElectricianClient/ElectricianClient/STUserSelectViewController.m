//
//  STUserSelectViewController.m
//  ElectricianClient
//
//  Created by Start on 3/31/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STUserSelectViewController.h"
#import "STFindElectricianMapViewController.h"
#import "STIndexViewController.h"
#import "STLoginViewController.h"
#import "STMyeViewController.h"

@interface STUserSelectViewController ()

@end

@implementation STUserSelectViewController

- (id)init
{
    self = [super init];
    if (self) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"loginbg"]]];
        
        UIButton *btnLoginExperience=[[UIButton alloc]initWithFrame:CGRectMake(17, 40, 286, 198)];
        [btnLoginExperience.titleLabel setFont:[UIFont systemFontOfSize: 12.0]];
        [btnLoginExperience setBackgroundImage:[UIImage imageNamed:@"loginty"] forState:UIControlStateNormal];
        [btnLoginExperience addTarget:self action:@selector(loginExperience:) forControlEvents:UIControlEventTouchUpInside];
        [btnLoginExperience setBackgroundColor:BTNCOLORGB];
        [self.view addSubview:btnLoginExperience];
        
        UIButton *btnLoginUser=[[UIButton alloc]initWithFrame:CGRectMake(17, 250, 286, 198)];
        [btnLoginUser.titleLabel setFont:[UIFont systemFontOfSize: 12.0]];
        [btnLoginUser setBackgroundImage:[UIImage imageNamed:@"loginqy"] forState:UIControlStateNormal];
        [btnLoginUser addTarget:self action:@selector(loginUser:) forControlEvents:UIControlEventTouchUpInside];
        [btnLoginUser setBackgroundColor:BTNCOLORGB];
        [self.view addSubview:btnLoginUser];
    }
    return self;
}

//登录体验
- (void)loginExperience:(id)sender
{
    //首页
    STIndexViewController *indexViewController = [[STIndexViewController alloc]init];
    indexViewController.tabBarItem.title=@"首页";
    indexViewController.tabBarItem.image=[UIImage imageNamed:@"sy2"];
    //我要学习
    UINavigationController *findElectricianMapViewControllerNav = [[UINavigationController alloc] initWithRootViewController:[[STFindElectricianMapViewController alloc]init]];
    findElectricianMapViewControllerNav.tabBarItem.title=@"找电工";
    findElectricianMapViewControllerNav.tabBarItem.image=[UIImage imageNamed:@"dg2"];
    //我的e电工
    UINavigationController *myeViewControllerNav = [[UINavigationController alloc] initWithRootViewController:[[STMyeViewController alloc]init]];
    myeViewControllerNav.tabBarItem.title=@"我的e电工";
    myeViewControllerNav.tabBarItem.image=[UIImage imageNamed:@"e2"];
    
    UITabBarController *tabBarController=[[UITabBarController alloc]init];
    [tabBarController setViewControllers:[NSArray arrayWithObjects:
                                          indexViewController,
                                          findElectricianMapViewControllerNav,
                                          myeViewControllerNav,
                                          nil] animated:YES];
    
    [self presentViewController:tabBarController animated:YES completion:nil];
}

//登录用户
- (void)loginUser:(id)sender
{
    UINavigationController *loginViewControllerNAV = [[UINavigationController alloc] initWithRootViewController:[[STLoginViewController alloc]init]];
    [self presentViewController:loginViewControllerNAV animated:YES completion:nil];
}

@end
