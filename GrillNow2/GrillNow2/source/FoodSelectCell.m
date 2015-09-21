//
//  FoodSelectCell.m
//  Graff Now
//
//  Created by Yang Shubo on 13-8-27.
//  Copyright (c) 2013年 Yang Shubo. All rights reserved.
//

#import "FoodSelectCell.h"

@implementation FoodSelectCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)BindObject:(FoodType*)type
{
    self.img.image = [UIImage imageNamed:type.icoImageName];
    self.foodName.text = type.FoodName;
    self.foodName.backgroundColor = [UIColor colorWithRed:0.97f green:0.47f blue:0.02f alpha:1.00f];
    ownType=type;
    
}
-(FoodType*)GetBindData
{
    return ownType;
}
-(id)initWithFoodType:(FoodType*)type
{
    self.img.image = [UIImage imageNamed:type.icoImageName];
     self.foodName.text = type.FoodName;
    self.foodName.backgroundColor = [UIColor colorWithRed:0.97f green:0.47f blue:0.02f alpha:1.00f];
    return [super init];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
