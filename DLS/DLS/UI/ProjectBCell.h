//
//  ProjectBCell.h
//  DLS
//
//  Created by Start on 3/8/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectBCell : UITableViewCell

@property UIImageView *image;
@property UILabel *title;
@property UILabel *money;

- (void)setData:(NSDictionary *)data;

@end
