//
//  STBaseUserExperienceViewController.m
//  ElectricianRun
//
//  Created by Start on 2/28/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STBaseUserExperienceViewController.h"

#define ACTIONSHEETTAGMORE 1111

@interface STBaseUserExperienceViewController ()

@end

@implementation STBaseUserExperienceViewController

- (id)init
{
    self =[super init];
    if(self){
        [self.view setBackgroundColor:[UIColor blackColor]];
    }
    return self;
}


- (void)back:(id)sender
{
    [self.timer invalidate];
    [self.timerElectricity invalidate];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self buildUI];
    //初始化数据
    finalB9 = NO;
    for (int i = 0; i < 8; i++) {
        finalB[i] = YES;
    }
    allPhaseCurrentListCount=0;
    for(int i=0;i<12;i++){
        for(int r=0;r<2;r++){
            for(int j=0;j<4;j++){
                for(int k=0;k<3;k++){
                    allPhaseCurrentList[i][r][j][k]=0.0;
                }
                allTotalBurden[i][r][j]=0.0;
                allTotalElectricity[i][r][j]=0.0;
                allTotalElectricityVal[i][r][j]=0.0;
            }
        }
    }
    self.isTransLoad=NO;
    self.iaTempLastValue=0;
    //初始默认当前总电量为
    self.currentTotalElectricity=5;
    //初始调用一次
    [self startBusinessCal];
    [self displaySwitchStatus];
}

- (void)buildUI
{
    [self.view setBackgroundColor:[UIColor blackColor]];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.control=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, 320, 280)];
    [self.control setBackgroundColor:[UIColor blackColor]];
    self.control.contentSize = CGSizeMake(330,280);
    [self.control setScrollEnabled:YES];
    
    self.lblCurrentLoad=[[UILabel alloc]initWithFrame:CGRectMake(20, 25, 100, 29)];
    self.lblCurrentLoad.font=[UIFont systemFontOfSize:7];
    [self.lblCurrentLoad setTextColor:[UIColor orangeColor]];
    [self.lblCurrentLoad setBackgroundColor:[UIColor clearColor]];
    [self.lblCurrentLoad setNumberOfLines:0];
    [self.control addSubview:self.lblCurrentLoad];
    
    self.lblElectricity=[[UILabel alloc]initWithFrame:CGRectMake(220, 25, 100, 29)];
    self.lblElectricity.font=[UIFont systemFontOfSize:7];
    [self.lblElectricity setTextColor:[UIColor orangeColor]];
    [self.lblElectricity setBackgroundColor:[UIColor clearColor]];
    [self.lblElectricity setNumberOfLines:0];
    [self.control addSubview:self.lblElectricity];
    
    self.lblInLineAValue=[[UILabel alloc]initWithFrame:CGRectMake(20, 60, 40, 29)];
    self.lblInLineAValue.font=[UIFont systemFontOfSize:7];
//    [self.lblInLineAValue setText:@"ia=1243.23;\nib=1243.23;\nic=1243.23;"];
    [self.lblInLineAValue setTextColor:[UIColor whiteColor]];
    [self.lblInLineAValue setBackgroundColor:[UIColor clearColor]];
    [self.lblInLineAValue setNumberOfLines:0];
    self.lblInLineAValue.userInteractionEnabled=YES;
    self.lblInLineAValue.tag=0;
    [self.lblInLineAValue addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickCurrentDetailInfo:)]];
    [self.control addSubview:self.lblInLineAValue];
    
    self.lblOutLineA1Value=[[UILabel alloc]initWithFrame:CGRectMake(80, 100, 40, 29)];
    self.lblOutLineA1Value.font=[UIFont systemFontOfSize:7];
//    [self.lblOutLineA1Value setText:@"ia=1243.23;\nib=1243.23;\nic=1243.23;"];
    [self.lblOutLineA1Value setTextColor:[UIColor whiteColor]];
    [self.lblOutLineA1Value setBackgroundColor:[UIColor clearColor]];
    [self.lblOutLineA1Value setNumberOfLines:0];
    self.lblOutLineA1Value.userInteractionEnabled=YES;
    self.lblOutLineA1Value.tag=1;
    [self.lblOutLineA1Value addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickCurrentDetailInfo:)]];
    [self.control addSubview:self.lblOutLineA1Value];
    
    self.lblOutLineA2Value=[[UILabel alloc]initWithFrame:CGRectMake(80, 145, 40, 29)];
    self.lblOutLineA2Value.font=[UIFont systemFontOfSize:7];
