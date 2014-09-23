//
//  STBurdenListViewController.m
//  ElectricianClient
//
//  Created by Start on 3/26/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "STBurdenListViewController.h"
#import "STSimulationData.h"
#import "BurdenView.h"

//保存每条进出线开关的状态
bool finalB[8];
//保存最近12个每条进出线的电流IA、IB、IC的值
extern double allPhaseCurrentList[12][2][4][3];
//保存最近12个每条进出线的负荷数
extern double allTotalBurden[12][2][4];

@interface STBurdenListViewController ()

@end

@implementation STBurdenListViewController {
    NSTimer *timer;
    NSArray *burdentViews;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.title=@"列表形式";
        
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]
                                                initWithTitle:@"返回"
                                                style:UIBarButtonItemStyleBordered
                                                target:self
                                                action:@selector(back:)];
        self.automaticallyAdjustsScrollViewInsets=NO;
        UIScrollView *scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-49-64)];
        [scroll setBackgroundColor:[UIColor whiteColor]];
        scroll.contentSize = CGSizeMake(320,525);
        [scroll setScrollEnabled:YES];
        [self.view addSubview:scroll];
        
        BurdenView *burdenView1=[[BurdenView alloc]initWithFrame:CGRectMake(5, 5, 310, 60)];
        [scroll addSubview:burdenView1];
        BurdenView *burdenView2=[[BurdenView alloc]initWithFrame:CGRectMake(5, 70, 310, 60)];
        [scroll addSubview:burdenView2];
        BurdenView *burdenView3=[[BurdenView alloc]initWithFrame:CGRectMake(5, 135, 310, 60)];
        [scroll addSubview:burdenView3];
        BurdenView *burdenView4=[[BurdenView alloc]initWithFrame:CGRectMake(5, 200, 310, 60)];
        [scroll addSubview:burdenView4];
        BurdenView *burdenView5=[[BurdenView alloc]initWithFrame:CGRectMake(5, 265, 310, 60)];
        [scroll addSubview:burdenView5];
        BurdenView *burdenView6=[[BurdenView alloc]initWithFrame:CGRectMake(5, 330, 310, 60)];
        [scroll addSubview:burdenView6];
        BurdenView *burdenView7=[[BurdenView alloc]initWithFrame:CGRectMake(5, 395, 310, 60)];
        [scroll addSubview:burdenView7];
        BurdenView *burdenView8=[[BurdenView alloc]initWithFrame:CGRectMake(5, 460, 310, 60)];
        [scroll addSubview:burdenView8];
        
        burdentViews=[[NSArray alloc]initWithObjects:burdenView1,burdenView2,burdenView3,burdenView4,burdenView5,burdenView6,burdenView7,burdenView8, nil];
        
        [self display];
        
        timer = [NSTimer scheduledTimerWithTimeInterval:REFRESHNUM1 target:self selector:@selector(display) userInfo:nil repeats:YES];
        
    }
    return self;
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self display];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)display
{
    for(int i=0;i<8;i++){
        BurdenView *bv=[burdentViews objectAtIndex:i];
        [[bv lbl1] setText:[STSimulationData getLineName:i]];
        float f=allTotalBurden[11][i/4][i%4]/1000;
        [[bv lbl2] setText:[NSString stringWithFormat:@"%.2f", f]];
        if(finalB[i]){
            [[bv lbl3] setText:@"合"];
            [[bv lbl3] setTextColor:[UIColor redColor]];
        }else{
            [[bv lbl3] setText:@"分"];
            [[bv lbl3] setTextColor:[UIColor greenColor]];
        }
        
        double r1=(double)(arc4random() % 100)/100;
        [[bv lbl4] setText:[NSString stringWithFormat:@"%.2f",r1]];
        
        float f1=allPhaseCurrentList[11][i/4][i%4][0];
        float f2=allPhaseCurrentList[11][i/4][i%4][1];
        float f3=allPhaseCurrentList[11][i/4][i%4][2];
        [[bv lbl5] setText:[NSString stringWithFormat:DISPLAYLINESTR1,f1,f2,f3]];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if(timer){
        [timer invalidate];
    }
}

@end
