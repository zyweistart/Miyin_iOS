#import <Foundation/Foundation.h>

@interface PNPlot : NSObject

//线宽
@property (nonatomic, assign) float lineWidth;
//线颜色
@property (nonatomic, strong) UIColor* lineColor;
//点的值
@property (nonatomic, strong) NSArray *plottingValues;
//点的标签
@property (nonatomic, strong) NSArray *plottingPointsLabels;

@end
