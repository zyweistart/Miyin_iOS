//
//  MenuItemView.m
//  BBQ
//
//  Created by Start on 15/7/29.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "MenuItemView.h"
#import "TabBarFrameViewController.h"

@implementation MenuItemView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if(self.scale==0){
            self.scale=1;
        }
        [self setBackgroundColor:DEFAULTITLECOLORRGB(65, 51, 42)];
        self.frameView=[[UIView alloc]initWithFrame:CGRectMake1(0, 5*self.scale, 315*self.scale, 180*self.scale)];
        self.frameView.layer.masksToBounds=YES;
        self.frameView.layer.cornerRadius=CGWidth(5*self.scale);
        self.frameView.layer.borderWidth=1*self.scale;
        self.frameView.layer.borderColor=DEFAULTITLECOLOR(200).CGColor;
        [self.frameView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.frameView];
        
        UIView *titleView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 40*self.scale, 180*self.scale)];
        [titleView setBackgroundColor:DEFAULTITLECOLORRGB(242, 125, 0)];
        [self.frameView addSubview:titleView];
        self.lblTitle=[[UILabel alloc]initWithFrame:CGRectMake1(0, 70*self.scale, 40*self.scale, 40*self.scale)];
        [self.lblTitle setTextColor:[UIColor whiteColor]];
        [self.lblTitle setFont:[UIFont systemFontOfSize:18*self.scale]];
        [self.lblTitle setTextAlignment:NSTextAlignmentCenter];
        [self.lblTitle setBackgroundColor:[UIColor clearColor]];
        [titleView addSubview:self.lblTitle];
        CGAffineTransform at =CGAffineTransformMakeRotation(-M_PI/2);
        [self.lblTitle setTransform:at];
        
        self.lblCurrentSamllCentigrade=[[UIButton alloc]initWithFrame:CGRectMake1(60*self.scale, 5*self.scale, 60*self.scale, 20*self.scale)];
        [self.lblCurrentSamllCentigrade setTitleColor:DEFAULTITLECOLORRGB(242, 125, 0) forState:UIControlStateNormal];
        [self.lblCurrentSamllCentigrade setImage:[UIImage imageNamed:@"指针"] forState:UIControlStateNormal];
        [self.lblCurrentSamllCentigrade setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [self.lblCurrentSamllCentigrade.titleLabel setFont:[UIFont systemFontOfSize:14*self.scale]];
        [self.lblCurrentSamllCentigrade setImageEdgeInsets:UIEdgeInsetsMake(0, -2*self.scale, 0, 0)];
        [self.frameView addSubview:self.lblCurrentSamllCentigrade];
        
        self.lineViewFrame=[[UIView alloc]initWithFrame:CGRectMake1(60*self.scale, 30*self.scale, 209*self.scale, 20*self.scale)];
        [self.lineViewFrame setBackgroundColor:DEFAULTITLECOLOR(188)];
        [self.frameView addSubview:self.lineViewFrame];
        
        self.viewCentigrade=[[UIView alloc]initWithFrame:CGRectMake1(2*self.scale, 2*self.scale, 150*self.scale, 16*self.scale)];
        [self.viewCentigrade setBackgroundColor:[UIColor redColor]];
        [self.lineViewFrame addSubview:self.viewCentigrade];
        
        self.lblCurrent=[[CLabel alloc]initWithFrame:CGRectMake1(50*self.scale, 80*self.scale, 60*self.scale, 20*self.scale) Text:LOCALIZATION(@"Current")];
        [self.lblCurrent setFont:[UIFont systemFontOfSize:15*self.scale]];
        [self.frameView addSubview:self.lblCurrent];
        self.lblCurrentTemp=[[CLabel alloc]initWithFrame:CGRectMake1(50*self.scale, 100*self.scale, 50*self.scale, 20*self.scale) Text:LOCALIZATION(@"Temp")];
        [self.lblCurrentTemp setFont:[UIFont systemFontOfSize:15*self.scale]];
        [self.frameView addSubview:self.lblCurrentTemp];
        
        self.lblCurrentCentigrade=[[UILabel alloc]initWithFrame:CGRectMake1(100*self.scale, 80*self.scale, 100*self.scale, 40*self.scale)];
        [self.lblCurrentCentigrade setTextColor:DEFAULTITLECOLORRGB(242,125,0)];
        [self.lblCurrentCentigrade setFont:[UIFont systemFontOfSize:35*self.scale]];
        [self.lblCurrentCentigrade setTextAlignment:NSTextAlignmentCenter];
        [self.frameView addSubview:self.lblCurrentCentigrade];
        
        self.lineView=[[UIView alloc]initWithFrame:CGRectMake1(45*self.scale, 125*self.scale, 155*self.scale, 1*self.scale)];
        [self.lineView setBackgroundColor:DEFAULTITLECOLOR(160)];
        [self.frameView addSubview:self.lineView];
        self.lblSet=[[CLabel alloc]initWithFrame:CGRectMake1(50*self.scale, 130*self.scale, 50*self.scale, 20*self.scale) Text:LOCALIZATION(@"Set")];
        [self.lblSet setFont:[UIFont systemFontOfSize:15*self.scale]];
        [self.frameView addSubview:self.lblSet];
        self.lblSetTemp=[[CLabel alloc]initWithFrame:CGRectMake1(50*self.scale, 150*self.scale, 50*self.scale, 20*self.scale) Text:LOCALIZATION(@"Temp")];
        [self.lblSetTemp setFont:[UIFont systemFontOfSize:15*self.scale]];
        [self.frameView addSubview:self.lblSetTemp];
        
        self.lblHighestCentigrade=[[UIButton alloc]initWithFrame:CGRectMake1(120*self.scale, 135*self.scale, 80*self.scale, 30*self.scale)];
        self.lblHighestCentigrade.layer.cornerRadius=CGWidth(15*self.scale);
        self.lblHighestCentigrade.layer.masksToBounds=YES;
        self.lblHighestCentigrade.layer.borderWidth=2;
        self.lblHighestCentigrade.layer.borderColor=DEFAULTITLECOLORRGB(137, 140, 255).CGColor;
//        self.lblHighestCentigrade.layer.shadowColor = DEFAULTITLECOLORRGB(137, 140, 255).CGColor;
//        self.lblHighestCentigrade.layer.shadowOffset = CGSizeMake(0, 1);
//        self.lblHighestCentigrade.layer.shadowOpacity = 0.5;
        [self.lblHighestCentigrade.titleLabel setFont:[UIFont systemFontOfSize:25*self.scale]];
        [self.lblHighestCentigrade setTitleColor:DEFAULTITLECOLOR(100) forState:UIControlStateNormal];
        [self.frameView addSubview:self.lblHighestCentigrade];
        
        self.bTimer=[[UIButton alloc]initWithFrame:CGRectMake1(235*self.scale, 77*self.scale, 46*self.scale, 52*self.scale)];
        [self.frameView addSubview:self.bTimer];
        self.lblSetTime=[[UILabel alloc]initWithFrame:CGRectMake1(220*self.scale, 135*self.scale, 80*self.scale, 30*self.scale)];
        self.lblSetTime.layer.cornerRadius=CGWidth(15*self.scale);
        self.lblSetTime.layer.masksToBounds=YES;
        self.lblSetTime.layer.borderWidth=2;
        self.lblSetTime.layer.borderColor=DEFAULTITLECOLORRGB(137, 140, 255).CGColor;
//        self.lblSetTime.layer.shadowColor = DEFAULTITLECOLORRGB(137, 140, 255).CGColor;
//        self.lblSetTime.layer.shadowOffset = CGSizeMake(1, 1);
//        self.lblSetTime.layer.shadowOpacity = 0.5;
        [self.lblSetTime setTextColor:DEFAULTITLECOLOR(41)];
        [self.lblSetTime setFont:[UIFont systemFontOfSize:18*self.scale]];
        [self.lblSetTime setTextAlignment:NSTextAlignmentCenter];
        [self.frameView addSubview:self.lblSetTime];
    }
    return self;
}

