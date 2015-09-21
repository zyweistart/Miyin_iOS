//
//  CustomAddTemp.h
//  Grill Now
//
//  Created by Yang Shubo on 13-12-31.
//  Copyright (c) 2013年 Yang Shubo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataCenter.h"
#import "FoodType.h"
@interface CustomAddTemp : UIViewController<UITextFieldDelegate>
{
    IBOutlet UINavigationBar *navBar;
    IBOutlet UINavigationItem *navItem;
    
    IBOutlet UITextField *lbRare;
    
    IBOutlet UITextField *lbMedRare;
    
    IBOutlet UITextField *lbMedium;
    
    IBOutlet UITextField *lbWelldone;
    
    FoodType* foodType;
    
    UITextField* popInputOwn;
}
@property (weak, nonatomic) IBOutlet UILabel *lblRare;
@property (weak, nonatomic) IBOutlet UILabel *lblMedRare;
@property (weak, nonatomic) IBOutlet UILabel *lblMedium;
@property (weak, nonatomic) IBOutlet UILabel *lblWelldone;
@property (weak, nonatomic) IBOutlet UITextField *myFoodName;

-(void)BindFood;
- (IBAction)btnHideKeyborad:(id)sender;

- (IBAction)OnBtnSave:(id)sender;
- (IBAction)OnBtnChangeBack:(id)sender;
-(void)SetFootType:(FoodType*) food;
- (IBAction)btnOK:(id)sender;
- (IBAction)btnDelete:(id)sender;
- (IBAction)btnModify:(id)sender;
 
 

- (IBAction)btnHide:(id)sender;
@end
