//
//  STIndexViewController.m
//  ElectricianRun
//  首页
//  Created by Start on 1/24/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STIndexViewController.h"

#import "STUserExperienceSelectViewController.h"
#import "STProjectSiteViewController.h"
#import "STScanningOperationViewController.h"
#import "STCalculateViewController.h"
#import "STDataMonitoringViewController.h"
#import "STAlarmManagerViewController.h"
#import "STTaskManagerViewController.h"
#import "STTaskAuditViewController.h"
#import "STNewsListViewController.h"
#import "STLoginViewController.h"

#import "ETFoursquareImages.h"
#import "SQLiteOperate.h"

@interface STIndexViewController () <UITabBarControllerDelegate>

@end

@implementation STIndexViewController{
    HttpRequest *_hRequest;
    
    NSDictionary *newData;
    
    SQLiteOperate *db;
    UIImageView *img;
    UILabel *lblTitle;
    UILabel *lblContent;
}

- (void)viewDidLoad {
    
    int IMAGEHEIGHT=199;
    
    [super viewDidLoad];
    ETFoursquareImages *foursquareImages = [[ETFoursquareImages alloc] initWithFrame:CGRectMake(0, 0, 320,IMAGEHEIGHT)];
    [foursquareImages setImagesHeight:IMAGEHEIGHT];
    
    NSMutableArray *images=[[NSMutableArray alloc]init];
    
    db=[[SQLiteOperate alloc]init];
    if([db openDB]){
        //创建文件管理器
        NSFileManager* fileManager = [NSFileManager defaultManager];
        //获取Documents主目录
        NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        //得到相应的Documents的路径
        NSString* docDir = [paths objectAtIndex:0];
        //更改到待操作的目录下
        [fileManager changeCurrentDirectoryPath:[docDir stringByExpandingTildeInPath]];
        NSString *sqlQuery = [NSString stringWithFormat:@"SELECT * FROM PIC ORDER BY ID DESC limit %d offset 0",TOPIMAGENUM];
        NSMutableArray *indata=[db query1:sqlQuery];
        if(indata!=nil&&[indata count]>0){
            for(int i=0;i<[indata count];i++){
                NSString *name=[[indata objectAtIndex:i] objectForKey:@"name"];
                NSString *path = [docDir stringByAppendingPathComponent:name];
                //如果图标文件已经存在则进行显示否则进行下载
                if([fileManager fileExistsAtPath:path]){
                    [images addObject:[UIImage imageWithContentsOfFile:path]];
                }
            }
        }
    }
    //如果不够则加载默认的图片
    if([images count]==0){
        for(int i=0;i<TOPIMAGENUM;i++){
            [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"image%d",i+1]]];
        }
    }
    [foursquareImages setImages:images];
