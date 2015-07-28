//
//  InfoCell.h
//  BBQ
//
//  Created by Start on 15/7/28.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuCell : UITableViewCell

@property (strong,nonatomic)NSDictionary *data;

@property (strong,nonatomic)UILabel *lblTitle;
@property (strong,nonatomic)UILabel *lblSetTime;
@property (strong,nonatomic)UILabel *lblCurrentCentigrade;
@property (strong,nonatomic)UIButton *lblCurrentSamllCentigrade;
@property (strong,nonatomic)UILabel *lblHighestCentigrade;
@property (strong,nonatomic)UIView *viewCentigrade;

@end
