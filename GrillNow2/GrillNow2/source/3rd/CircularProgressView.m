//
//  CircularProgressView.m
//  CircularProgressView
//
//  Created by nijino saki on 13-3-2.
//  Copyright (c) 2013年 nijino. All rights reserved.
//

#import "CircularProgressView.h"
#import "Math.h"
@interface CircularProgressView ()<AVAudioPlayerDelegate>

@property (strong, nonatomic) UIColor *backColor;
@property (strong, nonatomic) UIColor *progressColor;
@property (assign, nonatomic) CGFloat lineWidth;
@property (assign, nonatomic) float progress;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation CircularProgressView

- (id)initWithFrame:(CGRect)frame
          backColor:(UIColor *)backColor
      progressColor:(UIColor *)progressColor
          lineWidth:(CGFloat)lineWidth 
{
    self = [super initWithFrame:frame];
    if (self) {
        self.CanChange=YES;
        self.IsLoop=NO;
        self.backgroundColor = [UIColor clearColor];
        _backColor = backColor;
        _progressColor = progressColor;
        _lineWidth = lineWidth;
        self.IsPlaying = NO;
        self.maxDuring = 3600;
        self.currentDuring = 0;
        self.maxProgress = 0;
        currentRect = frame;
        UIImage* texture = [UIImage imageNamed:@"timer.png"];
        UIImageView *img = [[UIImageView alloc] initWithImage:texture];
        CGRect f = img.frame;
        
        f.origin = CGPointMake(self.bounds.size.width / 2,self.bounds.size.height / 2) ;
        f.origin.x -=(texture.size.width) /2;
        f.origin.y -=(texture.size.height) /2;
        img.frame = f;
        [self addSubview:img];
        //_player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
    }
    return self;
}
- (void)updateRect
{
    [self drawRect:currentRect];
}
- (void)drawRect:(CGRect)rect
{
    
    currentRect = rect;
    //draw background circle
    UIBezierPath *backCircle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width / 2,self.bounds.size.height / 2) radius:self.bounds.size.width / 3 - self.lineWidth / 2 startAngle:(CGFloat) -M_PI_2 endAngle:(CGFloat)(-M_PI_2 + self.maxProgress * 2 * M_PI) clockwise:YES];  //(CGFloat)(1.5 * M_PI)
    
    [self.backColor setStroke];
    
    backCircle.lineWidth = self.lineWidth;
    [backCircle stroke];
    
    if (self.progress != 0) {
        //draw progress circle
        UIBezierPath *progressCircle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width / 2,self.bounds.size.height / 2) radius:self.bounds.size.width / 3 - self.lineWidth / 4 startAngle:(CGFloat) -M_PI_2 endAngle:(CGFloat)(-M_PI_2 + self.progress * 2 * M_PI) clockwise:YES];
        [self.progressColor setStroke];
        progressCircle.lineWidth = self.lineWidth;
        [progressCircle stroke];
    }
}
-(void)changeCurrentDuring:(UInt32)during
{
    self.currentDuring = (float)during;
    self.progress = self.currentDuring / 3600.0f;
    [self setNeedsDisplay];
}
-(void)changeMaxDuring:(UInt32)during
{
    self.maxDuring = (float)during;
    self.maxProgress = (self.maxDuring / 3600.0f);
    NSLog(@"MaxProcess:%f",self.maxProgress);
    [self setNeedsDisplay]; 
    //[self updateRect];
    //[self updateProgressCircle];
}
- (void)updateProgressCircle{
    //update progress value
    //self.progress = (float) (self.player.currentTime / self.player.duration);
    //redraw back & progress circles
    [self setNeedsDisplay];
    self.progress = (float) (self.currentDuring/ self.maxDuring);
    self.currentDuring+=0.1f;
    
    if(self.currentDuring>=self.maxDuring)
    {
        [self.delegate didFinishProgressView];
        if(self.IsLoop)
        {
            self.currentDuring = 0;
        }
        else{
            self.currentDuring = self.maxDuring;
            self.progress = 1;
            [self.timer invalidate];
            [self setNeedsDisplay];
            return;
        }
    }
    if (self.delegate && [self.delegate conformsToProtocol:@protocol(CircularProgressDelegate)]) {
        [self.delegate didUpdateProgressView];
    }
}
- (void)stop
{
    self.currentDuring = 0;
    self.IsPlaying = NO;
    [self updateProgressCircle];
    [self.timer invalidate];
}
- (void)play{
    
    if (!self.IsPlaying) {
        //alloc timer,interval:0.1 second
        if(self.timer)
        {
            [self.timer invalidate];
            self.timer = NULL;
        }
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(updateProgressCircle) userInfo:nil repeats:YES];
        [self.timer fire];
        self.IsPlaying=YES;
        //[self.player play];
    }
}

