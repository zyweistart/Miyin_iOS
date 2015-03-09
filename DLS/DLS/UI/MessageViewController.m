//
//  MessageViewController.m
//  DLS
//
//  Created by Start on 3/4/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

- (id)init{
    self=[super init];
    if(self){
        [self setTitle:@"消息中心"];
        //返回
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]
                                               initWithTitle:@"返回"
                                               style:UIBarButtonItemStyleBordered
                                               target:self
                                               action:@selector(goBack:)];
    }
    return self;
}

@end
