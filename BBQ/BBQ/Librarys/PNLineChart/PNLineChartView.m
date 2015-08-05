#import "PNLineChartView.h"
#import "PNPlot.h"
#import <math.h>
#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>

#pragma mark -
#pragma mark MACRO

#define POINT_CIRCLE 1.0f
//#define DEVICE_WIDTH CGWidth(320)
#define FLOAT_NUMBER_FORMATTER_STRING  @"%.2f"

@interface PNLineChartView ()
//字体名称
@property (nonatomic, strong) NSString* fontName;

@end


@implementation PNLineChartView{
    CGFloat mOffsetX;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       [self setInitValue];
    }
    return self;
}

- (void)setInitValue
{
    self.fontName=@"Helvetica";
    self.xAxisFontSize = 10;
    self.xAxisFontColor = DEFAULTITLECOLOR(154);
    self.horizontalLinesColor = DEFAULTITLECOLOR(74);
    self.axisLineWidth = CGWidth(1);
    self.axisLeftLineWidth = CGWidth(25);
    self.axisBottomLinetHeight = CGHeight(20);
    self.pointerInterval = CGWidth(20);
    self.horizontalLineWidth = CGWidth(0.2);
    self.numberOfVerticalElements=13;
    self.horizontalLineInterval=(self.frame.size.height-self.axisBottomLinetHeight-10)/self.numberOfVerticalElements;
    self.axisLineSizeWidth=self.frame.size.width-self.axisLeftLineWidth;
    self.isAutoOffset=YES;
}

#pragma mark -
#pragma mark Plots

- (void)addPlot:(PNPlot *)newPlot;
{
    if(nil == newPlot ) {
        return;
    }
    if (newPlot.plottingValues.count ==0) {
//        return;
    }
    if(self.plots == nil){
        _plots = [NSMutableArray array];
    }
    [self.plots addObject:newPlot];
    
    [self setNeedsDisplay];
}

- (void)clearPlot
{
    if (self.plots) {
        [self.plots removeAllObjects];
        [self setNeedsDisplay];
    }
}

