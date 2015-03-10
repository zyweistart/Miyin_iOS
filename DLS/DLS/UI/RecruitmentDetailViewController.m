//
//  RecruitmentDetailViewController.m
//  DLS
//  招聘详情
//  Created by Start on 3/9/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "RecruitmentDetailViewController.h"

@interface RecruitmentDetailViewController ()

@end

@implementation RecruitmentDetailViewController

- (id)initWithDictionary:(NSDictionary*)data{
    self=[super init];
    if(self){
        self.data=data;
        [self setTitle:@"招聘详情"];
    }
    return self;
}

@end
