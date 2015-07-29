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
@property (strong,nonatomic)NSDictionary *currentData;
@property (strong,nonatomic)UILabel *lblTitle;
@property (strong,nonatomic)UILabel *lblSetTime;
@property (strong,nonatomic)UILabel *lblCurrentCentigrade;
@property (strong,nonatomic)UIButton *lblCurrentSamllCentigrade;
@property (strong,nonatomic)UIButton *lblHighestCentigrade;
@property (strong,nonatomic)UIView *viewCentigrade;
@property (strong,nonatomic)UIButton *bTimer;

@property (strong,nonatomic)NSTimer *mTimer;

- (void)setMenuData:(NSDictionary*)data;
- (void)setTimerScheduled;
- (void)refreshData;

@end