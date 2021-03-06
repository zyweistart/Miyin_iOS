//
//  MessageDetailViewController.m
//  DLS
//  消息详情
//  Created by Start on 3/9/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "MessageDetailViewController.h"

@interface MessageDetailViewController ()

@end

@implementation MessageDetailViewController

- (id)initWithDictionary:(NSDictionary*)data{
    self=[super init];
    if(self){
        self.data=data;
//        "ReadWebMessage{access_token:"access_token_47d1266bf8e91fb94a5888a59fabcac6",messageId:1}"
        NSString *title=[Common getString:[data objectForKey:@"title"]];
        [self setTitle:title];
        NSString *content=[Common getString:[data objectForKey:@"conent"]];
        UITextView *lblContent=[[UITextView alloc]initWithFrame:self.view.bounds];
        [lblContent setFont:[UIFont systemFontOfSize:14]];
        [lblContent setTextColor:DEFAUL1COLOR];
        [lblContent setEditable:NO];
        [self.view addSubview:lblContent];
        [lblContent setText:content];
    }
    return self;
}

@end
