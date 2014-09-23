//
//  STUserExperienceAlarmViewController.m
//  ElectricianRun
//
//  Created by Start on 2/11/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STUserExperienceAlarmViewController.h"
#import "STUserExperienceLineDetailViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface STUserExperienceAlarmViewController ()

@end

@implementation STUserExperienceAlarmViewController {
    AVAudioPlayer *player;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.title=@"体验站电气主接线图";
        
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]
                                               initWithTitle:@"返回"
                                               style:UIBarButtonItemStyleBordered
                                               target:self
                                               action:@selector(back:)];
        switchFlag=NO;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    float height=self.view.frame.size.height;
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, height-160, 300, 20)];
    lbl.font=[UIFont systemFontOfSize:12];
    [lbl setText:@"体验说明"];
    [lbl setTextColor:[UIColor whiteColor]];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:lbl];
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, height-140, 300, 20)];
    lbl.font=[UIFont systemFontOfSize:12];
    [lbl setText:@"(1)点击线路开关体验开关分合闸。"];
    [lbl setTextColor:[UIColor whiteColor]];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:lbl];lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, height-120, 300, 20)];
    lbl.font=[UIFont systemFontOfSize:12];
    [lbl setText:@"(2)点击数据查看线路的运行曲线、体验报警功能。"];
    [lbl setTextColor:[UIColor whiteColor]];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:lbl];
    
    self.btnSignup=[[UIButton alloc]initWithFrame:CGRectMake(40, self.view.frame.size.height-64, 100, 30)];
    [self.btnSignup setBackgroundImage:[UIImage imageNamed:@"bm"] forState:UIControlStateNormal];
    [self.btnSignup addTarget:self action:@selector(onClickSignup:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnSignup];
    
    self.btnAlarmExperience=[[UIButton alloc]initWithFrame:CGRectMake(180, self.view.frame.size.height-64, 100, 30)];
    [self.btnAlarmExperience setBackgroundImage:[UIImage imageNamed:@"cj"] forState:UIControlStateNormal];
    [self.btnAlarmExperience addTarget:self action:@selector(onClickAlarmExperience:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnAlarmExperience];
    [self totalElectricity];
    //以后则每根据设定的时间调用一次
    self.timer = [NSTimer scheduledTimerWithTimeInterval:REFRESHNUM1 target:self selector:@selector(startBusinessCal) userInfo:nil repeats:YES];
    self.timerElectricity = [NSTimer scheduledTimerWithTimeInterval:REFRESHNUM2 target:self selector:@selector(totalElectricity) userInfo:nil repeats:YES];
    
}

- (void)onClickCurrentDetailInfo:(UITapGestureRecognizer*)sender
{
    UILabel *lblSender=((UILabel*)sender.view);
    long tag=lblSender.tag;
    STUserExperienceLineDetailViewController *userExperienceLineDetailViewController=[[STUserExperienceLineDetailViewController alloc]initWithIndex:tag];
    [self.navigationController pushViewController:userExperienceLineDetailViewController animated:YES];
}

- (void)onClickSwitch:(id)sender
{
 
    UIButton *send=(UIButton*)sender;
    long tag=(send).tag;
    
    if(tag==0){
        //母联开关
        if(finalB9){
            if(!finalB[0]&&finalB[4]){
                [Common alert:@"请先断开母联开关，再合上进线开关。"];
                return;
            }
        }
        
        if(finalB[0]&&!finalB[4]){
            [Common alert:@"进线开关全部断开将造成全站失电。"];
            return;
        }
        
    }else if(tag==4){
        //母联开关
        if(finalB9){
            if(finalB[0]&&!finalB[4]){
                [Common alert:@"请先断开母联开关，再合上进线开关。"];
                return;
            }
        }
        
        if(!finalB[0]&&finalB[4]){
            [Common alert:@"进线开关全部断开将造成全站失电。"];
            return;
        }
        
    }else if(tag==8){
        if(!finalB9){
            if(finalB[0]&&finalB[4]){
                [Common alert:@"先断开一条进线开关后，才可再合上母联开关。"];
                return;
            }
        }
        finalB9=!finalB9;
    }
    
    if(tag<8) {
        finalB[tag]=!finalB[tag];
    }
    
    if(switchFlag){
        if(tag<8){
            if(!finalB[tag]){
                //开启报警声音
                NSString *path=[[NSBundle mainBundle] pathForResource: @"alarm" ofType: @"mp3"];
                NSURL *url=[[NSURL alloc] initFileURLWithPath:path];
                NSError *error;
                player=[[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
                if (error) {
                    NSLog(@"error:%@",[error description]);
                    return;
                }
                [player setVolume:1];   //设置音量大小
                player.numberOfLoops = 1;//设置音乐播放次数  -1为一直循环
                [player prepareToPlay];
                [player play];
                if(tag==0){
                    [Common alert:@"进线1开关跳闸，请注意！"];
                }else if(tag==1){
                    [Common alert:@"出线A-1开关跳闸，请注意！"];
                }else if(tag==2){
                    [Common alert:@"出线A-2开关跳闸，请注意！"];
                }else if(tag==3){
                    [Common alert:@"出线A-3开关跳闸，请注意！"];
                }else if(tag==4){
                    [Common alert:@"进线2开关跳闸，请注意！"];
                }else if(tag==5){
                    [Common alert:@"出线B-1开关跳闸，请注意！"];
                }else if(tag==6){
                    [Common alert:@"出线B-2开关跳闸，请注意！"];
                }else if(tag==7){
                    [Common alert:@"出线B-3开关跳闸，请注意！"];
                }
                switchFlag=NO;
            }
        }
    }
    
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
    
}


- (void)onClickLoadDetail:(id)sender {
    long tag=((UIButton*)sender).tag;
    STUserExperienceLineDetailViewController *userExperienceLineDetailViewController=[[STUserExperienceLineDetailViewController alloc]initWithIndex:tag];
    [self.navigationController pushViewController:userExperienceLineDetailViewController animated:YES];
}

//负荷超限报警体验
- (void)onClickAlarmExperience:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"企业总负荷超限报警体验阈值"
                          message:@"提示：输入阈值范围在0～2500之间"
                          delegate:self
                          cancelButtonTitle:@"取消"
                          otherButtonTitles:@"确定",nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    //设置输入框的键盘类型
    UITextField *tf = [alert textFieldAtIndex:0];
    tf.keyboardType = UIKeyboardTypeDecimalPad;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1){
        NSString *content=[[alertView textFieldAtIndex:0]text];
        if(![@"" isEqualToString:content]){
            double value=[content doubleValue];
            if(value>0&&value<=2500){
                self.isTransLoad=YES;
                self.electricCurrentLeftA=[self transCurrent:value];
                [self buildCal];
                UIActionSheet *sheet = [[UIActionSheet alloc]
                                        initWithTitle:@"企业总负荷超过所设定的阀值，请注意！"
                                        delegate:self
                                        cancelButtonTitle:nil
                                        destructiveButtonTitle:@"确定"
                                        otherButtonTitles:nil,nil];
                sheet.tag=100;
                [sheet showInView:[UIApplication sharedApplication].keyWindow];
                
                //开启报警声音
                NSString *path=[[NSBundle mainBundle] pathForResource: @"alarm" ofType: @"mp3"];
                NSURL *url=[[NSURL alloc] initFileURLWithPath:path];
                NSError *error;
                player=[[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
                if (error) {
                    NSLog(@"error:%@",[error description]);
                    return;
                }
                [player setVolume:1];   //设置音量大小
                player.numberOfLoops = -1;//设置音乐播放次数  -1为一直循环
                [player prepareToPlay];
                [player play];
            }else{
                [Common alert:@"输入阈值范围在0～2500之间"];
            }
        }else{
            [Common alert:@"阈值不能为空"];
        }
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(actionSheet.tag==100){
        if(buttonIndex==0){
            //关闭报警声音
            if([player isPlaying]){
                [player stop];
            }
            player=nil;
            self.isTransLoad=NO;
            [self startBusinessCal];
        }
    }else{
        [super actionSheet:actionSheet clickedButtonAtIndex:buttonIndex];
    }
}

//计算负荷超限报警通过开关状态，确定负荷电流
- (double)transCurrent:(double)load {
    double current = 0;
    //随机生成一个0.9~1的随机数
    double d=((double)(arc4random() % 10)/100)+0.9;
    if (!finalB[0] || !finalB[4]) {
        load = load;
    } else if ((!finalB[1] && !finalB[2] && !finalB[3])
               || (!finalB[5] && !finalB[6] && !finalB[7])) {
        load = load;
    } else {
        load = load / 2;
    }
    current = load * 1000 / 220 / d / 3 * 1.15;
    return current;
}

@end
