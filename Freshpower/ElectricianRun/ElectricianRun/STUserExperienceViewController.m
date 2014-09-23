//
//  STUserExperienceViewController.m
//  ElectricianRun
//  用户体验
//  Created by Start on 1/24/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STUserExperienceViewController.h"

@interface STUserExperienceViewController ()

@end

@implementation STUserExperienceViewController {
    //用户类型1：大工业用户2：商业用户
    int usertype;
    int level;
    int counttimer;
    
}

- (id)initWithUserType:(int)userType
{
    self = [super init];
    if (self) {
        usertype=userType;
        if(usertype==1){
            self.title=@"大工业用户体验";
        }else{
            self.title=@"商业用户体验";
        }
        [self.view setBackgroundColor:[UIColor blackColor]];
        
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]
                                               initWithTitle:@"返回"
                                               style:UIBarButtonItemStyleBordered
                                               target:self
                                               action:@selector(back:)];
        
    }
    return self;
}

- (void)back:(id)sender
{
    [self.countdown invalidate];
    [super back:sender];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.btnSignup=[[UIButton alloc]initWithFrame:CGRectMake(110, self.view.frame.size.height-64, 100, 30)];
    [self.btnSignup setBackgroundImage:[UIImage imageNamed:@"bm"] forState:UIControlStateNormal];
    [self.btnSignup addTarget:self action:@selector(onClickSignup:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnSignup];
    
    self.lblCountdown=[[UILabel alloc]initWithFrame:CGRectMake(20, 5, 80, 29)];
    self.lblCountdown.font=[UIFont systemFontOfSize:7];
    [self.lblCountdown setTextColor:[UIColor orangeColor]];
    [self.lblCountdown setBackgroundColor:[UIColor clearColor]];
    [self.lblCountdown setNumberOfLines:0];
    [self.control  addSubview:self.lblCountdown];
    if(usertype==1){
        level=arc4random() % 4+1;
        counttimer=REFRESHNUM2*2;
    }else{
        level=arc4random() % 5+1;
        counttimer=REFRESHNUM2*3;
    }
    self.iaTempLastValue=[self dataWithLevel:level];
    [self startBusinessCal];
    [self showtime];
    //以后则每根据设定的时间调用一次
    self.timer = [NSTimer scheduledTimerWithTimeInterval:REFRESHNUM1 target:self selector:@selector(startBusinessCal) userInfo:nil repeats:YES];
    self.timerElectricity = [NSTimer scheduledTimerWithTimeInterval:REFRESHNUM2 target:self selector:@selector(totalElectricity) userInfo:nil repeats:YES];
    self.countdown = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countdownf) userInfo:nil repeats:YES];
}

- (double)dataWithLevel:(int)t
{
    if(usertype==1){
        if(t==1){
            return 577.2*0.9;
        }else if(t==2){
            return 721.5*0.9;
        }else if(t==3){
            return 865.8*0.9;
        }else{
            return 1010.1*0.9;
        }
    }else{
        if(t==1){
            return 288.6*0.9;
        }else if(t==2){
            return 360.75*0.9;
        }else if(t==3){
            return 432.9*0.9;
        }else if(t==4){
            return 505.1*0.9;
        }else{
            return 577.2*0.9;
        }
    }
}

