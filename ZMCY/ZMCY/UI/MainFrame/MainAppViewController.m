//
//  MainAppViewController.m
//  helloworld
//
//  Created by chen on 14/7/13.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "MainAppViewController.h"
#import "SliderViewController.h"
#import "MainViewController.h"
#import "QHMainGestureRecognizerViewController.h"

#define MENU_HEIGHT 25
#define MENU_BUTTON_WIDTH  60

@interface MainAppViewController ()<UIScrollViewDelegate>
{
    UIView *_navView;
    UIView *_topNaviV;
    UIScrollView *_scrollV;
    
    UIScrollView *_navScrollV;
    UIView *_navBgV;
    
    float _startPointX;
    UIView *_selectTabV;
}

@end

@implementation MainAppViewController

- (id)init
{
    self=[super init];
    if(self){
        [self cTitle:@"照明产业"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _navView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 20.0f, self.view.frame.size.width, 44.f)];
    ((UIImageView *)_navView).backgroundColor = DEFAULTITLECOLORRGB(159,5,13);
//    [self.view insertSubview:_navView belowSubview:statusBarView];
    _navView.userInteractionEnabled = YES;
    
    _topNaviV = [[UIView alloc] initWithFrame:CGRectMake(0, _navView.frame.size.height + _navView.frame.origin.y, self.view.frame.size.width, MENU_HEIGHT)];
//    [_topNaviV setBackgroundColor:[UIColor greenColor]];
    _topNaviV.backgroundColor = DEFAULTITLECOLOR(236.0f);
    [self.view addSubview:_topNaviV];
    
    _scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _topNaviV.frame.origin.y + _topNaviV.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - _topNaviV.frame.origin.y - _topNaviV.frame.size.height)];
    [_scrollV setPagingEnabled:YES];
    [_scrollV setShowsHorizontalScrollIndicator:NO];
    [self.view insertSubview:_scrollV belowSubview:_navView];
    _scrollV.delegate = self;
    [_scrollV.panGestureRecognizer addTarget:self action:@selector(scrollHandlePan:)];
    
    _selectTabV = [[UIView alloc] initWithFrame:CGRectMake(0, _scrollV.frame.origin.y - _scrollV.frame.size.height, _scrollV.frame.size.width, _scrollV.frame.size.height)];
    
    [_selectTabV setBackgroundColor:DEFAULTITLECOLOR(236.0f)];
    [_selectTabV setHidden:YES];
    [self.view insertSubview:_selectTabV belowSubview:_navView];
    
    [self createTwo];
}

- (void)createTwo
{
    float btnW = 30;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(_topNaviV.frame.size.width - btnW, 0, btnW, MENU_HEIGHT)];
//    [btn setBackgroundColor:[UIColor redColor]];
    [btn setTitle:@"+" forState:UIControlStateNormal];
    [_topNaviV addSubview:btn];
    [btn addTarget:self action:@selector(showSelectView:) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *arT = @[@"头条", @"资讯", @"会讯", @"政策法规", @"标准检测", @"国内"];
    _navScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - btnW, MENU_HEIGHT)];
    [_navScrollV setShowsHorizontalScrollIndicator:NO];
    for (int i = 0; i < [arT count]; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(MENU_BUTTON_WIDTH * i, 0, MENU_BUTTON_WIDTH, MENU_HEIGHT)];
        [btn setTitle:[arT objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        btn.tag = i + 1;
        [btn addTarget:self action:@selector(actionbtn:) forControlEvents:UIControlEventTouchUpInside];
        [_navScrollV addSubview:btn];
    }
    [_navScrollV setContentSize:CGSizeMake(MENU_BUTTON_WIDTH * [arT count], MENU_HEIGHT)];
    [_topNaviV addSubview:_navScrollV];
    
    _navBgV = [[UIView alloc] initWithFrame:CGRectMake(0, MENU_HEIGHT - 2, MENU_BUTTON_WIDTH, 2)];
    [_navBgV setBackgroundColor:NAVBG];
    [_navScrollV addSubview:_navBgV];
    
    [self addView2Page:_scrollV count:[arT count] frame:CGRectZero];
}