- (void)setLanguage
{
    [self.lblCurrent setText:LOCALIZATION(@"Current")];
    [self.lblCurrentTemp setText:LOCALIZATION(@"Temp")];
    [self.lblSet setText:LOCALIZATION(@"Set")];
    [self.lblSetTemp setText:LOCALIZATION(@"Temp")];
}

- (void)setMenuData:(NSDictionary*)data
{
    if(data!=nil){
        self.currentData=data;
        [self refreshData];
    }
}

- (void)refreshData
{
    for(id k in [self.currentData allKeys]){
        NSString *key=[NSString stringWithFormat:@"%@",k];
        if([key isEqualToString:self.currentKey]){
            [self showTimerString:self.currentKey];
        }else{
            self.currentKey=key;
            //掉电保存
            [self setTimerScheduled];
        }
        NSString *oldValue1=[self.currentData objectForKey:self.currentKey];
        CGFloat currentValue1=[oldValue1 floatValue]+DECIMALPOINT;
        NSString *centigrade=[NSString stringWithFormat:@"%lf",currentValue1];
        
        int currentValue=[centigrade intValue];
        [self.lblTitle setText:self.currentKey];
        [self.lblCurrentCentigrade setText:[Data getTemperatureValue:oldValue1]];
        [self.lblCurrentSamllCentigrade setTitle:[Data getTemperatureValue:oldValue1] forState:UIControlStateNormal];
        
        //默认值
        int currentHighValue=0;
        
        NSString *oldValue=[[[Data Instance] sett] objectForKey:self.currentKey];
        CGFloat value1=[oldValue floatValue]+DECIMALPOINT;
        NSString *value=[NSString stringWithFormat:@"%lf",value1];
        if(value){
            currentHighValue=[value intValue];
        }
        [self.lblHighestCentigrade setTitle:[Data getTemperatureValue:oldValue] forState:UIControlStateNormal];
        
        CGFloat hWidth=205;
        CGFloat width=hWidth/currentHighValue*currentValue;
        if(width>hWidth){
            width=hWidth;
        }
        if(width<=0){
            width=0;
        }
        [self.lblCurrentSamllCentigrade setFrame:CGRectMake1((60+width)*self.scale, 5*self.scale, 60*self.scale, 20*self.scale)];
        [self.viewCentigrade setFrame:CGRectMake1(2*self.scale, 2*self.scale, width*self.scale, 16*self.scale)];
    }
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
            self.mTimer=[NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
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
        int currentValue=[min intValue]-1;
        [[[Data Instance]settValue]setObject:[NSString stringWithFormat:@"%d",currentValue] forKey:key];
        [self showTimerString:key];
        if(currentValue<=0){
            [self.mTimer invalidate];
            self.mTimer=nil;
            TabBarFrameViewController *tbf=(TabBarFrameViewController*)self.baseController.tabBarController;
            if(![tbf playAlarm]){
                [tbf senderNotification:LOCALIZATION(@"Timer is finished!")];
            }
            [tbf.mAlertView.lblTitle setText:[NSString stringWithFormat:@"%@-%@",key,LOCALIZATION(@"Warning")]];
            [tbf.mAlertView.lblMessage setText:LOCALIZATION(@"Timer is finished!")];
            [tbf.mAlertView setType:1];
            [tbf AlertShow];
            AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
            NSString *json=[NSString stringWithFormat:@"{\"alarm\":\"%@\"}",key];
            [appDelegate sendData:json];
        }else{
//            if(self.mTimer){
//                [self.mTimer invalidate];
//                self.mTimer=nil;
//            }
        }
        break;
    }
}

- (void)showTimerString:(NSString*)key
{
    NSString *timer=[[[Data Instance]settValue]objectForKey:key];
    int tv=[timer intValue];
    if(tv>0){
        [self.bTimer setImage:[UIImage imageNamed:@"时间_s"] forState:UIControlStateNormal];
        int hour=tv/60;
        NSString *hstr=[NSString stringWithFormat:@"0%d",hour];
        if(hour>9){
            hstr=[NSString stringWithFormat:@"%d",hour];
        }
        int min=tv%60;
        NSString *mstr=[NSString stringWithFormat:@"0%d",min];
        if(min>9){
            mstr=[NSString stringWithFormat:@"%d",min];
        }
        [self.lblSetTime setText:[NSString stringWithFormat:@"%@:%@",hstr,mstr]];
    }else{
        [self.bTimer setImage:[UIImage imageNamed:@"时间_n"] forState:UIControlStateNormal];
        [self.lblSetTime setText:@"00:00"];
    }
}

- (void)closeAll
{
    if(self.mTimer){
        [self.mTimer invalidate];
        self.mTimer=nil;
    }
}

@end