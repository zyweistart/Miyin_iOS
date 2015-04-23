//
//  HomeViewController.m
//  eClient
//  首页
//  Created by Start on 3/21/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "HomeViewController.h"
#import "UIButton+TitleImage.h"
#import "InspectionManagerViewController.h"
#import "ElectricianManagerViewController.h"
#import "EquipmentMaintainViewController.h"
#import "WBBPDZViewController.h"
#import "FindElectricianViewController.h"
#import "JTDGGLViewController.h"
#import "DGSQViewController.h"
#import "FeedbackViewController.h"
#import "STWarnComapnyViewController.h"
#import "EnterpriseManagerViewController.h"
#import "STBurdenDetailListViewController.h"
#import "EnterpriseNameModifyViewController.h"
#import "MaintainEnterpriseInformationViewController.h"
#import "ElectricityTariffViewController.h"
#import "RunOverviewViewController.h"
#import "RunStatusInfoViewController.h"
#import "ETFoursquareImages.h"
#import "SQLiteOperate.h"
#import "LoginViewController.h"
#import "WarnComapnyInfoViewController.h"
#import "ElectricityContrastViewController.h"
#import "BurdenContrastViewController.h"
#import "WebDetailViewController.h"

#define TITLECOLOR  [UIColor colorWithRed:(124/255.0) green:(124/255.0) blue:(124/255.0) alpha:1]
#define LINECOLOR  [UIColor colorWithRed:(230/255.0) green:(230/255.0) blue:(230/255.0) alpha:1]
#define MAIN1BGCOLOR [UIColor colorWithRed:(236/255.0) green:(105/255.0) blue:(62/255.0) alpha:1]
#define MAIN2BGCOLOR [UIColor colorWithRed:(155/255.0) green:(207/255.0) blue:(64/255.0) alpha:1]
#define MAIN3BGCOLOR [UIColor colorWithRed:(90/255.0) green:(170/255.0) blue:(230/255.0) alpha:1]
#define MAIN4BGCOLOR [UIColor colorWithRed:(254/255.0) green:(158/255.0) blue:(25/255.0) alpha:1]
#define BRCOLOR [UIColor colorWithRed:(120/255.0) green:(120/255.0) blue:(120/255.0) alpha:0.5]

#define TOPIMAGENUM 5
#define DOWNLOADPIC 500

@interface HomeViewController ()

@end

@implementation HomeViewController{
    UIButton *bCpName;
    SQLiteOperate *db;
    NSString *currentURL;
}