- (void)addView2Page:(UIScrollView *)scrollV count:(NSUInteger)pageCount frame:(CGRect)frame
{
    for (int i = 0; i < pageCount; i++)
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(scrollV.frame.size.width * i, 0, scrollV.frame.size.width, scrollV.frame.size.height)];
        view.tag = i + 1;
        
        UILabel *signalLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x - 80, self.view.center.y - 130, 160, 90)];
        signalLabel.text = [NSString stringWithFormat:@"%d", (int)view.tag];
        signalLabel.textAlignment = NSTextAlignmentCenter;
        signalLabel.contentMode = UIViewContentModeScaleAspectFill;
        [signalLabel setBackgroundColor:[UIColor clearColor]];
        [signalLabel setTextColor:[UIColor blackColor]];
        [signalLabel setFont:[UIFont systemFontOfSize:20]];
        [view addSubview:signalLabel];
        signalLabel.userInteractionEnabled = YES;
        signalLabel.layer.borderWidth = 1;
        signalLabel.layer.borderColor = [UIColor blueColor].CGColor;
        
        UITapGestureRecognizer *singleTapRecognizer = [[UITapGestureRecognizer alloc] init];
        singleTapRecognizer.numberOfTapsRequired = 1;
        [singleTapRecognizer addTarget:self action:@selector(pust2View:)];
        [signalLabel addGestureRecognizer:singleTapRecognizer];
        
        [scrollV addSubview:view];
    }
    [scrollV setContentSize:CGSizeMake(scrollV.frame.size.width * pageCount, scrollV.frame.size.height)];
}

- (void)changeView:(float)x
{
    float xx = x * (MENU_BUTTON_WIDTH / self.view.frame.size.width);
    [_navBgV setFrame:CGRectMake(xx, _navBgV.frame.origin.y, _navBgV.frame.size.width, _navBgV.frame.size.height)];
}

#pragma mark - action

- (void)actionbtn:(UIButton *)btn
{
    [_scrollV scrollRectToVisible:CGRectMake(_scrollV.frame.size.width * (btn.tag - 1), _scrollV.frame.origin.y, _scrollV.frame.size.width, _scrollV.frame.size.height) animated:YES];
    
    float xx = _scrollV.frame.size.width * (btn.tag - 1) * (MENU_BUTTON_WIDTH / self.view.frame.size.width) - MENU_BUTTON_WIDTH;
    [_navScrollV scrollRectToVisible:CGRectMake(xx, 0, _navScrollV.frame.size.width, _navScrollV.frame.size.height) animated:YES];
}

- (void)showSelectView:(UIButton *)btn
{
    if ([_selectTabV isHidden] == YES)
    {
        [_selectTabV setHidden:NO];
        [UIView animateWithDuration:0.6 animations:^ {
             [_selectTabV setFrame:CGRectMake(0, _scrollV.frame.origin.y, _scrollV.frame.size.width, _scrollV.frame.size.height)];
         } completion:^(BOOL finished){
         }];
    } else {
        [UIView animateWithDuration:0.6 animations:^
         {
             [_selectTabV setFrame:CGRectMake(0, _scrollV.frame.origin.y - _scrollV.frame.size.height, _scrollV.frame.size.width, _scrollV.frame.size.height)];
         } completion:^(BOOL finished) {
             [_selectTabV setHidden:YES];
         }];
    }
}

-(void)scrollHandlePan:(UIPanGestureRecognizer*) panParam
{
    BOOL isPaning = NO;
    if(_scrollV.contentOffset.x < 0)
    {
        isPaning = YES;
//        isLeftDragging = YES;
//        [self showMask];
    } else if(_scrollV.contentOffset.x > (_scrollV.contentSize.width - _scrollV.frame.size.width)) {
        isPaning = YES;
//        isRightDragging = YES;
//        [self showMask];
    }
    if(isPaning)
    {
        [((SliderViewController *)[[[self.view superview] superview] nextResponder]) moveViewWithGesture:panParam];
    }
}

- (void)pust2View:(UITapGestureRecognizer *)tap
{
//    CGPoint point = [tap locationInView:_scrollV];
//    int t = point.x/_scrollV.frame.size.width + 1;
//    SubViewController *subViewController = [[SubViewController alloc] initWithFrame:[UIScreen mainScreen].bounds andSignal:@""];
//    MainViewController *mMainViewController=[[MainViewController alloc]init];
//    [[QHMainGestureRecognizerViewController getMainGRViewCtrl] addViewController2Main:mMainViewController];
//    subViewController.szSignal = [NSString stringWithFormat:@"%d--%d", t, subViewController.view.tag];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _startPointX = scrollView.contentOffset.x;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self changeView:scrollView.contentOffset.x];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float xx = scrollView.contentOffset.x * (MENU_BUTTON_WIDTH / self.view.frame.size.width) - MENU_BUTTON_WIDTH;
    [_navScrollV scrollRectToVisible:CGRectMake(xx, 0, _navScrollV.frame.size.width, _navScrollV.frame.size.height) animated:YES];
}

@end
