//
//  VCTimerIntroduce.h
//  Grill Now
//
//  Created by Yang Shubo on 14-3-17.
//  Copyright (c) 2014年 Yang Shubo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VCTimerIntroduce : UIViewController
{
    NSArray* view;
    NSArray* imgs;
    IBOutlet UIImageView *uiImage;
    NSInteger curIndex;
    
    
    UIImageView* curImage;
}
- (IBAction)onBtnNext:(id)sender;


-(id)initWithView:(NSArray*) views Images:(NSArray*)images;
@end
