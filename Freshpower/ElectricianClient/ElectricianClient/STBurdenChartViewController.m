//
//  STBurdenChartViewController.m
//  ElectricianClient
//
//  Created by Start on 3/26/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STBurdenChartViewController.h"
#import "STChartViewController.h"

@interface STBurdenChartViewController ()

@end

@implementation STBurdenChartViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.title=@"主线接图";
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]
                                                initWithTitle:@"返回"
                                                style:UIBarButtonItemStyleBordered
                                                target:self
                                                action:@selector(back:)];
        [self totalElectricity];
        //以后则每根据设定的时间调用一次
        self.timer = [NSTimer scheduledTimerWithTimeInterval:REFRESHNUM1 target:self selector:@selector(startBusinessCal) userInfo:nil repeats:YES];
        self.timerElectricity = [NSTimer scheduledTimerWithTimeInterval:REFRESHNUM2 target:self selector:@selector(totalElectricity) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
- (void)onClickCurrentDetailInfo:(UITapGestureRecognizer*)sender
{
    UILabel *lblSender=((UILabel*)sender.view);
    long tag=lblSender.tag;
    STChartViewController *chartViewController=[[STChartViewController alloc]initWithIndex:tag Type:1];
    [self.navigationController pushViewController:chartViewController animated:YES];
}


@end
