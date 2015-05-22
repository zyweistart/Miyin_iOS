//
//  STGuideViewController.m
//  ElectricianRun
//
//  Created by Start on 2/11/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STGuideViewController.h"
#import "HomeViewController.h"
#import "NearbyViewController.h"
#import "VIPViewController.h"
#import "MyViewController.h"

#import "SQLiteOperate.h"

#define DOWNLOADPIC 500
#define TOPIMAGENUM 3
#define TAB_N_TEXTCOLOR [UIColor colorWithRed:(99/255.0) green:(111/255.0) blue:(125/255.0) alpha:1]
#define TAB_P_TEXTCOLOR [UIColor colorWithRed:(46/255.0) green:(92/255.0) blue:(178/255.0) alpha:1]

@interface STGuideViewController ()

@end

@implementation STGuideViewController{
    SQLiteOperate *db;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [self downLoadPicture];
    
    UINavigationController *homeViewControllerNav = [[UINavigationController alloc] initWithRootViewController:[[HomeViewController alloc]init]];
    [[homeViewControllerNav tabBarItem] setImage:[[UIImage imageNamed:@"ic_home_n"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[homeViewControllerNav tabBarItem] setSelectedImage:[[UIImage imageNamed:@"ic_home_p"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[homeViewControllerNav tabBarItem] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: TAB_N_TEXTCOLOR,NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [[homeViewControllerNav tabBarItem] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: TAB_P_TEXTCOLOR,NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [[homeViewControllerNav tabBarItem]setTitle:@"首页"];
    [[homeViewControllerNav navigationBar]setBarTintColor:NAVBG];
    [[homeViewControllerNav navigationBar]setBarStyle:UIBarStyleBlackTranslucent];
    UINavigationController *nearbyViewControllerNav = [[UINavigationController alloc] initWithRootViewController:[[NearbyViewController alloc]init]];
    [[nearbyViewControllerNav tabBarItem] setImage:[[UIImage imageNamed:@"ic_nearby_n"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[nearbyViewControllerNav tabBarItem] setSelectedImage:[[UIImage imageNamed:@"ic_nearby_p"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[nearbyViewControllerNav tabBarItem] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: TAB_N_TEXTCOLOR,NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [[nearbyViewControllerNav tabBarItem] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: TAB_P_TEXTCOLOR,NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [[nearbyViewControllerNav tabBarItem]setTitle:@"附近"];
    [[nearbyViewControllerNav navigationBar]setBarTintColor:NAVBG];
    [[nearbyViewControllerNav navigationBar]setBarStyle:UIBarStyleBlackTranslucent];
    UINavigationController *vipViewControllerNav = [[UINavigationController alloc] initWithRootViewController:[[VIPViewController alloc]init]];
    [[vipViewControllerNav tabBarItem] setImage:[[UIImage imageNamed:@"ic_vip_n"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[vipViewControllerNav tabBarItem] setSelectedImage:[[UIImage imageNamed:@"ic_vip_p"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[vipViewControllerNav tabBarItem] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: TAB_N_TEXTCOLOR,NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [[vipViewControllerNav tabBarItem] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: TAB_P_TEXTCOLOR,NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [[vipViewControllerNav tabBarItem]setTitle:@"VIP"];
    [[vipViewControllerNav navigationBar]setBarTintColor:NAVBG];
    [[vipViewControllerNav navigationBar]setBarStyle:UIBarStyleBlackTranslucent];
    //    UINavigationController *myViewControllerNav = [[UINavigationController alloc] initWithRootViewController:[[MyViewController alloc]init]];
    MyViewController *myViewControllerNav=[[MyViewController alloc]init];
    [[myViewControllerNav tabBarItem] setImage:[[UIImage imageNamed:@"ic_my_n"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[myViewControllerNav tabBarItem] setSelectedImage:[[UIImage imageNamed:@"ic_my_p"]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[myViewControllerNav tabBarItem] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: TAB_N_TEXTCOLOR,NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [[myViewControllerNav tabBarItem] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: TAB_P_TEXTCOLOR,NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [[myViewControllerNav tabBarItem]setTitle:@"我的"];
    //    [[myViewControllerNav navigationBar]setBarTintColor:NAVBG];
    //    [[myViewControllerNav navigationBar]setBarStyle:UIBarStyleBlackTranslucent];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    //    _tabBarController.delegate = self;
    self.viewControllers = [NSArray arrayWithObjects:
                                         homeViewControllerNav,
                                         nearbyViewControllerNav,
                                         vipViewControllerNav,
                                         myViewControllerNav,
                                         nil];

    
//    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
//    
//    [self setViewControllers:[NSArray arrayWithObjects:
//                              homeViewControllerNav,
//                              nearbyViewControllerNav,
//                              vipViewControllerNav,
//                              myViewControllerNav,
//                              nil] animated:YES];
    
    //获取最后保存的版本号不存在则为0
    float lastVersionNo=[[Common getCache:DEFAULTDATA_LASTVERSIONNO] floatValue];
    NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
    //获取当前使用的版本号
    NSString *currentVersionNo=[infoDict objectForKey:@"CFBundleShortVersionString"];
    if([currentVersionNo floatValue]>lastVersionNo){
        [self showIntroWithCrossDissolve];
    }
}

- (void)showIntroWithCrossDissolve {
    EAIntroPage *page1 = [EAIntroPage page];
    page1.bgImage = [UIImage imageNamed:@"guide1"];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.bgImage = [UIImage imageNamed:@"guide2"];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.bgImage = [UIImage imageNamed:@"guide3"];
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2,page3]];
    
    [intro setDelegate:self];
    [intro showInView:self.view animateDuration:0.0];
}

- (void)introDidFinish {
    NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
    NSString *currentVersionNo=[infoDict objectForKey:@"CFBundleShortVersionString"];
    [Common setCache:DEFAULTDATA_LASTVERSIONNO data:currentVersionNo];
}

//下载图片
- (void)downLoadPicture
{
//    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
//    [params setObject:@"2" forKey:@"type"];
//    [params setObject:[NSString stringWithFormat:@"%d",TOPIMAGENUM] forKey:@"num"];
//    self.hRequest=[[HttpRequest alloc]init];
//    [self.hRequest setRequestCode:DOWNLOADPIC];
//    [self.hRequest setDelegate:self];
//    [self.hRequest setController:self];
//    [self.hRequest handle:URL_news requestParams:params];
}

- (void)requestFinishedByResponse:(Response*)response responseCode:(int)repCode
{
    if(repCode==DOWNLOADPIC){
        NSDictionary *dic=[[response resultJSON]objectForKey:@"Rows"];
        if(dic!=nil) {
            if([@"0" isEqualToString:[dic objectForKey:@"result"]]){
                return;
            }
        }
        NSString *url=[[response resultJSON] objectForKey:@"URL"];
        NSMutableArray *outdata=[[response resultJSON] objectForKey:@"FILE_NAMES"];
        db=[[SQLiteOperate alloc]init];
        if([db openDB]){
            if([db createTable1]){
                NSString *sqlQuery = [NSString stringWithFormat:@"SELECT * FROM PIC WHERE URL='%@'",url];
                NSMutableArray *indata=[db query1:sqlQuery];
                for(NSDictionary *outd in outdata){
                    NSString *out_filename=[outd objectForKey:@"FILE_NAME"];
                    BOOL flag=NO;
                    for(NSDictionary *ind in indata){
                        flag=NO;
                        NSString *inname=[ind objectForKey:@"name"];
                        
                        if([out_filename isEqualToString:inname]){
                            
                            flag=YES;
                            
                            break;
                        }
                        
                    }
                    if(!flag){
                        NSString *sql = [NSString stringWithFormat:
                                         @"INSERT INTO PIC (URL,NAME) VALUES ('%@', '%@')",url, out_filename];
                        if([db execSql:sql]){
                            NSString *ufile=[NSString stringWithFormat:@"%@%@",url,out_filename];
                            [Common AsynchronousDownloadImageWithUrl:ufile ShowImageView:nil];
                        }
                    }
                }
                
            }
        }
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
}

@end
