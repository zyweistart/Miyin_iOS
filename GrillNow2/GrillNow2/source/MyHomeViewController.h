//
//  MyHomeViewController.h
//  GrillNow2
//
//  Created by JWD on 15/5/3.
//  Copyright (c) 2015年 com.efancy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FootTemperatureList.h"
#import "AudioToolbox/AudioToolbox.h"
#import "AVFoundation/AVAudioPlayer.h"
#import "GNAlertView.h"
#import "DataCenter.h"
//#import "P1FoodModer.h"
//#import "P2FoodModer.h"

@interface MyHomeViewController : UIViewController <GNAlertViewDelegate,UIAlertViewDelegate>
{
    SystemSoundID soundID;
    UIAlertView * alertTemp;
    UIAlertView * alertTimer;
    FootTemperatureList* list;
    AVAudioPlayer* player;
    
    int CompareTargetTimeDuring;
    
    int8_t testValue ;
    
    int lastAlertTime ;
    FoodType* currentFood;
    
    NSString *_resultStr; // 字符串截取
     NSString *_resultStr2;
    int isP1;
    int _ppt;
}

// 背景图片
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIButton *notNumber;
@property (weak, nonatomic) IBOutlet UIButton *refreshButton;
@property (weak, nonatomic) IBOutlet UIButton *wirelessButton;
@property (weak, nonatomic) IBOutlet UIButton *electricityButton;

@property (weak, nonatomic) IBOutlet UIView *P1View;
@property (weak, nonatomic) IBOutlet UIView *P2View;
@property (weak, nonatomic) IBOutlet UIView *foodView;
@property (weak, nonatomic) IBOutlet UIView *threeButton;
@property (weak, nonatomic) IBOutlet UIView *p1FourLabel;
@property (weak, nonatomic) IBOutlet UIView *p2FourLabel;

@property (weak, nonatomic) IBOutlet UILabel *P1SetT; 
@property (weak, nonatomic) IBOutlet UILabel *P1setTName;
@property (weak, nonatomic) IBOutlet UILabel *P1FoodName;
@property (weak, nonatomic) IBOutlet UIButton *P1TP; // 插针温度按钮
@property (weak, nonatomic) IBOutlet UILabel *P1TPLabel; // 插针温度显示

@property (weak, nonatomic) IBOutlet UILabel *P2SetT;
@property (weak, nonatomic) IBOutlet UILabel *P2SetTName;
@property (weak, nonatomic) IBOutlet UILabel *P2FoodName;
@property (weak, nonatomic) IBOutlet UIButton *P2TP;
@property (weak, nonatomic) IBOutlet UILabel *P2TPLabel;
@property (weak, nonatomic) IBOutlet UIView *p2RedView;

@property (weak, nonatomic) IBOutlet UILabel *foodHint;
@property (weak, nonatomic) IBOutlet UIButton *foodNameButton;
@property (weak, nonatomic) IBOutlet UIButton *foodSetTButton;
@property (weak, nonatomic) IBOutlet UILabel *foodSetTNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *foodNameShow;
@property (weak, nonatomic) IBOutlet UILabel *showTNumber;
@property (weak, nonatomic) IBOutlet UIImageView *p1Image;
@property (weak, nonatomic) IBOutlet UIImageView *p2Image;

@property (nonatomic,assign) BOOL isFoodView; // 记录foodView的出现

@property (nonatomic,strong) NSMutableDictionary *P1FoodDictionary; // 保存p1的食物数据的数组
@property (nonatomic,strong) NSMutableDictionary *p2FoodDictionary;
@property (nonatomic,assign) int isP1orP2; // 判断是p1还是p2

@property (nonatomic,copy) NSString *p1TNum;
@property (nonatomic,copy) NSString *p2TNum;
@property (nonatomic,assign) BOOL isOK; // 报警
@property (nonatomic,assign) BOOL isOK2; // 报警
@property (nonatomic,assign) float p1T;
@property (nonatomic,assign) float p2T;
@property (nonatomic,assign) CGFloat p1ViewY; // 保存p1的framY
@property (nonatomic,assign) CGFloat foodViewY; // 食物view的framY
@property (nonatomic,assign) CGFloat p2ViewY; // 保存p2的framY
@property (nonatomic,assign) int isDemo;
//@property (nonatomic,assign) int isNotification;// 判断是否在后台

- (IBAction)refreshButtonChange; // 刷新
- (IBAction)electricityButtonChange;  // 电量
- (IBAction)P1TPChange; // 点击温度弹出View
- (IBAction)P2TPChange;
- (IBAction)foodName; // 食物界面事件
- (IBAction)foodSetT; // 食物温度


@end