//    [self.lblOutLineA2Value setText:@"ia=1243.23;\nib=1243.23;\nic=1243.23;"];
    [self.lblOutLineA2Value setTextColor:[UIColor whiteColor]];
    [self.lblOutLineA2Value setBackgroundColor:[UIColor clearColor]];
    [self.lblOutLineA2Value setNumberOfLines:0];
    self.lblOutLineA2Value.userInteractionEnabled=YES;
    self.lblOutLineA2Value.tag=2;
    [self.lblOutLineA2Value addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickCurrentDetailInfo:)]];
    [self.control addSubview:self.lblOutLineA2Value];
    
    self.lblOutLineA3Value=[[UILabel alloc]initWithFrame:CGRectMake(80, 195, 40, 29)];
    self.lblOutLineA3Value.font=[UIFont systemFontOfSize:7];
//    [self.lblOutLineA3Value setText:@"ia=1243.23;\nib=1243.23;\nic=1243.23;"];
    [self.lblOutLineA3Value setTextColor:[UIColor whiteColor]];
    [self.lblOutLineA3Value setBackgroundColor:[UIColor clearColor]];
    [self.lblOutLineA3Value setNumberOfLines:0];
    self.lblOutLineA3Value.userInteractionEnabled=YES;
    self.lblOutLineA3Value.tag=3;
    [self.lblOutLineA3Value addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickCurrentDetailInfo:)]];
    [self.control addSubview:self.lblOutLineA3Value];
    
    self.lblInLineBValue=[[UILabel alloc]initWithFrame:CGRectMake(270, 60, 40, 29)];
    self.lblInLineBValue.font=[UIFont systemFontOfSize:7];
//    [self.lblInLineBValue setText:@"ia=1243.23;\nib=1243.23;\nic=1243.23;"];
    [self.lblInLineBValue setTextColor:[UIColor whiteColor]];
    [self.lblInLineBValue setBackgroundColor:[UIColor clearColor]];
    [self.lblInLineBValue setNumberOfLines:0];
    self.lblInLineBValue.userInteractionEnabled=YES;
    self.lblInLineBValue.tag=4;
    [self.lblInLineBValue addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickCurrentDetailInfo:)]];
    [self.control addSubview:self.lblInLineBValue];
    
    self.lblOutLineB1Value=[[UILabel alloc]initWithFrame:CGRectMake(208, 100, 40, 29)];
    self.lblOutLineB1Value.font=[UIFont systemFontOfSize:7];
//    [self.lblOutLineB1Value setText:@"ia=1243.23;\nib=1243.23;\nic=1243.23;"];
    [self.lblOutLineB1Value setTextColor:[UIColor whiteColor]];
    [self.lblOutLineB1Value setBackgroundColor:[UIColor clearColor]];
    [self.lblOutLineB1Value setNumberOfLines:0];
    self.lblOutLineB1Value.userInteractionEnabled=YES;
    self.lblOutLineB1Value.tag=5;
    [self.lblOutLineB1Value addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickCurrentDetailInfo:)]];
    [self.control addSubview:self.lblOutLineB1Value];
    
    self.lblOutLineB2Value=[[UILabel alloc]initWithFrame:CGRectMake(208, 145, 40, 29)];
    self.lblOutLineB2Value.font=[UIFont systemFontOfSize:7];
//    [self.lblOutLineB2Value setText:@"ia=1243.23;\nib=1243.23;\nic=1243.23;"];
    [self.lblOutLineB2Value setTextColor:[UIColor whiteColor]];
    [self.lblOutLineB2Value setBackgroundColor:[UIColor clearColor]];
    [self.lblOutLineB2Value setNumberOfLines:0];
    self.lblOutLineB2Value.userInteractionEnabled=YES;
    self.lblOutLineB2Value.tag=6;
    [self.lblOutLineB2Value addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickCurrentDetailInfo:)]];
    [self.control addSubview:self.lblOutLineB2Value];
    
    self.lblOutLineB3Value=[[UILabel alloc]initWithFrame:CGRectMake(208, 195, 40, 29)];
    self.lblOutLineB3Value.font=[UIFont systemFontOfSize:7];
