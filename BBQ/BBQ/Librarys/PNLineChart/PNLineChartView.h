#import <UIKit/UIKit.h>

@class PNPlot;

@interface PNLineChartView : UIView

//字体大小
@property (nonatomic, assign)NSInteger xAxisFontSize;
//字体颜色
@property (nonatomic, strong)UIColor*  xAxisFontColor;
//y轴值的宽度
@property (nonatomic, assign)float  axisLeftLineWidth;
//x轴值的高度
@property (nonatomic, assign)float  axisBottomLinetHeight;
//y轴水平线的间距
@property (nonatomic, assign)float  horizontalLineInterval;
//x轴y轴坐标轴的线宽
@property (nonatomic, assign)float  axisLineWidth;
//y轴水平线的宽度
@property (nonatomic, assign)float  horizontalLineWidth;
//两个数据点的间距
@property (nonatomic, assign)float  pointerInterval;
//y轴的坐标数
@property (nonatomic, assign)NSInteger numberOfVerticalElements;
//y轴水平线的颜色
@property (nonatomic, strong)UIColor * horizontalLinesColor;
//y轴最大值坐标
@property (nonatomic, assign)float max;
//y轴最大值坐标
@property (nonatomic, assign)float min;
@property (nonatomic, assign)float interval;
//y轴坐标轴值列表
@property (nonatomic, strong)NSArray *yAxisValues;
//x轴坐标轴值列表
@property (nonatomic, strong)NSArray *xAxisValues;
//数据点列表
@property (nonatomic, readonly, strong) NSMutableArray *plots;

//设置初始化值
- (void)setInitValue;
//添加并绘制点
- (void)addPlot:(PNPlot *)newPlot;
//清除已有的点
- (void)clearPlot;

@end
