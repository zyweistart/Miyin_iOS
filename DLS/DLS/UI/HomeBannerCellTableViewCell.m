//
//  HomeBannerCellTableViewCell.m
//  DLS
//
//  Created by Start on 3/3/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "HomeBannerCellTableViewCell.h"

@implementation HomeBannerCellTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithRed:147 green:222 blue:250 alpha:1]];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
