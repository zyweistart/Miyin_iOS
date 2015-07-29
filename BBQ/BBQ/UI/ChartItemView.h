//
//  ChartItemView.h
//  BBQ
//
//  Created by Start on 15/7/30.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChartItemView : UIView

@property (strong,nonatomic)NSDictionary *currentData;

@property (strong,nonatomic)UILabel *lblTitle;

- (void)loadData:(NSDictionary*)data;

@end
