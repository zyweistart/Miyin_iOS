//
//  NLMainViewController.m
//  DemoBouncePagination
//
//  Created by noahlu on 14-9-5.
//  Copyright (c) 2014年 noahlu<codedancerhua@gmail.com>. All rights reserved.
//

#import "NLMainViewController.h"

@interface NLMainViewController ()
@property(nonatomic, strong)NLPullUpRefreshView *pullFreshView;
@property(nonatomic) NSInteger refreshCounter;
@property(nonatomic) float contentInsetTop;
@end

@implementation NLMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
#ifdef __IPHONE_7_0
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
#endif
    
    self.view.backgroundColor = [UIColor clearColor];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.delegate = self;
    
    [self.view addSubview:self.scrollView];
    
    self.isResponseToScroll = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // make sure scroll enabled
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height + 100);
    [self addRefreshView];
    [self addSubPage];
    
    self.contentInsetTop = self.scrollView.contentInset.top;
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width, self.scrollView.contentSize.height + 100.f);
}

- (void)addRefreshView {
    if (self.pullFreshView == nil) {
        float originY = self.scrollView.contentSize.height;
        self.pullFreshView = [[NLPullUpRefreshView alloc]initWithFrame:CGRectMake(0, originY, self.view.frame.size.width, 50.f)];
        self.pullFreshView.backgroundColor = [UIColor whiteColor];
    }
    
    if (!self.pullFreshView.superview) {
        [self.pullFreshView setupWithOwner:self.scrollView delegate:self];
    }
}

- (void)addSubPage
{
    if (!self.subViewController) {
        return;
    }
    
    self.subViewController.view.frame = CGRectMake(0, self.scrollView.contentSize.height+50, self.view.frame.size.width, self.view.frame.size.height);
    [self.scrollView addSubview:self.subViewController.view];
}

- (void)pullUpRefreshDidFinish
{
    if (!self.refreshCounter) {
        self.refreshCounter = 0;
    }
    
    // 上拉分页动画
    [UIView animateWithDuration:0.3 animations:^{
        self.scrollView.contentInset = UIEdgeInsetsMake(-self.scrollView.contentSize.height-20 + 100.f, 0, 0, 0);
    }];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width, self.scrollView.contentSize.height - 100.f);
    self.isResponseToScroll = NO;
    self.scrollView.scrollEnabled = NO;
    self.subViewController.scrollView.scrollEnabled = YES;
    [self.pullFreshView stopLoading];
    self.pullFreshView.hidden = YES;
}

- (void)pullDownRefreshDidFinish
{
    [self.subViewController.pullFreshView stopLoading];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.scrollView.contentInset = UIEdgeInsetsMake(_contentInsetTop, 0, 0, 0);
        // maintable重绘之后，contentsize要重新加上offset
        self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width, self.scrollView.contentSize.height + 100.f);
    }];
    self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x, self.scrollView.contentOffset.y);
    self.scrollView.scrollEnabled = YES;
    self.subViewController.scrollView.scrollEnabled = NO;
    self.isResponseToScroll = YES;
    self.pullFreshView.hidden = NO;
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.isResponseToScroll) {
        [self.pullFreshView scrollViewWillBeginDragging:scrollView];
    } else {
        [self.subViewController.pullFreshView scrollViewWillBeginDragging:scrollView];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.isResponseToScroll) {
        [self.pullFreshView scrollViewDidScroll:scrollView];
    } else {
        [self.subViewController.pullFreshView scrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (self.isResponseToScroll) {
        [self.pullFreshView scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    } else {
        [self.subViewController.pullFreshView scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.isResponseToScroll) {
        [self.pullFreshView scrollViewDidEndDecelerating:scrollView];
    } else {
    }
}

@end
