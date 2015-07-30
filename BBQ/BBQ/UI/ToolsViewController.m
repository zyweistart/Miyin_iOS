//
//  TimerViewController.m
//  BBQ
//
//  Created by Start on 15/7/27.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "ToolsViewController.h"

@interface ToolsViewController ()

@end

@implementation ToolsViewController

- (id)init{
    self=[super init];
    if(self){
        [self cTitle:NSLocalizedString(@"Tools",nil)];
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"背景3"]]];
        self.scrollFrameView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
        [self.scrollFrameView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.scrollFrameView setBackgroundColor:DEFAULTITLECOLORRGB(65, 51, 42)];
        [self.view addSubview:self.scrollFrameView];
        //针1
        if(self.mChartItemView1==nil){
            self.mChartItemView1=[[ChartItemView alloc]initWithFrame:CGRectMake1(0, 0, 320, 190)];
            [self.mChartItemView1 setTag:1];
            [self.mChartItemView1 setUserInteractionEnabled:YES];
            [self.mChartItemView1 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(frmeChange:)]];
            [self.mChartItemView1 setHidden:YES];
            [self.scrollFrameView addSubview:self.mChartItemView1];
        }
        //针2
        if(self.mChartItemView2==nil){
            self.mChartItemView2=[[ChartItemView alloc]initWithFrame:CGRectMake1(0, 190, 320, 190)];
            [self.mChartItemView2 setTag:2];
            [self.mChartItemView2 setUserInteractionEnabled:YES];
            [self.mChartItemView2 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(frmeChange:)]];
            [self.mChartItemView2 setHidden:YES];
            [self.scrollFrameView addSubview:self.mChartItemView2];
        }
        //针3
        if(self.mChartItemView3==nil){
            self.mChartItemView3=[[ChartItemView alloc]initWithFrame:CGRectMake1(0, 380, 320, 190)];
            [self.mChartItemView3 setTag:3];
            [self.mChartItemView3 setUserInteractionEnabled:YES];
            [self.mChartItemView3 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(frmeChange:)]];
            [self.mChartItemView3 setHidden:YES];
            [self.scrollFrameView addSubview:self.mChartItemView3];
        }
        //针4
        if(self.mChartItemView4==nil){
            self.mChartItemView4=[[ChartItemView alloc]initWithFrame:CGRectMake1(0, 570, 320, 190)];
            [self.mChartItemView4 setTag:4];
            [self.mChartItemView4 setUserInteractionEnabled:YES];
            [self.mChartItemView4 addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(frmeChange:)]];
            [self.mChartItemView4 setHidden:YES];
            [self.scrollFrameView addSubview:self.mChartItemView4];
        }
        //横屏
        self.mChartItemLandView=[[ChartItemLandView alloc]initWithFrame:CGRectMake(0, 0,CGHeight(455),CGWidth(320))];
        [self.mChartItemLandView setUserInteractionEnabled:YES];
        [self.mChartItemLandView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(frmeHide:)]];
        [self.mChartItemLandView setHidden:YES];
        [self.view addSubview:self.mChartItemLandView];
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
}

- (void)loadData:(NSArray*)array
{
    [self.scrollFrameView setContentSize:CGSizeMake1(320, 190*[array count])];
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

- (void)ConnectedState:(BOOL)state
{
    [self.scrollFrameView setHidden:!state];
    [self.mConnectedPanel setHidden:state];
}

- (void)frmeChange:(UIGestureRecognizer*)sender
{
    if(inch35){
        return;
    }
    NSInteger tag=[[sender view]tag];
    [self.mChartItemLandView setHidden:NO];
    CGAffineTransform at =CGAffineTransformMakeRotation(M_PI/2);
    [self.mChartItemLandView setTransform:at];
    [self.mChartItemLandView setCenter:CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2)];
    if(tag==1){
        [self.mChartItemLandView loadData:self.mChartItemView1.currentData];
    }else if(tag==2){
        [self.mChartItemLandView loadData:self.mChartItemView2.currentData];
    }else if(tag==3){
        [self.mChartItemLandView loadData:self.mChartItemView3.currentData];
    }else if(tag==4){
        [self.mChartItemLandView loadData:self.mChartItemView4.currentData];
    }
}

- (void)frmeHide:(id)sender
{
    [self.mChartItemLandView setHidden:YES];
}

@end
