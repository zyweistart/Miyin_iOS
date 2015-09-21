//
//  FoodSelectCell.h
//  Graff Now
//
//  Created by Yang Shubo on 13-8-27.
//  Copyright (c) 2013年 Yang Shubo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodType.h"
@interface FoodSelectCell : UICollectionViewCell
{
    FoodType* ownType;
}
@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (nonatomic,strong) NSMutableArray *foodNameArray;
@property (weak, nonatomic) IBOutlet UILabel *foodName;
@property (nonatomic,assign) int isMyfood;

-(id)initWithFoodType:(FoodType*)type;

-(FoodType*)GetBindData;
-(void)BindObject:(FoodType*)type;
@end
