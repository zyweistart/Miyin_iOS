//
//  NewsItemCell.h
//  ZMCY
//
//  Created by Start on 15/7/19.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsItemCell : UITableViewCell

@property (strong,nonatomic)UIImageView *image;
@property (strong,nonatomic)CLabel *lblTitle;
@property (strong,nonatomic)CLabel *lblContent;

@end
