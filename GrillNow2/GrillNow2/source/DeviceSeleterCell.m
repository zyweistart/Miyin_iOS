//
//  DeviceSeleterCell.m
//  Graff Now
//
//  Created by Yang Shubo on 13-8-26.
//  Copyright (c) 2013年 Yang Shubo. All rights reserved.
//

#import "DeviceSeleterCell.h"

@implementation DeviceSeleterCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //[self.indicatorView stopAnimating];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if(selected)
    {
        [imgBg setImage:[UIImage imageNamed:@"seltemp_hover"]];
    }
    else{
        [imgBg setImage:[UIImage imageNamed:@"seltemp_normal"]];

    }
    //[self.indicatorView startAnimating];
    
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void)SetContent:(NSString*)num Name:(NSString*)name
{
    if(lbText)
        lbText.text = name;
    if(lbNumber)
        lbNumber.text = num;
}

@end
