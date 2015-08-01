//
//  MenuItemLandView.m
//  BBQ
//
//  Created by Start on 15/7/30.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "MenuItemLandView.h"

@implementation MenuItemLandView

- (id)initWithFrame:(CGRect)frame
{
    self.scale=1.4;
    self=[super initWithFrame:frame];
    if(self){
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)setTimerScheduled
{
    for(id k in [self.currentData allKeys]){
        NSString *key=[NSString stringWithFormat:@"%@",k];
        NSString *timer=[[[Data Instance]settValue]objectForKey:key];
        int tv=[timer intValue];
        [self showTimerString:key];
        if(tv>0){
            if(self.mTimer){
                [self.mTimer invalidate];
                self.mTimer=nil;
            }
            self.mTimer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
        }else{
            if(self.mTimer){
                [self.mTimer invalidate];
                self.mTimer=nil;
            }
        }
    }
}

- (void)updateTimer
{
    for(id key in [self.currentData allKeys]){
        NSString *min=[[[Data Instance]settValue]objectForKey:key];
        [self showTimerString:key];
        if([min intValue]<=0){
            [self.mTimer invalidate];
            self.mTimer=nil;
        }
        break;
    }
}

@end