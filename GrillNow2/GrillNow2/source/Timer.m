//
//  Timer.m
//  Grill Now
//
//  Created by Yang Shubo on 14-3-6.
//  Copyright (c) 2014年 Yang Shubo. All rights reserved.
//

#import "Timer.h"

@implementation Timer

-(id)init
{
    isPaused=NO;
    self.isEnable = NO;
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimerCB) userInfo:nil repeats:YES];
    [timer fire];
    return [super init];
}
-(id)initWithDuring:(int)during
{
    self.during = during;
    self.currentDuring = 0;
    return [self init];
}
-(void)onTimerCB
{
    if(!self.isEnable)
        return;
    if(isPaused)
        return;
    
    if(self.currentDuring>=self.during)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:MSG_TIMER_FINISH object:self];

    }
    else
    {
        self.currentDuring++;
        [[NSNotificationCenter defaultCenter] postNotificationName:MSG_TIMER_TICK object:self];
    }
}
-(void)dispose
{
    [timer invalidate];
    timer = nil;
}
-(void)pause
{
    isPaused= YES;
    self.isEnable = NO;
}
-(void)start
{
    isPaused = NO;
    self.isEnable = YES;
}
-(void)stop
{
    self.isEnable = NO;
    self.currentDuring = 0;
}

-(int)GetMinute
{
    return ((_during / 60) % 60);
}
-(int)GetSecond
{
    return _during % 60;
}
-(int)GetHour
{
    return _during / 3600;
}

@end