- (id)init{
    self=[super init];
    if(self){
        if([[User Instance]isLogin]){
            bCpName = [UIButton buttonWithType:UIButtonTypeCustom];
            [bCpName addTarget:self action:@selector(switchCpName:) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem *negativeSpacerRight = [[UIBarButtonItem alloc]
                                                    initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                    target:nil action:nil];
            negativeSpacerRight.width = -5;
            self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacerRight, [[UIBarButtonItem alloc] initWithCustomView:bCpName], nil];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIScrollView *scrollFrame=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    [scrollFrame setContentSize:CGSizeMake1(320, 610)];
    [scrollFrame setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [scrollFrame setBackgroundColor:LINECOLOR];
    [self.view addSubview:scrollFrame];
    //上
    int IMAGEHEIGHT=150;
    ETFoursquareImages *foursquareImages = [[ETFoursquareImages alloc] initWithFrame:CGRectMake1(0, 0, 320,IMAGEHEIGHT)];
    [foursquareImages setImagesHeight:CGHeight(IMAGEHEIGHT)];
    
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
        NSString *sqlQuery = [NSString stringWithFormat:@"SELECT * FROM PIC ORDER BY ID limit %d offset 0",TOPIMAGENUM];
        NSMutableArray *indata=[db query1:sqlQuery];
        if(indata!=nil&&[indata count]>0){
            [foursquareImages setController:self];
            [foursquareImages setArray:indata];
            for(int i=0;i<[indata count];i++){
                NSDictionary *data=[indata objectAtIndex:i];
                NSString *name=[data objectForKey:@"name"];
                if(i==0){
                    currentURL=[data objectForKey:@"url"];
                }
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
        for(int i=0;i<3;i++){
            [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"image%d",i+1]]];
        }
    }
    [foursquareImages setImages:images];
    [scrollFrame addSubview:foursquareImages];
    
    UIView *fourView=[[UIView alloc]initWithFrame:CGRectMake1(0, IMAGEHEIGHT-40, 320, 40)];
    [fourView setBackgroundColor:BRCOLOR];
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 0, 180, 40)];
    [lbl setText:@"我的变配电管理"];
    [lbl setFont:[UIFont systemFontOfSize:15]];
    [lbl setTextColor:[UIColor whiteColor]];
    [lbl setTextAlignment:NSTextAlignmentLeft];
    [fourView addSubview:lbl];
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake1(270, 0, 40, 40)];
    [button setImage:[UIImage imageNamed:@"ic_answer_p"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(goForWeb:) forControlEvents:UIControlEventTouchUpInside];
    [fourView addSubview:button];
    [foursquareImages addSubview:fourView];
    //中
    UIView *middleFrame=[[UIView alloc]initWithFrame:CGRectMake1(0,IMAGEHEIGHT, 320, 180)];
    [middleFrame setBackgroundColor:[UIColor whiteColor]];
    [scrollFrame addSubview:middleFrame];
    [self addModel:@"企业设备维护" Title:@"企业设备维护" Frame:middleFrame Tag:1 X:0 Y:0];
    [self addModel:@"巡检任务管理" Title:@"巡检任务管理" Frame:middleFrame Tag:2 X:80 Y:0];
    [self addModel:@"企业电工管理" Title:@"企业电工管理" Frame:middleFrame Tag:3 X:160 Y:0];
    
    [self addModel:@"企业负荷" Title:@"企业负荷" Frame:middleFrame Tag:7 X:0 Y:90];
    [self addModel:@"报警信息" Title:@"报警信息" Frame:middleFrame Tag:4 X:80 Y:90];
    [self addModel:@"电量电费" Title:@"电量电费" Frame:middleFrame Tag:5 X:160 Y:90];
    [self addModel:@"运行状态" Title:@"运行状态" Frame:middleFrame Tag:6 X:240 Y:90];
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake1(81, 10, 1, 80)];
    [line setBackgroundColor:LINECOLOR];
    [middleFrame addSubview:line];
    line=[[UIView alloc]initWithFrame:CGRectMake1(81, 10, 1, 80)];
    [line setBackgroundColor:LINECOLOR];
    [middleFrame addSubview:line];
    line=[[UIView alloc]initWithFrame:CGRectMake1(161, 10, 1, 80)];
    [line setBackgroundColor:LINECOLOR];
    [middleFrame addSubview:line];
    line=[[UIView alloc]initWithFrame:CGRectMake1(10, 91, 300, 1)];
    [line setBackgroundColor:LINECOLOR];
    [middleFrame addSubview:line];
    line=[[UIView alloc]initWithFrame:CGRectMake1(81, 90, 1, 80)];
    [line setBackgroundColor:LINECOLOR];
    [middleFrame addSubview:line];
    line=[[UIView alloc]initWithFrame:CGRectMake1(81, 90, 1, 80)];
    [line setBackgroundColor:LINECOLOR];
    [middleFrame addSubview:line];
    line=[[UIView alloc]initWithFrame:CGRectMake1(161, 90, 1, 80)];
    [line setBackgroundColor:LINECOLOR];
    [middleFrame addSubview:line];
    line=[[UIView alloc]initWithFrame:CGRectMake1(241, 90, 1, 80)];
    [line setBackgroundColor:LINECOLOR];
    [middleFrame addSubview:line];
    //下
    UIView *bottomFrame=[[UIView alloc]initWithFrame:CGRectMake1(0,340, 320, 270)];
    [bottomFrame setBackgroundColor:[UIColor whiteColor]];
    [scrollFrame addSubview:bottomFrame];
    [bottomFrame addSubview:[self setFrameView:10 Y:10 byRoundingCorners:UIRectCornerTopLeft ImageNamed:@"外包变配电站" MainTitle:@"外包变配电站" ChildTitle:@"让您省心、放心；享受更专业，更经济的服务" bgColor:MAIN1BGCOLOR Tag:1]];
    [bottomFrame addSubview:[self setFrameView:165 Y:10 byRoundingCorners:UIRectCornerTopRight ImageNamed:@"找电工" MainTitle:@"找电工" ChildTitle:@"电工多，就是任性！" bgColor:MAIN2BGCOLOR Tag:2]];
    [bottomFrame addSubview:[self setFrameView:10 Y:140 byRoundingCorners:UIRectCornerBottomLeft ImageNamed:@"集团电工管理" MainTitle:@"集团电工管理" ChildTitle:@"适用大型企业或专业电力服务企业，帮您轻松管理电工和变配电站" bgColor:MAIN3BGCOLOR Tag:3]];
    [bottomFrame addSubview:[self setFrameView:165 Y:140 byRoundingCorners:UIRectCornerBottomRight ImageNamed:@"电工神器" MainTitle:@"电工神器" ChildTitle:@"e电工操作版，电工偷懒赚钱神器" bgColor:MAIN4BGCOLOR Tag:4]];
    //中间图片
    UIImageView *iconImage=[[UIImageView alloc]initWithFrame:CGRectMake1(140, 115, 40, 40)];
    [iconImage setImage:[UIImage imageNamed:@"tx"]];
    [iconImage setContentMode:UIViewContentModeCenter];
    [bottomFrame addSubview:iconImage];
    
    [self downLoadPicture];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if([[User Instance]isLogin]){
        NSString *cpName=[[User Instance]getCPName];
        //如果企业为空则设置企业
        if([@"" isEqualToString:cpName]){
            [self.navigationController pushViewController:[[EnterpriseNameModifyViewController alloc]init] animated:YES];
        }else{
            UIFont *font=[UIFont systemFontOfSize:15];
            //设定宽度，高度无限高
            CGSize constraintSize = CGSizeMake(FLT_MAX,FLT_MAX);
            //计算实际需要得视图大小
            CGSize labelSize = [cpName sizeWithFont:font constrainedToSize:constraintSize lineBreakMode:NSLineBreakByClipping];
            [bCpName setTitle:cpName forState:UIControlStateNormal];
            bCpName.frame = CGRectMake(0, 0, labelSize.width+23, labelSize.height);
            [bCpName.titleLabel setFont:font];
            [bCpName setImage:[UIImage imageNamed:@"arrowdown"] forState:UIControlStateNormal];
            [bCpName setTitleEdgeInsets:UIEdgeInsetsMake(0, -23, 0, 23)];
            [bCpName setImageEdgeInsets:UIEdgeInsetsMake(0, labelSize.width, 0, -labelSize.width)];
        }
    }
}

