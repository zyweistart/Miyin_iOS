//
//  FootTemperatureList.h
//  Grill Now
//
//  Created by Yang Shubo on 13-9-4.
//  Copyright (c) 2013年 Yang Shubo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataCenter.h"
@interface FootTemperatureList : UIViewController
{
    IBOutlet UILabel *lbRare;
    IBOutlet UILabel *lbMedRare;
    IBOutlet UILabel *lbMedium;
    IBOutlet UILabel *lbWelldone;
    
    FoodType* foodType;
}

-(id)initWithFood:(FoodType*)food;

- (IBAction)OnBtnCancel:(id)sender;
- (IBAction)OnRareBtn:(id)sender;
- (IBAction)OnMediumBtn:(id)sender;
- (IBAction)OnWelldoneBtn:(id)sender;
- (IBAction)OnMedRareBtn:(id)sender;


@end
