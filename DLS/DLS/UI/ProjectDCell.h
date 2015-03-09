//
//  ProjectDCell.h
//  DLS
//
//  Created by Start on 3/8/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectDCell : UITableViewCell

@property UILabel *title;
@property UILabel *content;
@property UILabel *money;
@property UILabel *date;
@property UILabel *status;

- (void)setData:(NSDictionary *)data;

@end
