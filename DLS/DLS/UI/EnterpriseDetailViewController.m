//
//  EnterpriseDetailViewController.m
//  DLS
//  企业详情
//  Created by Start on 3/9/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "EnterpriseDetailViewController.h"

@interface EnterpriseDetailViewController ()

@end

@implementation EnterpriseDetailViewController

- (id)initWithDictionary:(NSDictionary*)data{
    self=[super init];
    if(self){
        self.data=data;
        [self setTitle:@"企业详情"];
    }
    return self;
}

@end