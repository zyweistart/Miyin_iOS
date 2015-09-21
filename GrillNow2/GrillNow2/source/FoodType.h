//
//  FoodType.h
//  Graff Now
//
//  Created by Yang Shubo on 13-8-27.
//  Copyright (c) 2013年 Yang Shubo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodType : NSObject
{
    
}
@property(nonatomic,strong)NSString* Id;
@property(nonatomic,strong)NSString* icoImageName;
@property(nonatomic,strong)NSString* FoodName;
@property(nonatomic)float MaxTemperature;

@property(nonatomic)float Rare;
@property(nonatomic)float MedRare;
@property(nonatomic)float Medium;
@property(nonatomic)float Welldone    ;

@property(nonatomic)int CookTime;

// 标记是不是自定义食物
@property (nonatomic,assign) int isNotMyFood;
@end
