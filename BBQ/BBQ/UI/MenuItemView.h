//
//  MenuItemView.h
//  BBQ
//
//  Created by Start on 15/7/29.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuItemView : UIView

@property (strong,nonatomic)UIViewController *baseController;

@property (strong,nonatomic)UIView *frameView;
@property (strong,nonatomic)NSDictionary *currentData;
@property (strong,nonatomic)UILabel *lblTitle;
@property (strong,nonatomic)UILabel *lblSetTime;
@property (strong,nonatomic)UILabel *lblCurrentCentigrade;
@property (strong,nonatomic)UIButton *lblCurrentSamllCentigrade;
@property (strong,nonatomic)UIButton *lblHighestCentigrade;
@property (strong,nonatomic)UIView *viewCentigrade;
@property (strong,nonatomic)UIButton *bTimer;

@property (strong,nonatomic)UILabel *lblCurrent;
@property (strong,nonatomic)UILabel *lblCurrentTemp;
@property (strong,nonatomic)UILabel *lblSet;
@property (strong,nonatomic)UILabel *lblSetTemp;
@property (strong,nonatomic)UIView *lineViewFrame;
@property (strong,nonatomic)UIView *lineView;

@property (strong,nonatomic)NSTimer *mTimer;

@property CGFloat scale;

- (void)setMenuData:(NSDictionary*)data;
- (void)setTimerScheduled;
- (void)refreshData;
- (void)showTimerString:(NSString*)key;
- (void)setLanguage;

@end
