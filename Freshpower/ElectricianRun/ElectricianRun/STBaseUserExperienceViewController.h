//
//  STBaseUserExperienceViewController.h
//  ElectricianRun
//
//  Created by Start on 2/28/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DISPLAYLINESTR @"ia=%.2f;\nib=%.2f;\nic=%.2f;"

//保存每条进出线开关的状态
bool finalB[8];
//保存母联开关的状态
bool finalB9;
//保存最近12个每条进出线的电流IA、IB、IC的值
double allPhaseCurrentList[12][2][4][3];
//保存最近12个每条进出线的负荷数
double allTotalBurden[12][2][4];
//保存最近12个每条进出线的电量
double allTotalElectricity[12][2][4];
//保存最近12个每条进出线的电费
double allTotalElectricityVal[12][2][4];
double threePhaseCurrentLeft[4][3];
double threePhaseCurrentRight[4][3];

int allPhaseCurrentListCount;
int allTotalElectricityCount;

@interface STBaseUserExperienceViewController : UIViewController<UIAlertViewDelegate,UIActionSheetDelegate>

//当前负荷
@property (strong, nonatomic) UILabel *lblCurrentLoad;
//当前总电量
@property (strong, nonatomic) UILabel *lblElectricity;
//进线A值
@property (strong, nonatomic) UILabel *lblInLineAValue;
//进线A
@property (strong, nonatomic) UIButton *btnInLineA;
//出线A-1值
@property (strong, nonatomic) UILabel *lblOutLineA1Value;
//进线A-1
@property (strong, nonatomic) UIButton *btnOutLineA1;
//出线A-2值
@property (strong, nonatomic) UILabel *lblOutLineA2Value;
//进线A-2
@property (strong, nonatomic) UIButton *btnOutLineA2;
//出线A-3值
@property (strong, nonatomic) UILabel *lblOutLineA3Value;
//进线A-3
@property (strong, nonatomic) UIButton *btnOutLineA3;
//出线B值
@property (strong, nonatomic) UILabel *lblInLineBValue;
//进线B
@property (strong, nonatomic) UIButton *btnInLineB;
//出线B-1值
@property (strong, nonatomic) UILabel *lblOutLineB1Value;
//进线B-1
@property (strong, nonatomic) UIButton *btnOutLineB1;
//出线B-2值
@property (strong, nonatomic) UILabel *lblOutLineB2Value;
//进线B-2
@property (strong, nonatomic) UIButton *btnOutLineB2;
//出线B-3值
@property (strong, nonatomic) UILabel *lblOutLineB3Value;
//进线B-3
@property (strong, nonatomic) UIButton *btnOutLineB3;
//母联开关
@property (strong, nonatomic) UIButton *btnMotherOf;

@property (strong, nonatomic) UIScrollView *control;

@property (strong,nonatomic) UIButton *btnSignup;

@property NSTimer * timer;
@property NSTimer * timerElectricity;
//最后一次进线A的值
@property double iaTempLastValue;
//最后一次负荷
@property double lastTotalBurden;
//当前负荷
@property double currentTotalBurden;
//总电量
@property double currentTotalElectricity;//是否为超负荷体验
@property bool isTransLoad;
@property double electricCurrentLeftA;
@property double electricCurrentLeftB;
@property double electricCurrentLeftC;
@property double electricCurrentRightA;
@property double electricCurrentRightB;
@property double electricCurrentRightC;

//后退
- (void)back:(id)sender;
//生成一个0～1之间的随机数小数点后保留两位
- (double)random;
// 计算当前时间的商业电价
+ (double)businessCalculationTime;
- (void)startBusinessCal;
- (void)startCalculate;
- (void)buildCal;
- (void)totalElectricity;
//显示当前的电流
- (void)displayElectricCurrent;
//显示开关的状态
- (void)displaySwitchStatus;
//进出线电流开关
- (void)onClickSwitch:(id)sender;
//电流详细信息
- (void)onClickLoadDetail:(id)sender;
- (void)onClickSignup:(id)sender;

@end
