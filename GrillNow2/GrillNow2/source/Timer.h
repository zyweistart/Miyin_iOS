//
//  Timer.h
//  Grill Now
//
//  Created by Yang Shubo on 14-3-6.
//  Copyright (c) 2014年 Yang Shubo. All rights reserved.
//

#import <Foundation/Foundation.h>
#define MSG_TIMER_TICK @"MSG_TIMER_TICK"
#define MSG_TIMER_FINISH @"MSG_TIMER_FINISH"
@interface Timer : NSObject
{
    NSTimer* timer;
    BOOL isPaused;
}
@property(nonatomic,strong)NSString* Name;
@property(nonatomic)int during;
@property(nonatomic)BOOL isEnable;
@property(nonatomic)int currentDuring;

-(id)init;
-(id)initWithDuring:(int)during;
-(void)dispose;

-(void)pause;
-(void)stop;
-(void)start;


-(int)GetMinute;
-(int)GetSecond;
-(int)GetHour;




@end


