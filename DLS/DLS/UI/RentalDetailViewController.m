//
//  RentalDetailViewController.m
//  DLS
//  出租详情
//  Created by Start on 3/9/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "RentalDetailViewController.h"

@interface RentalDetailViewController ()

@end

@implementation RentalDetailViewController

- (id)initWithDictionary:(NSDictionary*)data{
    self=[super init];
    if(self){
        self.data=data;
        [self setTitle:@"出租详情"];
    }
    return self;
}

@end
