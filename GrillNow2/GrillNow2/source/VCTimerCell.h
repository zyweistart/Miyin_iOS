//
//  VCTimerCell.h
//  Grill Now
//
//  Created by Yang Shubo on 14-3-11.
//  Copyright (c) 2014年 Yang Shubo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Timer.h"


#define MSG_ON_SEL_TIMER @"MSG_ON_SEL_TIMER"

@interface VCTimerCell : UIViewController
{
    
    IBOutlet UILabel *lbNumber;
    IBOutlet UIButton *btnIco;
    
    NSString* text;
}
@property(nonatomic,strong)Timer* timer;
@property(nonatomic)BOOL isSelected;
@property(nonatomic,strong)NSString* timerName;

-(id)initWithTimer:(Timer*)timer Index:(NSString*)index;
-(void)selected:(BOOL)selected;
-(void)setTimerName:(NSString *)timerName;
- (IBAction)onBtnTimer:(id)sender;
@end
