//
//  BurdenContrastViewController.m
//  eClient
//
//  Created by Start on 4/15/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "BurdenContrastViewController.h"

@interface BurdenContrastViewController ()

@end

@implementation BurdenContrastViewController

- (id)init
{
    self=[super init];
    if(self){
        [self setTitle:@"企业负荷"];
        [self buildTableViewWithView:self.view];
    }
    return self;
}

@end
