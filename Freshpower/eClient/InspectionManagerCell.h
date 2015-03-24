//
//  InspectionManagerCell.h
//  eClient
//
//  Created by weizhenyao on 15/3/23.
//  Copyright (c) 2015年 freshpower. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVCheckbox.h"
#import "SVButton.h"

@interface InspectionManagerCell : UITableViewCell

@property SVButton *pSend;
@property SVButton *pSetting;

@property SVCheckbox *checkbox1;
@property SVCheckbox *checkbox2;
@property SVCheckbox *checkbox3;
@property SVCheckbox *checkbox4;
@property SVCheckbox *checkbox5;

@property BaseViewController *controller;

@end
