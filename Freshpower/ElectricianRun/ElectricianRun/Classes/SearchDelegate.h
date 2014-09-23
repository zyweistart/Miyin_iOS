//
//  SearchDelegate.h
//  ElectricianRun
//
//  Created by Start on 2/21/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SearchDelegate <NSObject>

@optional
- (void)startSearch:(NSMutableDictionary *)data;

- (void)startSearch:(NSMutableDictionary *)data responseCode:(int)repCode;

@end
