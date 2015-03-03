//
//  HomeBannerCellTableViewCell.m
//  DLS
//
//  Created by Start on 3/3/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "HomeBannerCell.h"

@implementation HomeBannerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *banner=[[UIImageView alloc]initWithFrame:self.bounds];
        [banner setImage:[UIImage imageNamed:@"banner"]];
        [self addSubview:banner];
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
