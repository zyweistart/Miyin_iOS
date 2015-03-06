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
- (BOOL)CategoryViewChange:(long long)index;

@end

@interface CategoryView : UIView

@property long long currentIndex;
@property NSObject<CategoryViewDelegate> *delegate;

- (id)initWithFrame:(CGRect)rect Title1:(NSString*)title1 Titlte2:(NSString*)title2 Title3:(NSString*)title3 Title4:(NSString*)title4;
- (void)setIndex:(long long)i;
- (void)changeStatus;

@end
