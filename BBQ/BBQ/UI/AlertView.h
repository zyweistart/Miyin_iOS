//
//  WarningView.h
//  BBQ
//
//  Created by Start on 15/7/29.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertView : UIView

@property (strong,nonatomic)UILabel *lblTitle;
@property (strong,nonatomic)UILabel *lblMessage;
@property (strong,nonatomic)UIButton *button;

- (void)setType:(int)type;

@end