- (void)addModel:(NSString*)image Title:(NSString*)title Frame:(UIView*)frame Tag:(NSUInteger)tag X:(CGFloat)x Y:(CGFloat)y
{
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake1(x, y, 80, 90)];
    [button setTitle:title forImage:[UIImage imageNamed:image]];
    [button setTitleColor:TITLECOLOR forState:UIControlStateNormal];
    [button addTarget:self action:@selector(goToMainView1:) forControlEvents:UIControlEventTouchUpInside];
    button.tag=tag;
    [frame addSubview:button];
}

//设置视图的哪个角是圆的
- (UIView*)setFrameView:(CGFloat)x Y:(CGFloat)y byRoundingCorners:(UIRectCorner)corners ImageNamed:(NSString*)imageNamed MainTitle:(NSString*)mt ChildTitle:(NSString*)ct bgColor:(UIColor*)bg Tag:(NSInteger)tag
{
    UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(x,y,145,120)];
    [frame setBackgroundColor:bg];
    frame.tag=tag;
    [frame addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goToMainView:)]];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:frame.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = frame.bounds;
    maskLayer.path = maskPath.CGPath;
    frame.layer.mask = maskLayer;
    UIImageView *iconImage=[[UIImageView alloc]initWithFrame:CGRectMake1(5, 10, 30, 30)];
    [iconImage setImage:[UIImage imageNamed:imageNamed]];
    [iconImage setContentMode:UIViewContentModeCenter];
    [frame addSubview:iconImage];
    
    UILabel *lblTitle=[[UILabel alloc]initWithFrame:CGRectMake1(40,10,100,30)];
    [lblTitle setText:mt];
    [lblTitle setFont:[UIFont systemFontOfSize:18]];
    [lblTitle setTextColor:[UIColor whiteColor]];
    [lblTitle setBackgroundColor:[UIColor clearColor]];
    [lblTitle setNumberOfLines:0];
    [lblTitle setLineBreakMode:NSLineBreakByWordWrapping];
    [frame addSubview:lblTitle];
    
    UILabel *lblDescription=[[UILabel alloc]initWithFrame:CGRectMake1(5,45,135,70)];
    CGRect lblDescriptionFrame = lblDescription.frame;
    CGSize size = [ct sizeWithFont:lblDescription.font constrainedToSize:CGSizeMake(lblDescriptionFrame.size.width, lblDescriptionFrame.size.height)];
    lblDescriptionFrame.size = CGSizeMake(lblDescriptionFrame.size.width, size.height);
    lblDescription.frame = lblDescriptionFrame;
    [lblDescription setText:ct];
    [lblDescription setFont:[UIFont systemFontOfSize:15]];
    [lblDescription setTextColor:[UIColor whiteColor]];
    [lblDescription setBackgroundColor:[UIColor clearColor]];
    [lblDescription setNumberOfLines:0];
    [lblDescription setTextAlignment:NSTextAlignmentLeft];
    [lblDescription setLineBreakMode:NSLineBreakByWordWrapping];
    [frame addSubview:lblDescription];
    return frame;
}

