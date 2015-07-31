#import <UIKit/UIKit.h>

@class PNPlot;

@interface PNLineChartView : UIView


@property (nonatomic, strong) NSArray *xAxisValues;
@property (nonatomic, assign) NSInteger xAxisFontSize;
@property (nonatomic, strong) UIColor*  xAxisFontColor;
@property (nonatomic, assign) NSInteger numberOfVerticalElements;

@property (nonatomic, strong) UIColor * horizontalLinesColor;



@property (nonatomic, assign) float  max; // max value in the axis
@property (nonatomic, assign) float  min; // min value in the axis
@property (nonatomic, assign) float  interval; // interval value between two horizontal line
@property (nonatomic, assign) float  pointerInterval; // the x interval width between pointers

@property (nonatomic, assign) float  axisLineWidth; // axis line width
@property (nonatomic, assign) float  horizontalLineInterval; // the height between two horizontal line
@property (nonatomic, assign) float  horizontalLineWidth; // the width of the horizontal line
@property (nonatomic, assign) float  axisBottomLinetHeight;  // xAxis line off the view
@property (nonatomic, assign) float  axisLeftLineWidth;   //yAxis line between the view left

@property (nonatomic, strong) NSString*  floatNumberFormatterString; // the yAxis label text should be formatted with


@property (nonatomic, strong) NSArray* yAxisValues; // array of number

/**
 *  readyonly dictionary that stores all the plots in the graph.
 */
@property (nonatomic, readonly, strong) NSMutableArray *plots;


/**
 *  this method will add a Plot to the graph.
 *
 *  @param newPlot the Plot that you want to draw on the Graph.
 */
- (void)addPlot:(PNPlot *)newPlot;
-(void)commonInit;
-(void)clearPlot;
@end
