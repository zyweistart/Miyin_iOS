//
//  MainAppViewController.m
//  helloworld
//
//  Created by chen on 14/7/13.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import "MainAppViewController.h"

#import "SliderViewController.h"
#import "SubViewController.h"
#import "Channel.h"

#define isIos7      ([[[UIDevice currentDevice] systemVersion] floatValue])
#define StatusbarSize ((isIos7 >= 7 && __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1)?20.f:0.f)

#define RGBA(R/*红*/, G/*绿*/, B/*蓝*/, A/*透明*/) \
[UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A]

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
    
    NSMutableArray *navCategory;
}

@end

@implementation MainAppViewController


- (void)viewDidLoad
{
    navCategory=[[NSMutableArray alloc]init];
    Channel *cl=[[Channel alloc]init];
    [cl setKid:1];
    [cl setName:@"头条"];
    [cl setOrderId:@"1"];
    [cl setSelected:@"0"];
    [navCategory addObject:cl];
    cl=[[Channel alloc]init];
    [cl setKid:2];
    [cl setName:@"资讯"];
    [cl setOrderId:@"2"];
    [cl setSelected:@"0"];
    [navCategory addObject:cl];
    cl=[[Channel alloc]init];
    [cl setKid:3];
    [cl setName:@"会讯"];
    [cl setOrderId:@"3"];
    [cl setSelected:@"0"];
    [navCategory addObject:cl];
    cl=[[Channel alloc]init];
    [cl setKid:4];
    [cl setName:@"政策法规"];
    [cl setOrderId:@"4"];
    [cl setSelected:@"0"];
    [navCategory addObject:cl];
    cl=[[Channel alloc]init];
    [cl setKid:5];
    [cl setName:@"标准检测"];
    [cl setOrderId:@"5"];
    [cl setSelected:@"0"];
    [navCategory addObject:cl];
    cl=[[Channel alloc]init];
    [cl setKid:6];
    [cl setName:@"国内展"];
    [cl setOrderId:@"6"];
    [cl setSelected:@"0"];
    [navCategory addObject:cl];
    cl=[[Channel alloc]init];
    [cl setKid:7];
    [cl setName:@"国外展"];
    [cl setOrderId:@"7"];
    [cl setSelected:@"0"];
    [navCategory addObject:cl];
    cl=[[Channel alloc]init];
    [cl setKid:8];
    [cl setName:@"工程招标"];
    [cl setOrderId:@"8"];
    [cl setSelected:@"0"];
    [navCategory addObject:cl];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *statusBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.frame.size.width, 0.f)];
    if (isIos7 >= 7 && __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1)
    {
        statusBarView.frame = CGRectMake(statusBarView.frame.origin.x, statusBarView.frame.origin.y, statusBarView.frame.size.width, 20.f);
        statusBarView.backgroundColor = [UIColor clearColor];
        ((UIImageView *)statusBarView).backgroundColor = RGBA(159,5,13,1);
        [self.view addSubview:statusBarView];
    }
    
    _navView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, StatusbarSize, self.view.frame.size.width, 44.f)];
    ((UIImageView *)_navView).backgroundColor = RGBA(159,5,13,1);
    [self.view insertSubview:_navView belowSubview:statusBarView];
    _navView.userInteractionEnabled = YES;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((_navView.frame.size.width - 200)/2, (_navView.frame.size.height - 40)/2, 200, 40)];
    [titleLabel setText:@"中国照明产业"];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [_navView addSubview:titleLabel];
    
    UIButton *lbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [lbtn setFrame:CGRectMake(10, 2, 40, 40)];
    [lbtn setTitle:@"导航" forState:UIControlStateNormal];
    [lbtn addTarget:self action:@selector(navigationAction:) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:lbtn];
    
    UIButton *rbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rbtn setFrame:CGRectMake(_navView.frame.size.width - 50, 2, 40, 40)];
    [rbtn setTitle:@"用户" forState:UIControlStateNormal];
    [rbtn addTarget:self action:@selector(userAction:) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:rbtn];
    
    _topNaviV = [[UIView alloc] initWithFrame:CGRectMake(0, _navView.frame.size.height + _navView.frame.origin.y, self.view.frame.size.width, MENU_HEIGHT)];
