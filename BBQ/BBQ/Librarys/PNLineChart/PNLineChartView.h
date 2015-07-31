#import <UIKit/UIKit.h>

@class PNPlot;

@interface PNLineChartView : UIView

@property (nonatomic, strong) NSArray* yAxisValues;
@property (nonatomic, strong) NSArray *xAxisValues;
@property (nonatomic, assign) NSInteger xAxisFontSize;
@property (nonatomic, strong) UIColor*  xAxisFontColor;
@property (nonatomic, assign) NSInteger numberOfVerticalElements;

@property (nonatomic, strong) UIColor * horizontalLinesColor;

@property (nonatomic, assign) float  max;
@property (nonatomic, assign) float  min;
@property (nonatomic, assign) float  interval;
@property (nonatomic, assign) float  pointerInterval;

@property (nonatomic, assign) float  axisLineWidth;
@property (nonatomic, assign) float  horizontalLineInterval;
@property (nonatomic, assign) float  horizontalLineWidth;
@property (nonatomic, assign) float  axisBottomLinetHeight;
@property (nonatomic, assign) float  axisLeftLineWidth;

@property (nonatomic, strong) NSString*  floatNumberFormatterString;

@property (nonatomic, readonly, strong) NSMutableArray *plots;


- (void)commonInit;
- (void)clearPlot;
- (void)addPlot:(PNPlot *)newPlot;

@end