//    [self.lblOutLineB3Value setText:@"ia=1243.23;\nib=1243.23;\nic=1243.23;"];
    [self.lblOutLineB3Value setTextColor:[UIColor whiteColor]];
    [self.lblOutLineB3Value setBackgroundColor:[UIColor clearColor]];
    [self.lblOutLineB3Value setNumberOfLines:0];
    self.lblOutLineB3Value.userInteractionEnabled=YES;
    self.lblOutLineB3Value.tag=7;
    [self.lblOutLineB3Value addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickCurrentDetailInfo:)]];
    [self.control addSubview:self.lblOutLineB3Value];
    
    self.btnInLineA=[[UIButton alloc]initWithFrame:CGRectMake(32, 96, 24, 12)];
//    [self.btnInLineA setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    self.btnInLineA.tag=0;
    [self.btnInLineA addTarget:self action:@selector(onClickSwitch:) forControlEvents:UIControlEventTouchUpInside];
    [self.control addSubview:self.btnInLineA];
    
    self.btnOutLineA1=[[UIButton alloc]initWithFrame:CGRectMake(79.5, 134.5, 24, 12)];
//    [self.btnOutLineA1 setBackgroundImage:[UIImage imageNamed:@"open"] forState:UIControlStateNormal];
    self.btnOutLineA1.tag=1;
    [self.btnOutLineA1 addTarget:self action:@selector(onClickSwitch:) forControlEvents:UIControlEventTouchUpInside];
    [self.control addSubview:self.btnOutLineA1];
    
    self.btnOutLineA2=[[UIButton alloc]initWithFrame:CGRectMake(79.5, 183.5, 24, 12)];
//    [self.btnOutLineA2 setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    self.btnOutLineA2.tag=2;
    [self.btnOutLineA2 addTarget:self action:@selector(onClickSwitch:) forControlEvents:UIControlEventTouchUpInside];
    [self.control addSubview:self.btnOutLineA2];
    
    self.btnOutLineA3=[[UIButton alloc]initWithFrame:CGRectMake(79.5, 235.5, 24, 12)];
//    [self.btnOutLineA3 setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    self.btnOutLineA3.tag=3;
    [self.btnOutLineA3 addTarget:self action:@selector(onClickSwitch:) forControlEvents:UIControlEventTouchUpInside];
    [self.control addSubview:self.btnOutLineA3];
    
    self.btnInLineB=[[UIButton alloc]initWithFrame:CGRectMake(277, 96, 24, 12)];
//    [self.btnInLineB setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    self.btnInLineB.tag=4;
    [self.btnInLineB addTarget:self action:@selector(onClickSwitch:) forControlEvents:UIControlEventTouchUpInside];
    [self.control addSubview:self.btnInLineB];
    
    self.btnOutLineB1=[[UIButton alloc]initWithFrame:CGRectMake(219.5, 134.5, 24, 12)];
//    [self.btnOutLineB1 setBackgroundImage:[UIImage imageNamed:@"open"] forState:UIControlStateNormal];
    self.btnOutLineB1.tag=5;
    [self.btnOutLineB1 addTarget:self action:@selector(onClickSwitch:) forControlEvents:UIControlEventTouchUpInside];
    [self.control addSubview:self.btnOutLineB1];
    
    self.btnOutLineB2=[[UIButton alloc]initWithFrame:CGRectMake(219.5, 183.5, 24, 12)];
//    [self.btnOutLineB2 setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    self.btnOutLineB2.tag=6;
    [self.btnOutLineB2 addTarget:self action:@selector(onClickSwitch:) forControlEvents:UIControlEventTouchUpInside];
    [self.control addSubview:self.btnOutLineB2];
    
    self.btnOutLineB3=[[UIButton alloc]initWithFrame:CGRectMake(219.5, 235.5, 24, 12)];
//    [self.btnOutLineB3 setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    self.btnOutLineB3.tag=7;
    [self.btnOutLineB3 addTarget:self action:@selector(onClickSwitch:) forControlEvents:UIControlEventTouchUpInside];
    [self.control addSubview:self.btnOutLineB3];
    
    self.btnMotherOf=[[UIButton alloc]initWithFrame:CGRectMake(150, 223.5, 24, 12)];
