//
//  VCTimerCell.m
//  Grill Now
//
//  Created by Yang Shubo on 14-3-11.
//  Copyright (c) 2014年 Yang Shubo. All rights reserved.
//

#import "VCTimerCell.h"

@interface VCTimerCell ()

@end

@implementation VCTimerCell

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)initWithTimer:(Timer*)timer Index:(NSString*)index
{
    id ret = [super init];
    self.timer = timer;
    text = index;
   
    return ret;
}
- (void)viewDidLoad
{
    [btnIco setImage:[UIImage imageNamed:@"timer_topnav_nomal.png"] forState:UIControlStateNormal];
    //[btnIco setImage:[UIImage imageNamed:@"timer_topnav_hover.png"] forState:UIControlStateHighlighted];
    [btnIco setImage:[UIImage imageNamed:@"timer_topnav_hover.png"] forState:UIControlStateSelected];
    lbNumber.text = text;
    self.timerName = text;
    self.timer.Name = self.timerName;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)selected:(BOOL)selected
{
    [btnIco setSelected:selected];
    _isSelected = selected;
}
-(void)setTimerName:(NSString *)timerName
{
    lbNumber.text = timerName;
    _timerName = timerName;
}
- (IBAction)onBtnTimer:(id)sender {
    
    _isSelected = !_isSelected;
    [self selected:_isSelected];
    [[NSNotificationCenter defaultCenter] postNotificationName:MSG_ON_SEL_TIMER object:self];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
