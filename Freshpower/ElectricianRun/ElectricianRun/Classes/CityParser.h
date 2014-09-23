//
//  CityParser.h
//  ElectricianRun
//
//  Created by Start on 3/6/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityParser : NSObject <NSXMLParserDelegate>

@property NSXMLParser *parser;

@property NSMutableDictionary *citys;

- (void)startParser;

@end