- (void)goToMainView1:(UIButton*)sender
{
    if(![[User Instance]isLogin]){
        [self.navigationController pushViewController:[[LoginViewController alloc]init] animated:YES];
        return;
    }
    NSInteger tag=[sender tag];
    if(tag==1){
        [self.navigationController pushViewController:[[EquipmentMaintainViewController alloc]init] animated:YES];
    }else if(tag==2){
        [self.navigationController pushViewController:[[InspectionManagerViewController alloc]init] animated:YES];
    }else if(tag==3){
        [self.navigationController pushViewController:[[ElectricianManagerViewController alloc]init] animated:YES];
    }else if(tag==4){
        NSString *roleType=[[User Instance]getRoleType];
        //判断用户类型
        if([@"1" isEqualToString:roleType]||[@"2" isEqualToString:roleType]){
            NSString *usedTrms=[[[User Instance]getResultData]objectForKey:@"USED_TRMS"];
            //判断是否为企业自管
            if([@"1" isEqualToString:usedTrms]||[@"2" isEqualToString:usedTrms]){
                //有监测
                UINavigationController *realTimeAlarmViewControllerNAV=[[UINavigationController alloc]initWithRootViewController:[[STWarnComapnyViewController alloc]initWithType:1]];
                realTimeAlarmViewControllerNAV.tabBarItem.image=[UIImage imageNamed:@"bj"];
                realTimeAlarmViewControllerNAV.tabBarItem.title=@"实时报警";
                UINavigationController *historyAlarmViewControllerNav=[[UINavigationController alloc]initWithRootViewController:[[STWarnComapnyViewController alloc]initWithType:2]];
                historyAlarmViewControllerNav.tabBarItem.image=[UIImage imageNamed:@"ls"];
                historyAlarmViewControllerNav.tabBarItem.title=@"历史报警";
                UITabBarController *alarmTableBarController=[[UITabBarController alloc]init];
                [alarmTableBarController setViewControllers:[[NSArray alloc]initWithObjects:
                                                             realTimeAlarmViewControllerNAV,
                                                             historyAlarmViewControllerNav,nil]];
                alarmTableBarController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:alarmTableBarController animated:YES];
            }else{
                //无监测
                WarnComapnyInfoViewController *warnComapnyInfoViewController=[[WarnComapnyInfoViewController alloc]init];
                [warnComapnyInfoViewController setCurrentUrl:currentURL];
                [self.navigationController pushViewController:warnComapnyInfoViewController animated:YES];
                
            }
        }else{
            //无监测
            WarnComapnyInfoViewController *warnComapnyInfoViewController=[[WarnComapnyInfoViewController alloc]init];
            [warnComapnyInfoViewController setCurrentUrl:currentURL];
            [self.navigationController pushViewController:warnComapnyInfoViewController animated:YES];
        }
    }else if(tag==5){
        NSString *roleType=[[User Instance]getRoleType];
        //判断用户类型
        if([@"1" isEqualToString:roleType]||[@"2" isEqualToString:roleType]){
            NSString *usedTrms=[[[User Instance]getResultData]objectForKey:@"USED_TRMS"];
            //判断是否为企业自管
            if([@"1" isEqualToString:usedTrms]||[@"2" isEqualToString:usedTrms]){
                [self.navigationController pushViewController:[[ElectricityTariffViewController alloc]init] animated:YES];
            }else{
                //无监测
                ElectricityContrastViewController *electricityContrastViewController=[[ElectricityContrastViewController alloc]init];
                [electricityContrastViewController setCurrentUrl:currentURL];
                [self.navigationController pushViewController:electricityContrastViewController animated:YES];
            }
        }else{
            //无监测
            ElectricityContrastViewController *electricityContrastViewController=[[ElectricityContrastViewController alloc]init];
            [electricityContrastViewController setCurrentUrl:currentURL];
            [self.navigationController pushViewController:electricityContrastViewController animated:YES];
        }
    }else if(tag==6){
        NSString *roleType=[[User Instance]getRoleType];
        //判断用户类型
        if([@"1" isEqualToString:roleType]||[@"2" isEqualToString:roleType]){
            NSString *usedTrms=[[[User Instance]getResultData]objectForKey:@"USED_TRMS"];
            //判断是否为企业自管
            if([@"1" isEqualToString:usedTrms]||[@"2" isEqualToString:usedTrms]){
                [self.navigationController pushViewController:[[RunOverviewViewController alloc]init] animated:YES];
            }else{
                //无监测
                RunStatusInfoViewController *runStatusInfoViewController=[[RunStatusInfoViewController alloc]init];
                [runStatusInfoViewController setCurrentUrl:currentURL];
                [self.navigationController pushViewController:runStatusInfoViewController animated:YES];
            }
        }else{
            //无监测
            RunStatusInfoViewController *runStatusInfoViewController=[[RunStatusInfoViewController alloc]init];
            [runStatusInfoViewController setCurrentUrl:currentURL];
            [self.navigationController pushViewController:runStatusInfoViewController animated:YES];
        }
    }else if(tag==7){
        NSString *roleType=[[User Instance]getRoleType];
        //判断用户类型
        if([@"1" isEqualToString:roleType]||[@"2" isEqualToString:roleType]){
            NSString *usedTrms=[[[User Instance]getResultData]objectForKey:@"USED_TRMS"];
            //判断是否为企业自管
            if([@"1" isEqualToString:usedTrms]||[@"2" isEqualToString:usedTrms]){
                [self.navigationController pushViewController:[[STBurdenDetailListViewController alloc]init] animated:YES];
            }else{
                //无监测
                BurdenContrastViewController *burdenContrastViewController=[[BurdenContrastViewController alloc]init];
                [burdenContrastViewController setCurrentUrl:currentURL];
                [self.navigationController pushViewController:burdenContrastViewController animated:YES];
            }
        }else{
            //无监测
            BurdenContrastViewController *burdenContrastViewController=[[BurdenContrastViewController alloc]init];
            [burdenContrastViewController setCurrentUrl:currentURL];
            [self.navigationController pushViewController:burdenContrastViewController animated:YES];
        }
    }
}

