//
//  MessageCell.m
//  DLS
//
//  Created by Start on 3/13/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import "MessageCell.h"
#import <QuartzCore/QuartzCore.h>

#define TITLECOLOR [UIColor colorWithRed:(70/255.0) green:(70/255.0) blue:(70/255.0) alpha:1]
#define DATECOLOR [UIColor colorWithRed:(142/255.0) green:(142/255.0) blue:(142/255.0) alpha:1]

@implementation MessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        UIView *mainView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 65)];
        [self addSubview:mainView];
        self.image=[[UIImageView alloc]initWithFrame:CGRectMake1(5.f, 20.f, 10.f, 10.f)];
        self.image.layer.cornerRadius = 5;
        self.image.layer.masksToBounds = YES;
        self.image.layer.borderWidth = 1.0;
        self.image.layer.borderColor = [UIColor redColor].CGColor;
        [self.image setBackgroundColor:[UIColor redColor]];
        [mainView addSubview:self.image];
        self.title=[[UILabel alloc]initWithFrame:CGRectMake1(20, 5, 280, 40)];
        [self.title setFont:[UIFont systemFontOfSize:16]];
        [self.title setTextColor:[UIColor blackColor]];
        [self.title setTextAlignment:NSTextAlignmentLeft];
        [self.title setNumberOfLines:2];
        [mainView addSubview:self.title];
        self.date=[[UILabel alloc]initWithFrame:CGRectMake1(180, 45, 100, 15)];
        [self.date setFont:[UIFont systemFontOfSize:15]];
        [self.date setTextColor:DATECOLOR];
        [self.date setTextAlignment:NSTextAlignmentRight];
        [mainView addSubview:self.date];
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    return self;
}

- (void)setData:(NSDictionary *)data
{
    [self.title setTextColor:TITLECOLOR];
    self.image.layer.borderColor = TITLECOLOR.CGColor;
    [self.image setBackgroundColor:TITLECOLOR];
    
    self.title.text=@"履带吊求租使用一天履带吊求租使用一天履带吊求租使用一天履带吊求租使用一天履带吊求租使用一天履带吊求租使用一天履带吊求租使用一天履带吊求租使用一天";
    self.date.text=@"2015-06-20";
}
@end