//    [self.btnMotherOf setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    self.btnMotherOf.tag=8;
    [self.btnMotherOf addTarget:self action:@selector(onClickSwitch:) forControlEvents:UIControlEventTouchUpInside];
    [self.control addSubview:self.btnMotherOf];
    
    UIImageView *bgImg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"userexperiencelinebg"]];
    [bgImg setFrame:CGRectMake(0, 90, 330, 157)];
    [self.control addSubview:bgImg];
    
    [self.view addSubview:self.control];
}

//生成一个0～1之间的随机数小数点后保留两位
- (double)random
{
    int r=arc4random() % 100;
    return (double)r/100;
}

// 计算当前时间的商业电价
+ (double)businessCalculationTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH"];
    int hour = [[formatter stringFromDate:[NSDate date]]intValue];
    
    double money = 0;
    if (hour >= 19 && hour < 21) {
        money = 1.406;
    } else if ((hour >= 8 && hour < 11) || (hour >= 13 && hour < 19)
               || (hour >= 21 && hour < 22)) {
        money = 1.108;
    } else {
        money = 0.596;
    }
    return money;
}

- (void)startBusinessCal
{
    //进线A
    double rn0=[self random];
    if(self.isTransLoad){
        int sign=1;
        if (rn0 > 0.5) {
            sign = -1;
        }
        //保证每次产生的值都在最后一次的基础之上上下浮动5%
        self.electricCurrentLeftA=self.electricCurrentLeftA*sign*0.05+self.electricCurrentLeftA;
    }else{
        if(self.iaTempLastValue==0){
            //第一次随机数保证rn的值在0.1-1之间
            if(rn0<0.1){
                rn0=0.1+rn0;
            }
            self.electricCurrentLeftA=1443.4*rn0;
        }else{
            int sign=1;
            if (rn0 > 0.5) {
                sign = -1;
            }
            //保证每次产生的值都在最后一次的基础之上上下浮动5%
            self.electricCurrentLeftA=self.iaTempLastValue*sign*0.05+self.iaTempLastValue;
        }
        
        if(self.electricCurrentLeftA>1443.4){
            self.electricCurrentLeftA=1345;
        }else if(self.electricCurrentLeftA<144.34){
            self.electricCurrentLeftA=160;
        }
        self.iaTempLastValue=self.electricCurrentLeftA;
    }
    [self buildCal];
    
}

- (void)buildCal
{
    
    allPhaseCurrentListCount++;
    double rn1=[self random];
    if(rn1>0.5){
        self.electricCurrentLeftB=self.electricCurrentLeftA*1.05;
        self.electricCurrentLeftC=self.electricCurrentLeftA*0.95;
    }else{
        self.electricCurrentLeftB=self.electricCurrentLeftA*0.95;
        self.electricCurrentLeftC=self.electricCurrentLeftA*1.05;
    }
    
    //进线B
    double rn2=[self random];
    if(rn2>0.5){
        self.electricCurrentRightA=self.electricCurrentLeftA*1.05;
    }else{
        self.electricCurrentRightA=self.electricCurrentLeftA*0.95;
    }
    
    double rn3=[self random];
    if(rn3>0.5){
        self.electricCurrentRightB=self.electricCurrentRightA*1.05;
        self.electricCurrentRightC=self.electricCurrentRightA*0.95;
    }else{
        self.electricCurrentRightB=self.electricCurrentRightA*0.95;
        self.electricCurrentRightC=self.electricCurrentRightA*1.05;
    }
    
    for(int i=0;i<4;i++){
        for(int j=0;j<3;j++){
            threePhaseCurrentLeft[i][j]=0.0;
            threePhaseCurrentRight[i][j]=0.0;
        }
    }
    
    threePhaseCurrentLeft[0][0]=self.electricCurrentLeftA;
    threePhaseCurrentLeft[0][1]=self.electricCurrentLeftB;
    threePhaseCurrentLeft[0][2]=self.electricCurrentLeftC;
    threePhaseCurrentRight[0][0]=self.electricCurrentRightA;
    threePhaseCurrentRight[0][1]=self.electricCurrentRightB;
    threePhaseCurrentRight[0][2]=self.electricCurrentRightC;
    
    //把数组中所有的值往前移一位把数组最后一位空出来保存新值
    int length=11;
    for(int i=0;i<length;i++){
        for(int r=0;r<2;r++){
            for(int j=0;j<4;j++){
                for(int k=0;k<3;k++){
                    //电流数组
                    allPhaseCurrentList[i][r][j][k]=allPhaseCurrentList[i+1][r][j][k];
                }
                //每条进出线的负荷数组
                allTotalBurden[i][r][j]=allTotalBurden[i+1][r][j];
            }
        }
    }
    
    [self startCalculate];
    
    [self displayElectricCurrent];
}