- (void)goToMainView:(UITapGestureRecognizer*)sender
{
    NSInteger tag=[sender.view tag];
    if(tag==1){
        [self.navigationController pushViewController:[[WBBPDZViewController alloc]init] animated:YES];
    }else if(tag==2){
        if(![[User Instance]isLogin]){
            [self.navigationController pushViewController:[[LoginViewController alloc]init] animated:YES];
            return;
        }
        [self.navigationController pushViewController:[[FindElectricianViewController alloc]init] animated:YES];
    }else if(tag==3){
        [self.navigationController pushViewController:[[JTDGGLViewController alloc]init] animated:YES];
    }else if(tag==4){
        [self.navigationController pushViewController:[[DGSQViewController alloc]init] animated:YES];
    }
}

- (void)switchCpName:(id)sender
{
    [self.navigationController pushViewController:[[MaintainEnterpriseInformationViewController alloc]init] animated:YES];
}

//下载图片
- (void)downLoadPicture
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"2" forKey:@"type"];
    [params setObject:[NSString stringWithFormat:@"%d",TOPIMAGENUM] forKey:@"num"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:DOWNLOADPIC];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest handle:URL_news requestParams:params];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if(reqCode==DOWNLOADPIC){
        NSArray *array=[[response resultJSON]objectForKey:@"FILE_NAMES"];
        if(array==nil){
            return;
        }
        NSString *URL=[[response resultJSON]objectForKey:@"URL"];
        db=[[SQLiteOperate alloc]init];
        [db openDB];
        [db createTable1];
        for(int i=0;i<[array count];i++){
            NSDictionary *data=[array objectAtIndex:i];
            NSString *FILE_URL=[data objectForKey:@"FILE_URL"];
            NSString *FILE_NAME=[data objectForKey:@"FILE_NAME"];
            NSString *sqlQuery = [NSString stringWithFormat:@"SELECT * FROM PIC WHERE URL='%@'",FILE_URL];
            NSMutableArray *indata=[db query1:sqlQuery];
            if([indata count]==0){
                NSString *sql = [NSString stringWithFormat:
                                 @"INSERT INTO PIC (URL,NAME) VALUES ('%@', '%@')",FILE_URL, FILE_NAME];
                if([db execSql:sql]){
                    NSString *DOWN_FILE_NAME=[NSString stringWithFormat:@"%@%@",URL,FILE_NAME];
                    [self AsynchronousDownloadWithUrl:DOWN_FILE_NAME FileName:FILE_NAME];
                }
            }
        }
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
}