#pragma mark -
#pragma mark Draw the lineChart

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGFloat startWidth = self.axisLeftLineWidth;
    CGFloat startHeight = self.axisBottomLinetHeight;
    CGContextRef context = UIGraphicsGetCurrentContext();
    //坐标移动到(0,self.bounds.size.height)
    CGContextTranslateCTM(context, 0.0f , self.bounds.size.height);
    //
    CGContextScaleCTM(context,1,-1);
    // set text size and font
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextSelectFont(context,[self.fontName UTF8String],self.xAxisFontSize, kCGEncodingMacRoman);
    // 绘制x轴
    CGFloat w=self.frame.size.width-startWidth;
    int horizontalCount=w/self.horizontalLineInterval;
    if((w-(horizontalCount*self.horizontalLineInterval))>0){
        horizontalCount++;
    }
    CGFloat lineHeight=startHeight+self.numberOfVerticalElements*self.horizontalLineInterval;
    for (int i=0; i<=horizontalCount;i++) {
        int height =self.horizontalLineInterval*i;
        float horizontalLine = height + startWidth;
        //设置y轴水平线宽
        CGContextSetLineWidth(context, self.horizontalLineWidth);
        //设置y轴水平线颜色
        [self.horizontalLinesColor set];
        CGContextMoveToPoint(context, horizontalLine, startHeight);
        CGContextAddLineToPoint(context, horizontalLine, lineHeight);
        CGContextStrokePath(context);
    }
    // 绘制y轴
    CGFloat lineWidth=startWidth+(horizontalCount-1)*self.horizontalLineInterval;
    for (int i=0; i<=self.numberOfVerticalElements;i++) {
        int height =self.horizontalLineInterval*i;
        float verticalLine = height + startHeight - self.contentScroll.y;
        //设置y轴水平线宽
        CGContextSetLineWidth(context, self.horizontalLineWidth);
        //设置y轴水平线颜色
        [self.horizontalLinesColor set];
        CGContextMoveToPoint(context, startWidth, verticalLine);
        CGContextAddLineToPoint(context, lineWidth, verticalLine);
        CGContextStrokePath(context);
        NSNumber* yAxisVlue = [self.yAxisValues objectAtIndex:i];
        NSString *numberString = [NSString stringWithFormat:@"%d",yAxisVlue.intValue];
        NSInteger count = [numberString lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
        
        UIFont *font = [UIFont fontWithName:self.fontName size:self.xAxisFontSize];
        CGSize fontSize = [numberString sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil]];
        CGContextShowTextAtPoint(context, self.axisLeftLineWidth/2-fontSize.width/2, verticalLine - self.xAxisFontSize/2, [numberString UTF8String], count);
    }
    mOffsetX=self.contentScroll.x;
    //曲线的总长
    float lineTotalLength=self.pointerInterval*[self.xAxisValues count] + startWidth;
    //图表显示界的长度
    CGFloat width=self.bounds.size.width-startWidth;
    if(self.isAutoOffset){
        //没有偏移的情况下
        if(lineTotalLength>width){
            mOffsetX=width-lineTotalLength;
        }
    }
    // draw lines
    for (int i=0; i<self.plots.count; i++) {
        PNPlot* plot = [self.plots objectAtIndex:i];
        [plot.lineColor set];
        CGContextSetLineWidth(context, plot.lineWidth);
        NSArray* pointArray = plot.plottingValues;
        // draw lines
        for (int i=0; i<pointArray.count; i++) {
            NSNumber* value = [pointArray objectAtIndex:i];
            float floatValue = value.floatValue;
            float height = (floatValue-self.min)/self.interval*self.horizontalLineInterval-self.contentScroll.y+startHeight;
            float width =self.pointerInterval+self.pointerInterval*(i+1)/10+mOffsetX+ startWidth;
            if (width<startWidth) {
                NSNumber* nextValue = [pointArray objectAtIndex:i+1];
                float nextFloatValue = nextValue.floatValue;
                float nextHeight = (nextFloatValue-self.min)/self.interval*self.horizontalLineInterval+startHeight;
                CGContextMoveToPoint(context, startWidth, nextHeight);
                continue;
            }
            if (i==0) {
                CGContextMoveToPoint(context,width,height);
            } else{
                CGContextAddLineToPoint(context,width,height);
            }
        }
        CGContextStrokePath(context);
        // draw pointer
        for (int i=0; i<pointArray.count; i++) {
            NSNumber* value = [pointArray objectAtIndex:i];
            float floatValue = value.floatValue;
            float height = (floatValue-self.min)/self.interval*self.horizontalLineInterval-self.contentScroll.y+startHeight;
            float width =self.pointerInterval+self.pointerInterval*(i+1)/10+mOffsetX+ startWidth;
            if (width>startWidth) {
                CGContextFillEllipseInRect(context, CGRectMake(width-POINT_CIRCLE/2, height-POINT_CIRCLE/2, POINT_CIRCLE, POINT_CIRCLE));
            }
        }
        CGContextStrokePath(context);
    }
    
    [self.xAxisFontColor set];
    CGContextSetLineWidth(context, self.axisLineWidth);
    //y轴
    CGContextMoveToPoint(context, startWidth, startHeight);
    CGContextAddLineToPoint(context, startWidth, self.bounds.size.height);
    CGContextStrokePath(context);
    //x轴
    CGContextMoveToPoint(context, startWidth, startHeight);
    CGContextAddLineToPoint(context, self.bounds.size.width, startHeight);
    CGContextStrokePath(context);
    for (int i=0; i<self.xAxisValues.count; i++) {
        float width =self.pointerInterval*(i+1)+mOffsetX+ startHeight;
        float height = self.xAxisFontSize;
        if (width<startWidth) {
            continue;
        }
        NSInteger count = [[self.xAxisValues objectAtIndex:i] lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
        CGContextShowTextAtPoint(context, width, height,[[self.xAxisValues objectAtIndex:i] UTF8String], count);
    }
}

#pragma mark -
#pragma mark touch handling
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGFloat lineOffsetX=self.pointerInterval*self.xAxisValues.count;
    if(self.isAutoOffset){
        _contentScroll.x=-(lineOffsetX-self.axisLineSizeWidth);
    }
    self.isAutoOffset=NO;
    CGPoint touchLocation=[[touches anyObject] locationInView:self];
    CGPoint prevouseLocation=[[touches anyObject] previousLocationInView:self];
    float xDiffrance=touchLocation.x-prevouseLocation.x;
    float yDiffrance=touchLocation.y-prevouseLocation.y;
    _contentScroll.x+=xDiffrance;
    _contentScroll.y+=yDiffrance;
    //
    if (_contentScroll.x>0) {
        _contentScroll.x=0;
    }
    if(lineOffsetX<self.axisLineSizeWidth){
        _contentScroll.x=0;
        self.isAutoOffset=YES;
    }else{
        if (-_contentScroll.x>(lineOffsetX-self.axisLineSizeWidth)) {
            _contentScroll.x=-(lineOffsetX-self.axisLineSizeWidth);
            self.isAutoOffset=YES;
        }
        if (_contentScroll.x>self.frame.size.width/2) {
            _contentScroll.x=self.frame.size.width/2;
            self.isAutoOffset=YES;
        }
    }
    _contentScroll.y =0;
    [self setNeedsDisplay];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

@end