- (void)startCalculate
{
    for(int index=0;index<3;index++) {
        //母联开关是否合并
        if (finalB9) {
            if (!finalB[0] && !finalB[4]) {
                threePhaseCurrentLeft[0][index]= 0.0;
                threePhaseCurrentLeft[1][index]= 0.0;
                threePhaseCurrentLeft[2][index]= 0.0;
                threePhaseCurrentLeft[3][index]= 0.0;
                
                threePhaseCurrentRight[0][index]= 0.0;
                threePhaseCurrentRight[1][index]= 0.0;
                threePhaseCurrentRight[2][index]= 0.0;
                threePhaseCurrentRight[3][index]= 0.0;
            } else {
                double electricCurrent=0.0;
                if (finalB[0]) {
                    electricCurrent=threePhaseCurrentLeft[0][index];
                } else if (finalB[4]) {
                    electricCurrent=threePhaseCurrentRight[0][index];
                }
                threePhaseCurrentLeft[1][index] = electricCurrent * 0.15;// I*1
                threePhaseCurrentLeft[2][index] = electricCurrent * 0.25;// I*2
                threePhaseCurrentLeft[3][index] = electricCurrent * 0.1;// I*3
                
                threePhaseCurrentRight[1][index] = electricCurrent * 0.15;// I*1
                threePhaseCurrentRight[2][index] = electricCurrent * 0.25;// I*2
                threePhaseCurrentRight[3][index] = electricCurrent * 0.1;// I*3
                //出线A
                if (!finalB[1]) {
                    electricCurrent = electricCurrent - threePhaseCurrentLeft[1][index];
                    threePhaseCurrentLeft[1][index] = 0.0;
                }
                if (!finalB[2]) {
                    electricCurrent = electricCurrent - threePhaseCurrentLeft[2][index];
                    threePhaseCurrentLeft[2][index] = 0.0;
                }
                if (!finalB[3]) {
                    electricCurrent = electricCurrent - threePhaseCurrentLeft[3][index];
                    threePhaseCurrentLeft[3][index] = 0.0;
                }
                //出线B
                if (!finalB[5]) {
                    electricCurrent = electricCurrent - threePhaseCurrentRight[1][index];
                    threePhaseCurrentRight[1][index] = 0.0;
                }
                if (!finalB[6]) {
                    electricCurrent = electricCurrent - threePhaseCurrentRight[2][index];
                    threePhaseCurrentRight[2][index] = 0.0;
                }
                if (!finalB[7]) {
                    electricCurrent = electricCurrent - threePhaseCurrentRight[3][index];
                    threePhaseCurrentRight[3][index] = 0.0;
                }
                if (finalB[0]) {
                    //进线A
                    threePhaseCurrentRight[0][index] = 0.0;
                    threePhaseCurrentLeft[0][index] = electricCurrent;
                } else if (finalB[4]) {
                    //进线B
                    threePhaseCurrentLeft[0][index] = 0.0;
                    threePhaseCurrentRight[0][index] = electricCurrent;
                }
            }
        } else {
            if(!finalB[0]) {
                threePhaseCurrentLeft[0][index]=0;
                threePhaseCurrentLeft[1][index]=0;
                threePhaseCurrentLeft[2][index]=0;
                threePhaseCurrentLeft[3][index]=0;
            } else {
                double phaseValue=threePhaseCurrentLeft[0][index];
                threePhaseCurrentLeft[1][index] = phaseValue * 0.2;// I*1
                threePhaseCurrentLeft[2][index] = phaseValue * 0.3;// I*2
                threePhaseCurrentLeft[3][index] = phaseValue * 0.5;// I*3
                if (!finalB[1]) {
                    phaseValue = phaseValue - threePhaseCurrentLeft[1][index];
                    threePhaseCurrentLeft[1][index] = 0.0;
                }
                if (!finalB[2]) {
                    phaseValue = phaseValue - threePhaseCurrentLeft[2][index];
                    threePhaseCurrentLeft[2][index] = 0.0;
                }
                if (!finalB[3]) {
                    phaseValue = phaseValue - threePhaseCurrentLeft[3][index];
                    threePhaseCurrentLeft[3][index] = 0.0;
                }
                threePhaseCurrentLeft[0][index]=phaseValue;
            }
            if(!finalB[4]) {
                threePhaseCurrentRight[0][index]=0;
                threePhaseCurrentRight[1][index]=0;
                threePhaseCurrentRight[2][index]=0;
                threePhaseCurrentRight[3][index]=0;
            } else {
                double phaseValue=threePhaseCurrentRight[0][index];
                threePhaseCurrentRight[1][index] = phaseValue * 0.2;// I*1
                threePhaseCurrentRight[2][index] = phaseValue * 0.3;// I*2
                threePhaseCurrentRight[3][index] = phaseValue * 0.5;// I*3
                if (!finalB[5]) {
                    phaseValue = phaseValue - threePhaseCurrentRight[1][index];
                    threePhaseCurrentRight[1][index] = 0.0;
                }
                if (!finalB[6]) {
                    phaseValue = phaseValue - threePhaseCurrentRight[2][index];
                    threePhaseCurrentRight[2][index] = 0.0;
                }
                if (!finalB[7]) {
                    phaseValue = phaseValue - threePhaseCurrentRight[3][index];
                    threePhaseCurrentRight[3][index] = 0.0;
                }
                threePhaseCurrentRight[0][index]=phaseValue;
            }
        }
    }
    
    int length=11;
    //最新的值永远保存在最后一位
    for(int i=0;i<4;i++){
        for(int j=0;j<3;j++){
            allPhaseCurrentList[length][0][i][j]=threePhaseCurrentLeft[i][j];
            allPhaseCurrentList[length][1][i][j]=threePhaseCurrentRight[i][j];
        }
    }
    //随机生成一个0.9~1的随机数
    int r=arc4random() % 10;
    double d=(double)r/100+0.9;
    
    for(int i=0;i<4;i++){
        
        if(finalB[i]){
            allTotalBurden[length][0][i]=threePhaseCurrentLeft[i][0]*220*d+threePhaseCurrentLeft[i][1]*220*d+threePhaseCurrentLeft[i][2]*220*d;
        } else {
            allTotalBurden[length][0][i]=0.0;
        }
        
        if(finalB[4+i]){
            allTotalBurden[length][1][i]=threePhaseCurrentRight[i][0]*220*d+threePhaseCurrentRight[i][1]*220*d+threePhaseCurrentRight[i][2]*220*d;
        } else {
            allTotalBurden[length][1][i]=0.0;
        }
        
    }
    
    //计算总负荷
    double tmpBurden=0.0;
    if(finalB[0]){
        tmpBurden  = allTotalBurden[length][0][0];
    }
    if(finalB[4]){
        tmpBurden = tmpBurden + allTotalBurden[length][1][0];
    }
    if(self.currentTotalBurden>0){
        self.lastTotalBurden=self.currentTotalBurden;
    }
    self.currentTotalBurden=tmpBurden;
    
}

