//
//  TimerViewController.m
//  BBQ
//
//  Created by Start on 15/7/27.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "ToolsViewController.h"
//#import "UIScrollView+UITouch.h"

@interface ToolsViewController ()

@end

@implementation ToolsViewController{
    BOOL isAddFlag;
}

- (id)init{
    self=[super init];
    if(self){
        [self cTitle:LOCALIZATION(@"Tools")];
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"背景3"]]];
        self.scrollFrameView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
        [self.scrollFrameView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.scrollFrameView setUserInteractionEnabled:YES];
        [self.scrollFrameView setBackgroundColor:DEFAULTITLECOLORRGB(65, 51, 42)];
        [self.scrollFrameView setDelegate:self];
        [self.view addSubview:self.scrollFrameView];
        //针1
        if(self.mChartItemView1==nil){
            self.mChartItemView1=[self createChartItemViewWithX:0 Tag:1];
        }
        //针2
        if(self.mChartItemView2==nil){
            self.mChartItemView2=[self createChartItemViewWithX:190 Tag:2 ];
        }
        //针3
        if(self.mChartItemView3==nil){
            self.mChartItemView3=[self createChartItemViewWithX:380 Tag:3];
        }
        //针4
        if(self.mChartItemView4==nil){
            self.mChartItemView4=[self createChartItemViewWithX:570 Tag:4];
        }
        //横屏
        CGRect rect;
        if(inch35){
            rect=CGRectMake(0, 0,CGHeight(448),CGWidth(266));
        }else{
            rect=CGRectMake(0, 0,CGHeight(512),CGWidth(304));
        }
        self.mChartItemLandView=[[ChartItemLandView alloc]initWithFrame:rect];
        [self.mChartItemLandView setUserInteractionEnabled:YES];
        [self.mChartItemLandView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(frmeHide:)]];
        [self.mChartItemLandView setHidden:YES];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(![[Data Instance]isDemo]){
        if (self.appDelegate.bleManager.activePeripheral){
            if(self.appDelegate.bleManager.activePeripheral.state==CBPeripheralStateConnected){
                [self ConnectedState:YES];
            }else{
                [self ConnectedState:NO];
            }
        }
    }
    if(!isAddFlag){
        [[[Data Instance]mTabBarFrameViewController].view insertSubview:self.mChartItemLandView atIndex:2];
        isAddFlag=YES;
    }
}

- (void)loadData:(NSArray*)array
{
    if([array count]==0){
        [self.scrollFrameView setHidden:YES];
        [self.mConnectedPanel setHidden:NO];
        [self.lblMessage setText:LOCALIZATION(@"Plase insert probes")];
        return;
    }
    [self.scrollFrameView setContentSize:CGSizeMake1(320, 190*[array count])];
    [self.mChartItemView1 setHidden:YES];
    [self.mChartItemView2 setHidden:YES];
    [self.mChartItemView3 setHidden:YES];
    [self.mChartItemView4 setHidden:YES];
    for(int i=0;i<[array count];i++){
        if(i==0){
            NSDictionary *d1=[array objectAtIndex:0];
            [self.mChartItemView1 loadData:d1];
            [self.mChartItemView1 setHidden:NO];
        }else if(i==1){
            NSDictionary *d2=[array objectAtIndex:1];
            [self.mChartItemView2 loadData:d2];
            [self.mChartItemView2 setHidden:NO];
        }else if(i==2){
            NSDictionary *d3=[array objectAtIndex:2];
            [self.mChartItemView3 loadData:d3];
            [self.mChartItemView3 setHidden:NO];
        }else if(i==3){
            NSDictionary *d4=[array objectAtIndex:3];
            [self.mChartItemView4 loadData:d4];
            [self.mChartItemView4 setHidden:NO];
        }
    }
}

- (void)refreshView
{
    [self.mChartItemView1 loadChartData];
    [self.mChartItemView2 loadChartData];
    [self.mChartItemView3 loadChartData];
    [self.mChartItemView4 loadChartData];
    [self.mChartItemLandView loadChartData];
}

- (void)ConnectedState:(BOOL)state
{
    [self.scrollFrameView setHidden:!state];
    [self.mConnectedPanel setHidden:state];
    [self.lblMessage setText:LOCALIZATION(@"Connection is broken")];
}

- (void)frmeChange:(UIGestureRecognizer*)sender
{
    NSInteger tag=[[sender view]tag];
    [self.mChartItemLandView setHidden:NO];
    CGAffineTransform at =CGAffineTransformMakeRotation(M_PI/2);
    [self.mChartItemLandView setTransform:at];
    CGFloat width=[[Data Instance]mTabBarFrameViewController].view.bounds.size.width;
    CGFloat height=[[Data Instance]mTabBarFrameViewController].view.bounds.size.height;
    [self.mChartItemLandView setCenter:CGPointMake(width/2,height/2)];
    if(tag==1){
        [self.mChartItemLandView loadData:self.mChartItemView1.currentData];
    }else if(tag==2){
        [self.mChartItemLandView loadData:self.mChartItemView2.currentData];
    }else if(tag==3){
        [self.mChartItemLandView loadData:self.mChartItemView3.currentData];
    }else if(tag==4){
        [self.mChartItemLandView loadData:self.mChartItemView4.currentData];
    }
    if([@"T1" isEqualToString:self.mChartItemLandView.currentKey]){
        self.mChartItemLandView.lineChartView.max=250;
    }else if([@"T2" isEqualToString:self.mChartItemLandView.currentKey]){
        self.mChartItemLandView.lineChartView.max=250;
    }else if([@"T3" isEqualToString:self.mChartItemLandView.currentKey]){
        self.mChartItemLandView.lineChartView.max=250;
    }else if([@"T4" isEqualToString:self.mChartItemLandView.currentKey]){
        self.mChartItemLandView.lineChartView.max=537;
    }
    [self.mChartItemLandView loadChartData];
}

- (void)frmeHide:(id)sender
{
    [self.mChartItemLandView setHidden:YES];
}

- (ChartItemView*)createChartItemViewWithX:(CGFloat)x Tag:(NSInteger)tag
{
    ChartItemView *mChartItemView=[[ChartItemView alloc]initWithFrame:CGRectMake1(0, x, 320, 190)];
    [mChartItemView setTag:tag];
    [mChartItemView setUserInteractionEnabled:YES];
    [mChartItemView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(frmeChange:)]];
    [mChartItemView setHidden:YES];
    [self.scrollFrameView addSubview:mChartItemView];
    return mChartItemView;
}

- (void)changeLanguageText
{
    [self cTitle:LOCALIZATION(@"Tools")];
    [self setTitle:LOCALIZATION(@"Tools")];
    [self.mChartItemView1 setLanguage];
    [self.mChartItemView2 setLanguage];
    [self.mChartItemView3 setLanguage];
    [self.mChartItemView4 setLanguage];
    [self.mChartItemLandView setLanguage];
}

- (void)closeAll
{
    [self.mChartItemView1 closeAll];
    [self.mChartItemView2 closeAll];
    [self.mChartItemView3 closeAll];
    [self.mChartItemView4 closeAll];
    [self.mChartItemLandView closeAll];
}

@end
