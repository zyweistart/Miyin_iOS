//
//  RenameSensorViewController.h
//  Grall Now
//
//  Created by Yang Shubo on 13-8-28.
//  Copyright (c) 2013年 Yang Shubo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RenameSensorViewController : UIViewController
{
    IBOutlet UITextField *lbName;
    
}
@property (strong, nonatomic) IBOutlet UIButton *OnBtnSave;
- (IBAction)OnBtnClose:(id)sender;
@end