//    [_topNaviV setBackgroundColor:[UIColor greenColor]];
    _topNaviV.backgroundColor = RGBA(236.f, 236.f, 236.f, 1);
    [self.view addSubview:_topNaviV];
    
    _scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _topNaviV.frame.origin.y + _topNaviV.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - _topNaviV.frame.origin.y - _topNaviV.frame.size.height)];
    [_scrollV setPagingEnabled:YES];
    [_scrollV setShowsHorizontalScrollIndicator:NO];
    [self.view insertSubview:_scrollV belowSubview:_navView];
    _scrollV.delegate = self;
    [_scrollV.panGestureRecognizer addTarget:self action:@selector(scrollHandlePan:)];
    
    _selectTabV = [[UIView alloc] initWithFrame:CGRectMake(0, _scrollV.frame.origin.y - _scrollV.frame.size.height, _scrollV.frame.size.width, _scrollV.frame.size.height)];
    [_selectTabV setBackgroundColor:RGBA(236.f, 236.f, 236.f, 1)];
    [_selectTabV setHidden:YES];
    [self.view insertSubview:_selectTabV belowSubview:_navView];
    
    [self createTwo];
}

- (void)createTwo
{
    float btnW = 30;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(_topNaviV.frame.size.width - btnW, 0, btnW, MENU_HEIGHT)];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn setTitle:@"+" forState:UIControlStateNormal];
    [_topNaviV addSubview:btn];
    [btn addTarget:self action:@selector(showSelectView:) forControlEvents:UIControlEventTouchUpInside];
    
    _navScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - btnW, MENU_HEIGHT)];
    [_navScrollV setShowsHorizontalScrollIndicator:NO];
    
    float width=0;
    for (int i = 0; i < [navCategory count]; i++) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(width, 0, MENU_BUTTON_WIDTH, MENU_HEIGHT)];
        [button.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
        [button.titleLabel setTextColor:[UIColor whiteColor]];
        [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
        
        Channel *cl=[navCategory objectAtIndex:i];
        CGSize size = [[cl name] sizeWithFont:button.titleLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, button.frame.size.height)];
        [button setFrame:CGRectMake(width, 0, size.width+16, button.frame.size.height)];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:[cl name] forState:UIControlStateNormal];
        
        button.tag = i + 1;
        [button addTarget:self action:@selector(actionbtn:) forControlEvents:UIControlEventTouchUpInside];
        [_navScrollV addSubview:button];
        width+=button.frame.size.width;
        
    }
    [_navScrollV setContentSize:CGSizeMake(width, MENU_HEIGHT)];
    [_topNaviV addSubview:_navScrollV];
    
    _navBgV = [[UIView alloc] initWithFrame:CGRectMake(0, MENU_HEIGHT - 2, MENU_BUTTON_WIDTH, 2)];
    [_navBgV setBackgroundColor:[UIColor blackColor]];
//    [_navScrollV addSubview:_navBgV];
    
    [self addView2Page:_scrollV count:[navCategory count] frame:CGRectZero];
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

- (void)actionbtn:(UIButton *)btn {
    
    _navScrollV 
    
    [_scrollV scrollRectToVisible:CGRectMake(_scrollV.frame.size.width * (btn.tag - 1), _scrollV.frame.origin.y, _scrollV.frame.size.width, _scrollV.frame.size.height) animated:YES];
    
    float xx = _scrollV.frame.size.width * (btn.tag - 1) * (MENU_BUTTON_WIDTH / self.view.frame.size.width) - MENU_BUTTON_WIDTH;
    [_navScrollV scrollRectToVisible:CGRectMake(xx, 0, _navScrollV.frame.size.width, _navScrollV.frame.size.height) animated:YES];
}

- (void)navigationAction:(UIButton *)btn
{
    if ([_selectTabV isHidden] == NO)
    {
        [self showSelectView:btn];
        return;
    }
    [((SliderViewController *)[[[self.view superview] superview] nextResponder]) showLeftViewController];
}

- (void)userAction:(UIButton *)btn
{
    if ([_selectTabV isHidden] == NO)
    {
        [self showSelectView:btn];
        return;
    }
    [((SliderViewController *)[[[self.view superview] superview] nextResponder]) showRightViewController];
}

- (void)showSelectView:(UIButton *)btn
{
    if ([_selectTabV isHidden] == YES)
    {
        [_selectTabV setHidden:NO];
        [UIView animateWithDuration:0.6 animations:^
         {
             [_selectTabV setFrame:CGRectMake(0, _scrollV.frame.origin.y, _scrollV.frame.size.width, _scrollV.frame.size.height)];
         } completion:^(BOOL finished)
         {
         }];
    }else
    {
        [UIView animateWithDuration:0.6 animations:^
         {
             [_selectTabV setFrame:CGRectMake(0, _scrollV.frame.origin.y - _scrollV.frame.size.height, _scrollV.frame.size.width, _scrollV.frame.size.height)];
         } completion:^(BOOL finished)
         {
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
    }
    else if(_scrollV.contentOffset.x > (_scrollV.contentSize.width - _scrollV.frame.size.width))
    {
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
//    [[QHMainGestureRecognizerViewController getMainGRViewCtrl] addViewController2Main:subViewController];
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
