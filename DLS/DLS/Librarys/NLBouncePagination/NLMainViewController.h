//
//  NLMainViewController.h
//  DemoBouncePagination
//
//  Created by noahlu on 14-9-5.
//  Copyright (c) 2014年 noahlu<codedancerhua@gmail.com>. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NLSubViewController.h"
#import "NLPullUpRefreshView.h"

@interface NLMainViewController : UIViewController<NLPullDownRefreshViewDelegate, NLPullUpRefreshViewDelegate, UIScrollViewDelegate>

@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) NLSubViewController *subViewController;
@property(nonatomic) BOOL isResponseToScroll;

@end
