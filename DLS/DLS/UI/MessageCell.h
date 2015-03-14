//
//  MessageCell.h
//  DLS
//
//  Created by Start on 3/13/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCell : UITableViewCell

@property UIImageView *image;
@property UILabel *title;
@property UILabel *date;

- (void)setData:(NSDictionary *)data;
@end
