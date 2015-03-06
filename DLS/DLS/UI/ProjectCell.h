//
//  ProjectCell.h
//  DLS
//
//  Created by Start on 3/5/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectCell : UITableViewCell

@property UIImageView *image;
@property UILabel *title;
@property UILabel *address;
@property UILabel *money;
@property UILabel *status;

- (void)setStatus:(NSString*)title Type:(int)type;

@end
