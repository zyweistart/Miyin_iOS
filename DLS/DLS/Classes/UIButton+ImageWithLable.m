//
//  UIButtonImageWithLable.m
//  DLS
//
//  Created by Start on 3/3/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "UIButton+ImageWithLable.h"
#define TITLECOLOR  [UIColor colorWithRed:(124/255.0) green:(124/255.0) blue:(124/255.0) alpha:1]

@implementation  UIButton (ImageWithLable)

- (void) setImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType {
    //UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
    [self setTitleColor:TITLECOLOR forState:UIControlStateNormal];
    CGSize titleSize = [title sizeWithFont:[UIFont systemFontOfSize:13.0f]];
    [self.imageView setContentMode:UIViewContentModeCenter];
    [self setImageEdgeInsets:UIEdgeInsetsMake(-10, 6, 0, 0)];
    [self setImage:image forState:stateType];
    
    [self.titleLabel setContentMode:UIViewContentModeCenter];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setTextColor:[UIColor blackColor]];
    [self.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
    float sep=(54-titleSize.width)/2;
    [self setTitleEdgeInsets:UIEdgeInsetsMake(75, -titleSize.width-sep, 0, 0)];
    [self setTitle:title forState:stateType];
}
@end
