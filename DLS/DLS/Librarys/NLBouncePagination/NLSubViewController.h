//
//  NLSubViewController.h
//  DemoBouncePagination
//
//  Created by noahlu on 14-9-5.
//  Copyright (c) 2014年 noahlu<codedancerhua@gmail.com>. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "NLPullDownRefreshView.h"

@interface NLSubViewController : BaseViewController<UIScrollViewDelegate>
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, weak) UIViewController *mainViewController;
@property(nonatomic, strong) NLPullDownRefreshView *pullFreshView;
@end
