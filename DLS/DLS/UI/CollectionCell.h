//
//  CollectionCell.h
//  DLS
//
//  Created by Start on 3/13/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionCell : UITableViewCell

@property UIButton *more;
@property UILabel *title;
@property UILabel *content;

- (void)setData:(NSDictionary *)data;

@end
