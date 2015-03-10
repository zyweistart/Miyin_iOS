//
//  ProjectECell.h
//  DLS
//
//  Created by Start on 3/10/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectECell : UITableViewCell

@property UIImageView *image;
@property UILabel *title;
@property UILabel *address;
@property UILabel *money;
@property UILabel *status;
@property UILabel *detail;

- (void)setStatus:(NSString*)title Type:(int)type;

- (void)setData:(NSDictionary *)data;

@end
