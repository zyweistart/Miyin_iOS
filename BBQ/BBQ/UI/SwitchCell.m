//
//  SwitchCell.m
//  Ume
//
//  Created by Start on 15/7/21.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "SwitchCell.h"

@implementation SwitchCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.rightButton=[[UIButton alloc]initWithFrame:CGRectMake1(220, 7.5, 89, 30)];
        [self.rightButton setImage:[UIImage imageNamed:@"华氏"] forState:UIControlStateNormal];
        [self.rightButton setImage:[UIImage imageNamed:@"摄氏"] forState:UIControlStateSelected];
//        [self.rightButton addTarget:self action:@selector(goSetSwitch:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.rightButton];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)goSetSwitch:(UIButton*)sender
{
    [sender setSelected:!sender.selected];
    if(sender.selected){
        [[Data Instance] setCf:@"c"];
        
    }else{
        [[Data Instance] setCf:@"f"];
    }
}

@end
