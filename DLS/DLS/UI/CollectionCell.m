//
//  CollectionCell.m
//  DLS
//
//  Created by Start on 3/13/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "CollectionCell.h"
#import <QuartzCore/QuartzCore.h>

#define CONTENTCOLOR [UIColor colorWithRed:(210/255.0) green:(210/255.0) blue:(210/255.0) alpha:1]

@implementation CollectionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        UIView *mainView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 90)];
        [self addSubview:mainView];
        self.image=[[UIImageView alloc]initWithFrame:CGRectMake1(285.f, 15.f, 10.f, 10.f)];
        self.image.layer.cornerRadius = 5;
        self.image.layer.masksToBounds = YES;
        self.image.layer.borderWidth = 1.0;
        self.image.layer.borderColor = [UIColor redColor].CGColor;
        [self.image setBackgroundColor:[UIColor redColor]];
        [mainView addSubview:self.image];
        self.title=[[UILabel alloc]initWithFrame:CGRectMake1(10, 5, 250, 25)];
        [self.title setFont:[UIFont systemFontOfSize:18]];
        [self.title setTextColor:[UIColor blackColor]];
        [self.title setTextAlignment:NSTextAlignmentLeft];
        [mainView addSubview:self.title];
        self.content=[[UILabel alloc]initWithFrame:CGRectMake1(10, 30, 300, 55)];
        [self.content setFont:[UIFont systemFontOfSize:14]];
        [self.content setTextColor:CONTENTCOLOR];
        [self.content setTextAlignment:NSTextAlignmentLeft];
        [self.content setNumberOfLines:0];
        [mainView addSubview:self.content];
    }
    return self;
}

- (void)setData:(NSDictionary *)data
{
    self.title.text=@"这是标题你知道么这是收藏的";
    self.content.text=@"履带吊求租使用一天履带吊求租使用一天履带吊求租使用一天履带吊求租使用一天履带吊求租使用一天履带吊求租使用一天履带吊求租使用一天履带吊求租使用一天";
}
@end
