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
        [self cTitle:@"Tools"];
        
        self.scrollFrameView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
        [self.scrollFrameView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.scrollFrameView setContentSize:CGSizeMake1(320, 190*4)];
        [self.scrollFrameView setBackgroundColor:DEFAULTITLECOLORRGB(65, 51, 42)];
        [self.view addSubview:self.scrollFrameView];
        //针1
        if(self.mChartItemView1==nil){
            self.mChartItemView1=[[ChartItemView alloc]initWithFrame:CGRectMake1(0, 0, 320, 190)];
            [self.scrollFrameView addSubview:self.mChartItemView1];
        }
        //针2
        if(self.mChartItemView2==nil){
            self.mChartItemView2=[[ChartItemView alloc]initWithFrame:CGRectMake1(0, 190, 320, 190)];
            [self.scrollFrameView addSubview:self.mChartItemView2];
        }
        //针3
        if(self.mChartItemView3==nil){
            self.mChartItemView3=[[ChartItemView alloc]initWithFrame:CGRectMake1(0, 380, 320, 190)];
            [self.scrollFrameView addSubview:self.mChartItemView3];
        }
        //针4
        if(self.mChartItemView4==nil){
            self.mChartItemView4=[[ChartItemView alloc]initWithFrame:CGRectMake1(0, 570, 320, 190)];
            [self.scrollFrameView addSubview:self.mChartItemView4];
        }
    }
    return self;
}

- (void)loadData:(NSArray*)array
{
    self.dataItemArray=[[NSMutableArray alloc]initWithArray:array];
    NSDictionary *d1=[array objectAtIndex:0];
    [self.mChartItemView1 loadData:d1];
    NSDictionary *d2=[array objectAtIndex:1];
    [self.mChartItemView2 loadData:d2];
    NSDictionary *d3=[array objectAtIndex:2];
    [self.mChartItemView3 loadData:d3];
    NSDictionary *d4=[array objectAtIndex:3];
    [self.mChartItemView4 loadData:d4];
}

@end
