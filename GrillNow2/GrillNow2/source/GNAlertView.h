//
//  GNAlertView.h
//  Grill Now
//
//  Created by Yang Shubo on 14-7-4.
//  Copyright (c) 2014年 Yang Shubo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Marcro.h"
@protocol GNAlertViewDelegate;

@interface GNAlertView : UIView
{
    id<GNAlertViewDelegate> cbDelegate;
}

-(id)initWithText:(NSString*)text Icon:(NSString*)icon Delegate:(id<GNAlertViewDelegate>)delegate;
-(void)show;
-(void)hide;
@end


@protocol GNAlertViewDelegate <NSObject>
@optional
-(void)GNAlertViewShowing:(GNAlertView*)view;
-(void)GNAlertViewShown:(GNAlertView*)view;
-(void)GNAlertViewHiding:(GNAlertView*)view;
-(void)GNAlertViewHiden:(GNAlertView*)view;
@end