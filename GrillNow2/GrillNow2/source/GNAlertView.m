//
//  GNAlertView.m
//  Grill Now
//
//  Created by Yang Shubo on 14-7-4.
//  Copyright (c) 2014年 Yang Shubo. All rights reserved.
//

#import "GNAlertView.h"

@interface GNAlertView ()

@end

@implementation GNAlertView

#define VIEW_W 240
#define VIEW_H 270

-(id)initWithText:(NSString*)text Icon:(NSString*)icon Delegate:(id<GNAlertViewDelegate>)delegate
{
    self = [super init];
    CGRect frame = [self getCurrentViewController].view.frame;
    UIView* background = [[UIView alloc] initWithFrame: [self getCurrentViewController].view.frame];
    background.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    [self addSubview:background];
    
    
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width/2-VIEW_W/2, frame.size.height/2-VIEW_H/2, VIEW_W, VIEW_H)];
    view.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    
    UIImageView* iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon ]];
    CGRect iconViewRect =iconView.frame;
    iconViewRect.origin.x =  VIEW_W/2 - CGImageGetWidth(iconView.image.CGImage)/2/iconView.image.scale;
    iconViewRect.origin.y = 10;
    iconView.frame = iconViewRect;
    [view addSubview:iconView];
    
    //a5c075
    
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(5, VIEW_H-55, VIEW_W - 10, 50)];
    btn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    btn.titleLabel.text = @"OK";
    
    [view addSubview:btn];
    
    [self addSubview:view];
    //view.backgroundColor =
    
    return self;
}
 
-(UIViewController*)getCurrentViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

-(void)show
{
    if([cbDelegate respondsToSelector:@selector(GNAlertViewShowing:)])
        [cbDelegate GNAlertViewShowing:self];
    UIViewController* ctl = [self getCurrentViewController];
    [ctl.view addSubview:self];
    if([cbDelegate respondsToSelector:@selector(GNAlertViewShown:)])
        [cbDelegate GNAlertViewShown:self];
}
-(void)hide
{
    if([cbDelegate respondsToSelector:@selector(GNAlertViewHiding:)])
        [cbDelegate GNAlertViewHiding:self];
    [self removeFromSuperview];
    if([cbDelegate respondsToSelector:@selector(GNAlertViewHiden:)])
        [cbDelegate GNAlertViewHiden:self];
}
- (IBAction)onBtnOK:(id)sender {
    if([cbDelegate respondsToSelector:@selector(GNAlertViewHiding:)])
        [cbDelegate GNAlertViewHiding:self];
    [self removeFromSuperview];
    if([cbDelegate respondsToSelector:@selector(GNAlertViewHiden:)])
        [cbDelegate GNAlertViewHiden:self];
}

@end