//总电量(更新调用频率一分钟)
- (void)totalElectricity
{
    allTotalElectricityCount++;
    int length=11;
    //把数组中所有的值往前移一位把数组最后一位空出来保存新值
    for(int i=0;i<length;i++){
        for(int j=0;j<2;j++){
            for(int k=0;k<4;k++){
                allTotalElectricity[i][j][k]=allTotalElectricity[i+1][j][k];
                allTotalElectricityVal[i][j][k]=allTotalElectricityVal[i+1][j][k];
            }
        }
    }
    for(int i=0;i<2;i++){
        for(int j=0;j<4;j++){
            allTotalElectricity[length][i][j]=(allTotalBurden[length-1][i][j]+allTotalBurden[length][i][j])/2/60/1000;
            allTotalElectricityVal[length][i][j]=allTotalElectricity[length][i][j]*[STBaseUserExperienceViewController businessCalculationTime];
        }
    }
    self.currentTotalElectricity=self.currentTotalElectricity+(self.lastTotalBurden+self.currentTotalBurden)/2/60/1000;
}

//显示当前的电流
- (void)displayElectricCurrent
{
    //页面显示电流信息
    [self.lblInLineAValue setText:[NSString stringWithFormat:DISPLAYLINESTR,threePhaseCurrentLeft[0][0],threePhaseCurrentLeft[0][1],threePhaseCurrentLeft[0][2]]];
    [self.lblOutLineA1Value setText:[NSString stringWithFormat:DISPLAYLINESTR,threePhaseCurrentLeft[1][0],threePhaseCurrentLeft[1][1],threePhaseCurrentLeft[1][2]]];
    [self.lblOutLineA2Value setText:[NSString stringWithFormat:DISPLAYLINESTR,threePhaseCurrentLeft[2][0],threePhaseCurrentLeft[2][1],threePhaseCurrentLeft[2][2]]];
    [self.lblOutLineA3Value setText:[NSString stringWithFormat:DISPLAYLINESTR,threePhaseCurrentLeft[3][0],threePhaseCurrentLeft[3][1],threePhaseCurrentLeft[3][2]]];
    
    [self.lblInLineBValue setText:[NSString stringWithFormat:DISPLAYLINESTR,threePhaseCurrentRight[0][0],threePhaseCurrentRight[0][1],threePhaseCurrentRight[0][2]]];
    [self.lblOutLineB1Value setText:[NSString stringWithFormat:DISPLAYLINESTR,threePhaseCurrentRight[1][0],threePhaseCurrentRight[1][1],threePhaseCurrentRight[1][2]]];
    [self.lblOutLineB2Value setText:[NSString stringWithFormat:DISPLAYLINESTR,threePhaseCurrentRight[2][0],threePhaseCurrentRight[2][1],threePhaseCurrentRight[2][2]]];
    [self.lblOutLineB3Value setText:[NSString stringWithFormat:DISPLAYLINESTR,threePhaseCurrentRight[3][0],threePhaseCurrentRight[3][1],threePhaseCurrentRight[3][2]]];
    //当前负荷
    [self.lblCurrentLoad setText:[NSString stringWithFormat:@"当前负荷：%.2fkW",self.currentTotalBurden/1000]];
    //当前总电量
    [self.lblElectricity setText:[NSString stringWithFormat:@"当前总电量：%.2fkWh",self.currentTotalElectricity]];
}