//    [foursquareImages setBackgroundColor:[UIColor redColor]];
    
    [self.view addSubview:foursquareImages];
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    UIScrollView *scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, IMAGEHEIGHT, 320, inch4?320:250)];
    [scroll setBackgroundColor:[UIColor whiteColor]];
    scroll.contentSize = CGSizeMake(320,320);
    [scroll setScrollEnabled:YES];
    [self.view addSubview:scroll];
    
    //用户体验
    UIButton *btnF1=[[UIButton alloc]initWithFrame:CGRectMake(5,5, 152.5, 100)];
    [btnF1 setBackgroundImage:[UIImage imageNamed:@"yh1"] forState:UIControlStateNormal];
    [btnF1 addTarget:self action:@selector(onClickUserExperience:) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:btnF1];
    //我管辖的变电站
    UIButton *btnF2=[[UIButton alloc]initWithFrame:CGRectMake(162.5,5, 152.5, 100)];
    [btnF2 setBackgroundImage:[UIImage imageNamed:@"bdz1"] forState:UIControlStateNormal];
    [btnF2 addTarget:self action:@selector(onClickJurisdiction:) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:btnF2];
    //工程建站
    UIButton *btnF4=[[UIButton alloc]initWithFrame:CGRectMake(5,110, 100, 100)];
    [btnF4 setBackgroundImage:[UIImage imageNamed:@"gcjz"] forState:UIControlStateNormal];
    [btnF4 addTarget:self action:@selector(onClickSite:) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:btnF4];
    //扫描操作
    UIButton *btnF5=[[UIButton alloc]initWithFrame:CGRectMake(110,110, 100, 100)];
    [btnF5 setBackgroundImage:[UIImage imageNamed:@"sm"] forState:UIControlStateNormal];
    [btnF5 addTarget:self action:@selector(onClickOperating:) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:btnF5];
    //在线计算
    UIButton *btnF6=[[UIButton alloc]initWithFrame:CGRectMake(215,110, 100, 100)];
    [btnF6 setBackgroundImage:[UIImage imageNamed:@"zxjs"] forState:UIControlStateNormal];
    [btnF6 addTarget:self action:@selector(onClickCalculation:) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:btnF6];
    
    UIView *newView=[[UIView alloc]initWithFrame:CGRectMake(5, 215, 310, 100)];
    [newView setUserInteractionEnabled:YES];
    [newView setBackgroundColor:[UIColor colorWithRed:(221/255.0) green:(221/255.0) blue:(221/255.0) alpha:1]];
    [newView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickNewList:)]];
    
    img=[[UIImageView alloc]initWithFrame:CGRectMake(5, 15, 80, 60)];
    [newView addSubview:img];
    lblTitle=[[UILabel alloc]initWithFrame:CGRectMake(90, 7, 215, 15)];
    [lblTitle setFont:[UIFont systemFontOfSize:12]];
    [lblTitle setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
    [lblTitle setTextAlignment:NSTextAlignmentLeft];
    [newView addSubview:lblTitle];
    lblContent=[[UILabel alloc]initWithFrame:CGRectMake(95, 25, 210, 55)];
    [lblContent setFont:[UIFont systemFontOfSize:10]];
    [lblContent setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
    [lblContent setTextAlignment:NSTextAlignmentLeft];
    [lblContent setNumberOfLines:0];
    [newView addSubview:lblContent];
    
    [scroll addSubview:newView];
    
    foursquareImages.scrollView.contentSize = CGSizeMake(320, 320+IMAGEHEIGHT);
    
    [foursquareImages.pageControl setCurrentPageIndicatorTintColor:[UIColor colorWithRed:(28/255.f) green:(189/255.f) blue:(141/255.f) alpha:1.0]];
    db=[[SQLiteOperate alloc]init];
    if([db openDB]){
        NSString *sqlQuery = @"SELECT * FROM NEW";
        NSMutableArray *indata=[db query:sqlQuery];
        if(indata!=nil&&[indata count]>0){
            int r=arc4random()%[indata count];
            newData=[indata objectAtIndex:r];
            [lblTitle setText:[newData objectForKey:@"name"]];
            [lblContent setText:[newData objectForKey:@"content"]];
            NSString *icon_name=[newData objectForKey:@"icon_name"];
            //创建文件管理器
            NSFileManager* fileManager = [NSFileManager defaultManager];
            //获取Documents主目录
            NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
            //得到相应的Documents的路径
            NSString* docDir = [paths objectAtIndex:0];
            //更改到待操作的目录下
            [fileManager changeCurrentDirectoryPath:[docDir stringByExpandingTildeInPath]];
            NSString *path = [docDir stringByAppendingPathComponent:icon_name];
            //如果图标文件已经存在则进行显示否则进行下载
            if([fileManager fileExistsAtPath:path]){
                [img setImage:[UIImage imageWithContentsOfFile:path]];
            }
        }else{
            NSString *name=@"《中国电力报》：浙江新能量保障机场变电站运行";
            NSString *content=@"12月25日，《中国电力报》于“传统能源”版面，新闻报道了浙江新能量科技有限公司作为杭州萧山国际机场20余座变电站的运行方，为萧山机场新航站楼的开通运营保驾护航。";
            [lblTitle setText:name];
            [lblContent setText:content];
            [img setImage:[UIImage imageNamed:@"tmpnewpic"]];
        }
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden=YES;
}

//用户体验
- (void)onClickUserExperience:(id)sender {
    UINavigationController *userExperienceSelectViewControllerNav = [[UINavigationController alloc] initWithRootViewController:[[STUserExperienceSelectViewController alloc]init]];
    [self presentViewController:userExperienceSelectViewControllerNav animated:YES completion:nil];
}

//我管辖的变电站
- (void)onClickJurisdiction:(id)sender {
    if(![Account isLogin]){
        [Common alert:@"你还未登录，请先登录!"];
        STLoginViewController *loginViewController=[[STLoginViewController alloc]init];
        self.navigationController.navigationBarHidden=NO;
        [self.navigationController pushViewController:loginViewController animated:YES];
        return;
    }
    
    if(![Account isAuth:@"ELEC_MANAGER_SUBSTATION"]){
        [Common alert:@"没有该权限"];
        return;
    }
    NSMutableArray *views=[[NSMutableArray alloc]init];
    
    if([Account isAuth:@"ELEC_DATE_MONITOR"]){
        //数据监测
        UINavigationController *dtaMonitoringViewControllerNav = [[UINavigationController alloc] initWithRootViewController:[[STDataMonitoringViewController alloc]init]];
        //    dtaMonitoringViewControllerNav.navigationBarHidden=YES;
        dtaMonitoringViewControllerNav.tabBarItem.title=@"数据监测";
        dtaMonitoringViewControllerNav.tabBarItem.image=[UIImage imageNamed:@"sj"];
        [views addObject:dtaMonitoringViewControllerNav];
    }
    if([Account isAuth:@"ELEC_ALARM"]){
        //报警管理
        UINavigationController *alarmManagerViewControllerNav = [[UINavigationController alloc] initWithRootViewController:[[STAlarmManagerViewController alloc]init]];
        alarmManagerViewControllerNav.tabBarItem.title=@"报警管理";
        alarmManagerViewControllerNav.tabBarItem.image=[UIImage imageNamed:@"bj"];
        [views addObject:alarmManagerViewControllerNav];
    }
    if([Account isAuth:@"ELEC_TASK"]){
        //任务管理
        UINavigationController *taskManagerViewControllerNav = [[UINavigationController alloc] initWithRootViewController:[[STTaskManagerViewController alloc]init]];
        taskManagerViewControllerNav.title=@"任务管理";
        taskManagerViewControllerNav.tabBarItem.title=@"任务管理";
        taskManagerViewControllerNav.tabBarItem.image=[UIImage imageNamed:@"gl"];
        [views addObject:taskManagerViewControllerNav];
    }
    if([Account isAuth:@"ELEC_TASK_CHECK"]){
        //任务稽核
        UINavigationController *taskAuditViewControllerNav = [[UINavigationController alloc] initWithRootViewController:[[STTaskAuditViewController alloc]init]];
        taskAuditViewControllerNav.title=@"任务稽核";
        taskAuditViewControllerNav.tabBarItem.title=@"任务稽核";
        taskAuditViewControllerNav.tabBarItem.image=[UIImage imageNamed:@"rw"];
        [views addObject:taskAuditViewControllerNav];
    }
    
    if([views count]==0){
        [Common alert:@"没有该权限"];
        return;
    }
    
    UITabBarController *_tabBarController = [[UITabBarController alloc] init];
    [_tabBarController.view setBackgroundColor:[UIColor whiteColor]];
    _tabBarController.viewControllers = views;
    [_tabBarController setDelegate:self];
    [self presentViewController:_tabBarController animated:YES completion:nil];
}

//工程建站
- (void)onClickSite:(id)sender {
    if(![Account isLogin]){
        [Common alert:@"你还未登录，请先登录!"];
        STLoginViewController *loginViewController=[[STLoginViewController alloc]init];
        self.navigationController.navigationBarHidden=NO;
        [self.navigationController pushViewController:loginViewController animated:YES];
        return;
    }
    if(![Account isAuth:@"ELEC_SUBSTATION_CREATE"]){
        [Common alert:@"没有该权限"];
        return;
    }
    UINavigationController *projectSiteViewControllerNav = [[UINavigationController alloc] initWithRootViewController:[[STProjectSiteViewController alloc]init]];
    [self presentViewController:projectSiteViewControllerNav animated:YES completion:nil];
}

//扫描操作
- (void)onClickOperating:(id)sender {
    if(![Account isLogin]){
        [Common alert:@"你还未登录，请先登录!"];
        STLoginViewController *loginViewController=[[STLoginViewController alloc]init];
        self.navigationController.navigationBarHidden=NO;
        [self.navigationController pushViewController:loginViewController animated:YES];
        return;
    }
    UINavigationController *scanningOperationViewControllerNav = [[UINavigationController alloc] initWithRootViewController:[[STScanningOperationViewController alloc]init]];
    [self presentViewController:scanningOperationViewControllerNav animated:YES completion:nil];
}

//在线计算
- (void)onClickCalculation:(id)sender {
    UINavigationController *calculateViewControllerNav = [[UINavigationController alloc] initWithRootViewController:[[STCalculateViewController alloc]init]];
    [self presentViewController:calculateViewControllerNav animated:YES completion:nil];
}

//新闻详细
- (void)onClickNewList:(id)sender {
    UINavigationController *newsDetailViewControllerNav = [[UINavigationController alloc] initWithRootViewController:[[STNewsListViewController alloc]initWithData:newData]];
    [self presentViewController:newsDetailViewControllerNav animated:YES completion:nil];
}

- (void)tabBarController:(UITabBarController*)tabBarController didSelectViewController:(UIViewController*)viewController {
    if ([@"报警管理" isEqualToString:viewController.title]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:Notification_TabClick_STAlarmManagerViewController object:@"load"];
    }
}

@end
