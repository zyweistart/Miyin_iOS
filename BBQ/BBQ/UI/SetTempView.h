//
//  SetTempView.h
//  BBQ
//
//  Created by Start on 15/7/29.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetTempView : UIView

@property (strong,nonatomic)UILabel *lblTitle;
@property (strong,nonatomic)UILabel *lblValue;
@property (strong,nonatomic)UIButton *cancelButton;
@property (strong,nonatomic)UIButton *okButton;
@property (strong,nonatomic)UISlider *mSlider;

- (void)setValue:(int)value;

@end
