//
//  CategoryView.h
//  DLS
//
//  Created by Start on 3/6/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CategoryViewDelegate
@optional
- (void)CategoryViewChange:(long long)index;

@end

@interface CategoryView : UIView

@property UIButton *button1;
@property UIButton *button2;
@property UIButton *button3;
@property UIButton *button4;

@property NSObject<CategoryViewDelegate> *delegate;

@end
