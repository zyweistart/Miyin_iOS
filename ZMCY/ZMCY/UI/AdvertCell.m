//
//  AdvertCell.m
//  ZMCY
//
//  Created by Start on 15/7/19.
//  Copyright (c) 2015年 Start. All rights reserved.
//

#import "AdvertCell.h"

@implementation AdvertCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(10, 0, 320, 100)];
        [self addSubview:frame];
        self.image=[[UIImageView alloc]initWithFrame:CGRectMake1(10, 10, 300, 80)];
        [self.image setBackgroundColor:[UIColor redColor]];
        [frame addSubview:self.image];
    }
    return self;
}

@end
