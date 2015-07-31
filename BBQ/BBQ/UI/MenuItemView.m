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
        [self setBackgroundColor:DEFAULTITLECOLORRGB(65, 51, 42)];
        self.frameView=[[UIView alloc]initWithFrame:CGRectMake1(0, 5, 315, 180)];
        self.frameView.layer.masksToBounds=YES;
        self.frameView.layer.cornerRadius=CGWidth(5);
        self.frameView.layer.borderWidth=1;
        self.frameView.layer.borderColor=DEFAULTITLECOLOR(200).CGColor;
        [self.frameView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.frameView];
        
        self.lblTitle=[[UILabel alloc]initWithFrame:CGRectMake1(0, 0, 40, 180)];
        [self.lblTitle setTextColor:[UIColor whiteColor]];
        [self.lblTitle setFont:[UIFont systemFontOfSize:18]];
        [self.lblTitle setBackgroundColor:DEFAULTITLECOLORRGB(242, 125, 0)];
        [self.lblTitle setTextAlignment:NSTextAlignmentCenter];
        [self.frameView addSubview:self.lblTitle];
        
        self.lblCurrentSamllCentigrade=[[UIButton alloc]initWithFrame:CGRectMake1(60, 5, 60, 20)];
        [self.lblCurrentSamllCentigrade setTitleColor:DEFAULTITLECOLORRGB(242, 125, 0) forState:UIControlStateNormal];
        [self.lblCurrentSamllCentigrade setImage:[UIImage imageNamed:@"指针"] forState:UIControlStateNormal];
        [self.lblCurrentSamllCentigrade setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
        [self.frameView addSubview:self.lblCurrentSamllCentigrade];
        
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake1(60, 30, 224, 20)];
        [lineView setBackgroundColor:DEFAULTITLECOLOR(188)];
        [self.frameView addSubview:lineView];
        
        self.viewCentigrade=[[UIView alloc]initWithFrame:CGRectMake1(2, 2, 150, 16)];
        [self.viewCentigrade setBackgroundColor:[UIColor redColor]];
        [lineView addSubview:self.viewCentigrade];
        
        CLabel *lbl=[[CLabel alloc]initWithFrame:CGRectMake1(50, 80, 60, 20) Text:NSLocalizedString(@"Current",nil)];
        [lbl setFont:[UIFont systemFontOfSize:15]];
        [self.frameView addSubview:lbl];
        lbl=[[CLabel alloc]initWithFrame:CGRectMake1(50, 100, 50, 20) Text:NSLocalizedString(@"Temp",nil)];
        [lbl setFont:[UIFont systemFontOfSize:15]];
        [self.frameView addSubview:lbl];
        
        self.lblCurrentCentigrade=[[UILabel alloc]initWithFrame:CGRectMake1(100, 80, 100, 40)];
        [self.lblCurrentCentigrade setTextColor:DEFAULTITLECOLORRGB(242, 125, 0)];
        [self.lblCurrentCentigrade setFont:[UIFont systemFontOfSize:35]];
        [self.lblCurrentCentigrade setTextAlignment:NSTextAlignmentCenter];
        [self.frameView addSubview:self.lblCurrentCentigrade];
        
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake1(45, 125, 155, 1)];
        [line setBackgroundColor:DEFAULTITLECOLOR(160)];
        [self.frameView addSubview:line];
        lbl=[[CLabel alloc]initWithFrame:CGRectMake1(50, 130, 50, 20) Text:NSLocalizedString(@"Set",nil)];
        [self.frameView addSubview:lbl];
        lbl=[[CLabel alloc]initWithFrame:CGRectMake1(50, 150, 50, 20) Text:NSLocalizedString(@"Temp",nil)];
        [self.frameView addSubview:lbl];
        
        self.lblHighestCentigrade=[[UIButton alloc]initWithFrame:CGRectMake1(100, 130, 100, 40)];
        [self.lblHighestCentigrade.titleLabel setFont:[UIFont systemFontOfSize:30]];
        [self.lblHighestCentigrade setTitleColor:DEFAULTITLECOLOR(100) forState:UIControlStateNormal];
        [self.frameView addSubview:self.lblHighestCentigrade];
        
        self.bTimer=[[UIButton alloc]initWithFrame:CGRectMake1(202, 97, 46, 52)];
        [self.bTimer setImage:[UIImage imageNamed:@"时间"] forState:UIControlStateNormal];
        [self.frameView addSubview:self.bTimer];
        
        self.lblSetTime=[[UILabel alloc]initWithFrame:CGRectMake1(250, 97, 60, 52)];
        [self.lblSetTime setTextColor:DEFAULTITLECOLOR(41)];
        [self.lblSetTime setFont:[UIFont systemFontOfSize:18]];
        [self.lblSetTime setTextAlignment:NSTextAlignmentCenter];
        [self.frameView addSubview:self.lblSetTime];
    }
    return self;
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
        NSString *centigrade=[NSString stringWithFormat:@"%@",[self.currentData objectForKey:key]];
        
        int currentValue=[centigrade intValue];
        [self.lblTitle setText:key];
        
        [self.lblCurrentCentigrade setText:[Data getTemperatureValue:currentValue]];
        [self.lblCurrentSamllCentigrade setTitle:[Data getTemperatureValue:currentValue] forState:UIControlStateNormal];
        
        //默认值
        int currentHighValue=0;
        
        NSString *value=[[[Data Instance] sett] objectForKey:key];
        if(value){
            currentHighValue=[value intValue];
        }
        [self.lblHighestCentigrade setTitle:[Data getTemperatureValue:currentHighValue] forState:UIControlStateNormal];
        
        CGFloat hWidth=220;
        CGFloat width=hWidth/currentHighValue*currentValue;
        if(width>hWidth){
            width=hWidth;
        }
        [self.lblCurrentSamllCentigrade setFrame:CGRectMake1(55+width, 5, 60, 20)];
        [self.viewCentigrade setFrame:CGRectMake1(2, 2, width, 16)];
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
            if(self.mTimer==nil){
                self.mTimer=[NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
            }
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
            [tbf playAlarm];
            [tbf.mAlertView.lblTitle setText:[NSString stringWithFormat:@"%@-Warning",key]];
            [tbf.mAlertView.lblMessage setText:NSLocalizedString(@"Timer is finished!",nil)];
            [tbf.mAlertView setType:1];
            [tbf AlertShow];
            AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
            NSString *json=[NSString stringWithFormat:@"{\"alarm\":\"%@\"}",key];
            [appDelegate sendData:json];
        }else{
            if(self.mTimer){
                [self.mTimer invalidate];
                self.mTimer=nil;
            }
        }
        break;
    }
}

- (void)showTimerString:(NSString*)key
{
    NSString *timer=[[[Data Instance]settValue]objectForKey:key];
    int tv=[timer intValue];
    if(tv>0){
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
        [self.lblSetTime setText:@""];
    }
}

@end