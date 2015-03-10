//
//  QiuzuDetailViewController.m
//  DLS
//  求租详情
//  Created by Start on 3/9/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "QiuzuDetailViewController.h"

@interface QiuzuDetailViewController ()

@end

@implementation QiuzuDetailViewController

- (id)initWithDictionary:(NSDictionary*)data{
    self=[super init];
    if(self){
        self.data=data;
        [self setTitle:@"求租详情"];
    }
    return self;
}


@end
