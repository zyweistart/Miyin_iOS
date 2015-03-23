//
//  InspectionSettingViewController.m
//  eClient
//  巡检任务设置
//  Created by weizhenyao on 15/3/23.
//  Copyright (c) 2015年 freshpower. All rights reserved.
//

#import "InspectionSettingViewController.h"

@interface InspectionSettingViewController ()

@end

@implementation InspectionSettingViewController

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"巡检设置"];
        [self buildTableViewWithView:self.view];
    }
    return self;
}

@end