- (void)AsynchronousDownloadWithUrl:(NSString *)u FileName:(NSString *)fName
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
    dispatch_async(queue, ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:u]];
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (data) {
                //创建文件管理器
                NSFileManager* fileManager = [NSFileManager defaultManager];
                //获取临时目录
                NSString* tmpDir=NSTemporaryDirectory();
                //更改到待操作的临时目录
                [fileManager changeCurrentDirectoryPath:[tmpDir stringByExpandingTildeInPath]];
                NSString *tmpPath = [tmpDir stringByAppendingPathComponent:fName];
                //创建数据缓冲区
                NSMutableData* writer = [[NSMutableData alloc] init];
                //将字符串添加到缓冲中
                [writer appendData: data];
                //将其他数据添加到缓冲中
                //将缓冲的数据写入到临时文件中
                [writer writeToFile:tmpPath atomically:YES];
                //获取Documents主目录
                NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
                //得到相应的Documents的路径
                NSString* docDir = [paths objectAtIndex:0];
                //更改到待操作的目录下
                [fileManager changeCurrentDirectoryPath:[docDir stringByExpandingTildeInPath]];
                NSString *path = [docDir stringByAppendingPathComponent:fName];
                //把临时下载好的文件移动到主文档目录下
                [fileManager moveItemAtPath:tmpPath toPath:path error:nil];
            }
        });
    });
}


- (void)goForWeb:(id)sender
{
    [self.navigationController pushViewController:[[WebDetailViewController alloc]initWithType:1 Url:nil] animated:YES];
}

@end