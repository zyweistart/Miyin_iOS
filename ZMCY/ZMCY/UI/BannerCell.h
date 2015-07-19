//
//  BannerCell.h
//  ZMCY
//
//  Created by Start on 15/7/19.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMBannerView.h"
#import "BaseViewController.h"

@interface BannerCell : UITableViewCell<HMBannerViewDelegate>

@property (strong,nonatomic)HMBannerView *bannerView;
@property (strong,nonatomic)BaseViewController *currentController;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier Data:(NSArray *)data;

@end