//倒计时
- (void)countdownf
{
    counttimer--;
    if(usertype==1){
        if(counttimer==60){
            int percent;
            int bruden;
            if(level==1){
                percent=1000;
                bruden=40;
            }else if(level==2){
                percent=1250;
                bruden=50;
            }else if(level==3){
                percent=1500;
                bruden=60;
            }else{
                percent=1750;
                bruden=70;
            }
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"大工业用户体验"
                                  message:[NSString stringWithFormat:@"大工业用户，您当前总负荷低于%dKW，整体负载率低于%d％。体验继续…",percent,bruden]
                                  delegate:self
                                  cancelButtonTitle:@"接受建议"
                                  otherButtonTitles:@"取消体验",nil];
            alert.tag=1;
            [alert show];
        }else if(counttimer==0){
            int percent;
            int bruden;
            int money;
            if(level==1){
                percent=1000;
                bruden=40;
                money=35000;
            }else if(level==2){
                percent=1250;
                bruden=50;
                money=25000;
            }else if(level==3){
                percent=1500;
                bruden=60;
                money=15000;
            }else{
                percent=1750;
                bruden=70;
                money=5000;
            }
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"大工业用户体验"
                                  message:[NSString stringWithFormat:@"大工业用户，您当前总负荷低于%dKW，整体负载率低于%d％，采用需量计算基本电费比按容量每月节省%d元！",percent,bruden,money]
                                  delegate:self
                                  cancelButtonTitle:@"确定"
                                  otherButtonTitles:nil,nil];
            alert.tag=2;
            [alert show];
            [self.timer invalidate];
            [self.timerElectricity invalidate];
            [self.countdown invalidate];
        }
    }else{
        if(counttimer==120){
            int money;
            if(level==1){
                money=39962;
            }else if(level==2){
                money=54952;
            }else if(level==3){
                money=59942;
            }else if(level==4){
                money=69933;
            }else{
                money=82423;
            }
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"商业用户体验"
                                  message:[NSString stringWithFormat:@"商业用户，您可以更改为大工业用户，并申请暂停一台变压器，每月节省电费约计%d元！",money]
                                  delegate:self
                                  cancelButtonTitle:@"接受建议"
                                  otherButtonTitles:@"取消体验",nil];
            alert.tag=3;
            [alert show];
        }else if(counttimer==0){
            
            double basetariff;
            if(level==1){
                basetariff=24000;
            }else if(level==2||level==3||level==4){
                if(level==2){
                    basetariff=40*625;
                }else if(level==3){
                    basetariff=40*750;
                }else{
                    basetariff=40*875;
                }
            }else{
                basetariff=37500;
            }
            
            double C1=self.currentTotalElectricity*[self industrialCalculationTime]+2*basetariff/(30*24*60);
            double C2=self.currentTotalElectricity*[STBaseUserExperienceViewController businessCalculationTime];
            
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"商业用户体验"
                                  message:[NSString stringWithFormat:@"更改运行方式后，您已节省电费%.2f元",C2-C1]
                                  delegate:self
                                  cancelButtonTitle:@"确定"
                                  otherButtonTitles:nil,nil];
            alert.tag=4;
            [alert show];
            [self.timer invalidate];
            [self.timerElectricity invalidate];
            [self.countdown invalidate];
        }
    }
    [self showtime];
}

- (void)showtime
{
    int t1=counttimer/60;
    int t2=counttimer%60;
    if(t1>9&&t2>9){
        [self.lblCountdown setText:[NSString stringWithFormat:@"倒计时：%d:%d",t1,t2]];
    }else{
        if(t1<10&&t2<10){
            [self.lblCountdown setText:[NSString stringWithFormat:@"倒计时：0%d:0%d",t1,t2]];
        }else if(t1>9){
            [self.lblCountdown setText:[NSString stringWithFormat:@"倒计时：%d:0%d",t1,t2]];
        }else{
            [self.lblCountdown setText:[NSString stringWithFormat:@"倒计时：0%d:%d",t1,t2]];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==1){
        //取消体验
        if(buttonIndex==1) {
            [self.timer invalidate];
            [self.timerElectricity invalidate];
            [self.countdown invalidate];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }else if(alertView.tag==2){
        //确定
        if(buttonIndex==0){
            [self.timer invalidate];
            [self.timerElectricity invalidate];
            [self.countdown invalidate];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }else if(alertView.tag==3){
        if(buttonIndex==0){
            //继续体验
            finalB[0]=YES;
            finalB[4]=NO;
            finalB9=YES;
            //把最后一次生成的电流值重新进行赋值计算
            threePhaseCurrentLeft[0][0]=self.electricCurrentLeftA;
            threePhaseCurrentLeft[0][1]=self.electricCurrentLeftB;
            threePhaseCurrentLeft[0][2]=self.electricCurrentLeftC;
            threePhaseCurrentRight[0][0]=self.electricCurrentRightA;
            threePhaseCurrentRight[0][1]=self.electricCurrentRightB;
            threePhaseCurrentRight[0][2]=self.electricCurrentRightC;
            
            [self startCalculate];
            
            [self displayElectricCurrent];
            
            [self displaySwitchStatus];
        }else if(buttonIndex==1){
            //取消体验
            [self.timer invalidate];
            [self.timerElectricity invalidate];
            [self.countdown invalidate];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }else if(alertView.tag==4){
        //确定
        if(buttonIndex==0){
            [self.timer invalidate];
            [self.timerElectricity invalidate];
            [self.countdown invalidate];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

// 计算当前时间的工业电价
- (double)industrialCalculationTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH"];
    int hour = [[formatter stringFromDate:[NSDate date]]intValue];
    
    double money = 0;
    if (hour >= 19 && hour < 21) {
        money = 1.123;
    } else if ((hour >= 8 && hour < 11) || (hour >= 13 && hour < 19)
               || (hour >= 21 && hour < 22)) {
        money = 0.941;
    } else {
        money = 0.457;
    }
    return money;
}

@end