- (void)pause{
    if (self.IsPlaying) {
        [self.timer invalidate];
        self.IsPlaying= NO;
    }
}

- (void)revert{
    //[self.player stop];
    //self.player.currentTime = 0;
    [self updateProgressCircle];
} 
- (void)logTouchInfo:(UITouch *)touch {
    CGPoint locInSelf = [touch locationInView:self];
    CGPoint locInWin = [touch locationInView:nil];
    NSLog(@"    touch.locationInView = {%2.3f, %2.3f}", locInSelf.x, locInSelf.y);
    NSLog(@"    touch.locationInWin = {%2.3f, %2.3f}", locInWin.x, locInWin.y);
    NSLog(@"    touch.phase = %ld", (long)touch.phase);
    NSLog(@"    touch.tapCount = %lu", (unsigned long)touch.tapCount);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
}
-(float) Length:(CGPoint) p
{
    return sqrt(p.x*p.x + p.y*p.y);
}

-(float)DotProduct:(CGPoint) pPoint1 p2:(CGPoint)pPoint2
{
    return pPoint1.x * pPoint2.x + pPoint1.y * pPoint2.y;
}

//判断两向量夹角是否大于180°，大于180°返回真，否则返回假
-(bool) AngleLargeThanPi:(CGPoint) pPoint1 p2:(CGPoint)pPoint2
{
    float temp=pPoint1.x * pPoint2.y - pPoint2.x* pPoint1.y;
    return ( temp < 0);
}

//得到两向量的夹角
-(float) AngleBetweenPoints:(CGPoint) pPoint1 p2:(CGPoint)pPoint2
{
    
    float cos_theta = [self DotProduct:pPoint1 p2:pPoint2] / ([self Length:pPoint1 ] * [self Length:pPoint2]);
    if( [self AngleLargeThanPi:pPoint1 p2:pPoint2])
        return 360-acos(cos_theta)*180.0f/3.14f;
    else
        return acos(cos_theta)*180.0f/3.14f;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(self.CanChange==NO)
    {
        return;
    }
    UITouch *touch = [touches anyObject];
 
    CGPoint point = [touch locationInView:self];
    CGPoint p,c ;
    p.x = currentRect.origin.x + currentRect.size.width/2;
    p.y = currentRect.origin.y + currentRect.size.height/2;
    c = p;
    c.x = 0.0f;
    c.y *= -1;
    p.x = point.x - p.x ;
    p.y = point.y - p.y ;

    float angle = [self AngleBetweenPoints:p p2:c];
    angle = 360.0f - angle;
    NSLog(@"self.CurrentMax = %f",angle);
    self.maxProgress = angle / 360.0f;
    self.maxDuring=(self.maxProgress  * 3600.0f);
    self.currentDuring = 0;
    self.progress = 0;
    //if(self.CurrentMax!=NAN)
    [self setNeedsDisplay];
    if (self.delegate && [self.delegate conformsToProtocol:@protocol(CircularProgressDelegate)]) {
        [self.delegate didChangeTime:self.maxDuring];
    }
}
@end
