//
//  CircularProgressView.h
//  CircularProgressView
//
//  Created by nijino saki on 13-3-2.
//  Copyright (c) 2013年 nijino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol CircularProgressDelegate;

@interface CircularProgressView : UIView
{
    CGRect currentRect;
}
@property (assign, nonatomic) id <CircularProgressDelegate> delegate;
@property(nonatomic)float maxProgress;
@property(nonatomic)float maxDuring;
@property(nonatomic)float currentDuring;
@property(nonatomic)BOOL IsLoop;
@property(nonatomic)BOOL IsPlaying;
@property(nonatomic)BOOL CanChange;
- (id)initWithFrame:(CGRect)frame
          backColor:(UIColor *)backColor
      progressColor:(UIColor *)progressColor
          lineWidth:(CGFloat)lineWidth;
- (void)play;
- (void)pause;
- (void)revert;
- (void)stop;
- (void)updateRect;

-(void)changeMaxDuring:(UInt32)during;
-(void)changeCurrentDuring:(UInt32)during;

-(float) AngleBetweenPoints:(CGPoint) pPoint1 p2:(CGPoint)pPoint2;
-(bool) AngleLargeThanPi:(CGPoint) pPoint1 p2:(CGPoint)pPoint2;
-(float) Length:(CGPoint) p;
@end

@protocol CircularProgressDelegate <NSObject>

- (void)didUpdateProgressView;
- (void)didFinishProgressView;
-(void)didChangeTime:(double)time;

@end