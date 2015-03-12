//
//  EquipmentViewController.m
//  DLS
//
//  Created by Start on 3/12/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "EquipmentViewController.h"

@interface EquipmentViewController ()

@end

@implementation EquipmentViewController

- (id)initWithDictionary:(NSDictionary*)data{
    self=[super init];
    if(self){
        self.data=data;
        [self setTitle:@"设备详情"];
    }
    return self;
}

@end
