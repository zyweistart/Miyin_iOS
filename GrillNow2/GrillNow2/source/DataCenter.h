//
//  DataCenter.h
//  Graff Now
//
//  Created by Yang Shubo on 13-8-27.
//  Copyright (c) 2013年 Yang Shubo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FoodType.h"
#import "Device.h"
#import "AlarmRing.h" 
#import "Timer.h"

#define MSG_ONTARGETTEMP @"MSG_ON_TARGET_TEMP"

@interface DataCenter : NSObject
{
    
}

+(DataCenter*)getInstance;

@property(atomic,strong)FoodType* CurrentFood;
@property(nonatomic,strong)NSMutableArray* FoodList;
@property(nonatomic)BOOL IsC;
@property(atomic,strong)Device* CurrentDevice;
@property(nonatomic)int Temperature;

@property(nonatomic,strong)NSMutableArray* AlarmRingList;
@property(nonatomic,strong)AlarmRing* TemperatureAlarm;
@property(nonatomic,strong)AlarmRing* TimerAlarm;

@property(nonatomic,strong)NSString* CurrentTempName;
@property(nonatomic)float CurrentTempTarget;

@property(nonatomic)id MainMenu;

@property(nonatomic,strong)NSMutableArray* TimerList;

@property (nonatomic,copy) NSString *myFoodName;

-(float)GetTemperature;

-(float)ConvertC2F:(float)C;

- (float)CConvertF:(float)F;
- (float)FConvertC:(float)C;

-(void)LoadInnerSetTemp;

-(void)LoadCustomTemp;
-(void)AddCustomTemp:(FoodType*) food;
-(void)ModifyCustomTemp:(FoodType*)food;
-(void)RemoveCustomTemp:(FoodType*) food;

@end
