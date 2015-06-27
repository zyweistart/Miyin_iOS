//
//  CollectionDetailViewController.m
//  DLS
//
//  Created by Start on 15/6/27.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "CollectionDetailViewController.h"

@interface CollectionDetailViewController ()

@end

@implementation CollectionDetailViewController

- (id)initWithDictionary:(NSDictionary*)data{
    self=[super init];
    if(self){
        self.data=data;
        NSString *title=[Common getString:[data objectForKey:@"title"]];
        [self setTitle:title];
        NSString *links=[Common getString:[data objectForKey:@"links"]];
        if(![@"" isEqualToString:links]){
            UIWebView *webView=[[UIWebView alloc]initWithFrame:self.view.bounds];
            [webView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
            [self.view addSubview:webView];
            NSLog(@"%@",links);
            NSURL* url = [NSURL URLWithString:links];
            NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
            [webView loadRequest:request];
        }
    }
    return self;
}

@end