//显示开关的状态
- (void)displaySwitchStatus
{
    if(finalB[0]){
        [self.btnInLineA setBackgroundImage:[UIImage imageNamed:@"open"] forState:UIControlStateNormal];
    }else{
        [self.btnInLineA setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    }
    if(finalB[1]){
        [self.btnOutLineA1 setBackgroundImage:[UIImage imageNamed:@"open"] forState:UIControlStateNormal];
    }else{
        [self.btnOutLineA1 setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    }
    if(finalB[2]){
        [self.btnOutLineA2 setBackgroundImage:[UIImage imageNamed:@"open"] forState:UIControlStateNormal];
    }else{
        [self.btnOutLineA2 setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    }
    if(finalB[3]){
        [self.btnOutLineA3 setBackgroundImage:[UIImage imageNamed:@"open"] forState:UIControlStateNormal];
    }else{
        [self.btnOutLineA3 setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    }
    if(finalB[4]){
        [self.btnInLineB setBackgroundImage:[UIImage imageNamed:@"open"] forState:UIControlStateNormal];
    }else{
        [self.btnInLineB setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    }
    if(finalB[5]){
        [self.btnOutLineB1 setBackgroundImage:[UIImage imageNamed:@"open"] forState:UIControlStateNormal];
    }else{
        [self.btnOutLineB1 setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    }
    if(finalB[6]){
        [self.btnOutLineB2 setBackgroundImage:[UIImage imageNamed:@"open"] forState:UIControlStateNormal];
    }else{
        [self.btnOutLineB2 setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    }
    if(finalB[7]){
        [self.btnOutLineB3 setBackgroundImage:[UIImage imageNamed:@"open"] forState:UIControlStateNormal];
    }else{
        [self.btnOutLineB3 setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    }
    if(finalB9){
        [self.btnMotherOf setBackgroundImage:[UIImage imageNamed:@"open"] forState:UIControlStateNormal];
    }else{
        [self.btnMotherOf setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    }
}

- (void)onClickSwitch:(id)sender
{
    
}

- (void)onClickLoadDetail:(id)sender
{
    
}

- (void)onClickCurrentDetailInfo:(UITapGestureRecognizer*)sender
{
    
}

@end