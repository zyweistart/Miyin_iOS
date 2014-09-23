//
//  STElectricityView.h
//  ElectricianClient
//
//  Created by Start on 3/27/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STRows4View.h"

@interface STElectricityView : UIView

@property (strong,nonatomic)STRows4View *rv1;
@property (strong,nonatomic)STRows4View *rv2;
@property (strong,nonatomic)STRows4View *rv3;
@property (strong,nonatomic)STRows4View *rv4;
@property (strong,nonatomic)STRows4View *rv5;
@property (strong,nonatomic)UILabel *lblAvgPrice;

@end
