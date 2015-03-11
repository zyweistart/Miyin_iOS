//
//  NLSubViewController.m
//  DemoBouncePagination
//
//  Created by noahlu on 14-9-5.
//  Copyright (c) 2014年 noahlu<codedancerhua@gmail.com>. All rights reserved.
//

#import "NLSubViewController.h"

@interface NLSubViewController ()

@end

@implementation NLSubViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.delegate = self;
    self.scrollView.scrollEnabled = NO;
    
    // make sure scroll enabled
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height + 100);
    [self.view addSubview:self.scrollView];
    
    self.scrollView.frame = self.view.bounds;
    self.view.backgroundColor = [UIColor clearColor];
    [self addRefreshView];
}

- (void)addRefreshView {
    if (self.pullFreshView == nil) {
        self.pullFreshView = [[NLPullDownRefreshView alloc]initWithFrame:CGRectMake(0, -50.f, self.view.frame.size.width, 50.f)];
        self.pullFreshView.backgroundColor = [UIColor whiteColor];
    }
    
    if (!self.pullFreshView.superview) {
        [self.pullFreshView setupWithOwner:self.scrollView delegate:(id<NLPullDownRefreshViewDelegate>)self.mainViewController];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.pullFreshView scrollViewWillBeginDragging:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.pullFreshView scrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.pullFreshView scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}



@end
