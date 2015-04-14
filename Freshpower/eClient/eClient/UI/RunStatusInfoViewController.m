//
//  RunStatusInfoViewController.m
//  eClient
//
//  Created by Start on 4/14/15.
//  Copyright (c) 2015 freshpower. All rights reserved.
//

#import "RunStatusInfoViewController.h"

@interface RunStatusInfoViewController ()

@end

@implementation RunStatusInfoViewController{
    NSString *currentUrl;
}

- (id)initWithUrl:(NSString *)url{
    self=[super init];
    if(self){
        currentUrl=url;
        [self setTitle:@"运行状态"];
        
        UIScrollView *scrollFrame=[[UIScrollView alloc]initWithFrame:self.view.bounds];
        [scrollFrame setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [scrollFrame setContentSize:CGSizeMake1(320, 700)];
        [self.view addSubview:scrollFrame];
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(10, 0, 300, 40)];
        [lbl setText:@"变电站运行监测服务"];
        [lbl setFont:[UIFont systemFontOfSize:15]];
        [lbl setTextColor:[UIColor blackColor]];
        [scrollFrame addSubview:lbl];
        
        
        
        
    }
    return self;
}

@end
