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

#define TITLECOLOR  [UIColor colorWithRed:(124/255.0) green:(124/255.0) blue:(124/255.0) alpha:1]
#define LINECOLOR  [UIColor colorWithRed:(230/255.0) green:(230/255.0) blue:(230/255.0) alpha:1]
#define MAIN1BGCOLOR [UIColor colorWithRed:(236/255.0) green:(105/255.0) blue:(62/255.0) alpha:1]
#define MAIN2BGCOLOR [UIColor colorWithRed:(155/255.0) green:(207/255.0) blue:(64/255.0) alpha:1]
#define MAIN3BGCOLOR [UIColor colorWithRed:(90/255.0) green:(170/255.0) blue:(230/255.0) alpha:1]
#define MAIN4BGCOLOR [UIColor colorWithRed:(254/255.0) green:(158/255.0) blue:(25/255.0) alpha:1]

@interface HomeViewController ()

@end

@implementation HomeViewController{
    UIButton *bCpName;
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
    [scrollFrame setContentSize:CGSizeMake1(320, 560)];
    [scrollFrame setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [scrollFrame setBackgroundColor:LINECOLOR];
    [self.view addSubview:scrollFrame];
    //上
    UIView *topFrame=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 100)];
    [topFrame setBackgroundColor:[UIColor whiteColor]];
    [scrollFrame addSubview:topFrame];
    UIImageView *bannerImage=[[UIImageView alloc]initWithFrame:topFrame.bounds];
    [bannerImage setImage:[UIImage imageNamed:@"banner"]];
    [topFrame addSubview:bannerImage];
    //中
    UIView *middleFrame=[[UIView alloc]initWithFrame:CGRectMake1(0,100, 320, 180)];
    [middleFrame setBackgroundColor:[UIColor whiteColor]];
    [scrollFrame addSubview:middleFrame];
    [self addModel:@"企业设备维护" Title:@"设备维护" Frame:middleFrame Tag:1 X:0 Y:0];
    [self addModel:@"巡检任务管理" Title:@"巡检任务" Frame:middleFrame Tag:2 X:80 Y:0];
    [self addModel:@"企业电工管理" Title:@"企业电工" Frame:middleFrame Tag:3 X:160 Y:0];
    [self addModel:@"报警信息" Title:@"报警信息" Frame:middleFrame Tag:4 X:0 Y:90];
    [self addModel:@"电量电费" Title:@"电量电费" Frame:middleFrame Tag:5 X:80 Y:90];
    [self addModel:@"运行状态" Title:@"运行状态" Frame:middleFrame Tag:6 X:160 Y:90];
    [self addModel:@"企业负荷" Title:@"企业负荷" Frame:middleFrame Tag:7 X:240 Y:90];
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
    UIView *bottomFrame=[[UIView alloc]initWithFrame:CGRectMake1(0,290, 320, 270)];
    [bottomFrame setBackgroundColor:[UIColor whiteColor]];
    [scrollFrame addSubview:bottomFrame];
    [bottomFrame addSubview:[self setFrameView:10 Y:10 byRoundingCorners:UIRectCornerTopLeft ImageNamed:@"外包变配电站" MainTitle:@"外包变配电站" ChildTitle:@"让您省心、放心；享受更专业，更经济的服务" bgColor:MAIN1BGCOLOR Tag:1]];
    [bottomFrame addSubview:[self setFrameView:165 Y:10 byRoundingCorners:UIRectCornerTopRight ImageNamed:@"找电工" MainTitle:@"找电工" ChildTitle:@"电工多，就是任性！" bgColor:MAIN2BGCOLOR Tag:2]];
    [bottomFrame addSubview:[self setFrameView:10 Y:140 byRoundingCorners:UIRectCornerBottomLeft ImageNamed:@"集团电工管理" MainTitle:@"集团电工管理" ChildTitle:@"适用大型企业或专业电力服务企业，帮您轻松管理电工和变配电站" bgColor:MAIN3BGCOLOR Tag:3]];
    [bottomFrame addSubview:[self setFrameView:165 Y:140 byRoundingCorners:UIRectCornerBottomRight ImageNamed:@"电工神器" MainTitle:@"电工神器" ChildTitle:@"e电工操作版，电工偷懒赚钱神器" bgColor:MAIN4BGCOLOR Tag:4]];
    //中间图片
    UIImageView *iconImage=[[UIImageView alloc]initWithFrame:CGRectMake1(140, 115, 40, 40)];
    [iconImage setImage:[UIImage imageNamed:@"autocrane_o"]];
    [iconImage setContentMode:UIViewContentModeCenter];
    [bottomFrame addSubview:iconImage];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if([[User Instance]isLogin]){
        NSString *cpName=[[[User Instance]getResultData] objectForKey:@"CP_NAME"];
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
            bCpName.frame = CGRectMake(0, 0, labelSize.width, labelSize.height);
            [bCpName.titleLabel setFont:font];
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
    NSInteger tag=[sender tag];
    if(tag==1){
        [self.navigationController pushViewController:[[EquipmentMaintainViewController alloc]init] animated:YES];
    }else if(tag==2){
        [self.navigationController pushViewController:[[InspectionManagerViewController alloc]init] animated:YES];
    }else if(tag==3){
        [self.navigationController pushViewController:[[ElectricianManagerViewController alloc]init] animated:YES];
    }else if(tag==4){
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
    }else if(tag==5){
        NSLog(@"电量电费");
    }else if(tag==6){
        NSLog(@"运行状态");
    }else if(tag==7){
        [self.navigationController pushViewController:[[STBurdenDetailListViewController alloc]init] animated:YES];
    }
}

- (void)goToMainView:(UITapGestureRecognizer*)sender
{
    NSInteger tag=[sender.view tag];
    if(tag==1){
        [self.navigationController pushViewController:[[WBBPDZViewController alloc]init] animated:YES];
    }else if(tag==2){
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

@end
