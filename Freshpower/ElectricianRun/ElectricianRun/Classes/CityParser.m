//
//  CityParser.m
//  ElectricianRun
//
//  Created by Start on 3/6/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "CityParser.h"

@implementation CityParser {
    BOOL flag;
    NSString *currentCity;
    NSMutableArray *datas;
    NSString *currentTag;
}

- (void)startParser
{
    NSString *xmlFilePath = [[NSBundle mainBundle]pathForResource:@"city" ofType:@"xml"];
    NSData *data = [[NSData alloc]initWithContentsOfFile:xmlFilePath];
    self.parser = [[NSXMLParser alloc]initWithData:data];
    self.parser.delegate = self;
    if(![self.parser parse]){
        NSLog(@"City.xml文件解析失败");
    }
}

// 文档开始
-(void)parserDidStartDocument:(NSXMLParser *)parser
{
    self.citys=[[NSMutableDictionary alloc]init];
}

// 元素开始
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict

{
    currentTag=elementName;
    if([@"string-array" isEqualToString:currentTag]){
        datas=[[NSMutableArray alloc]init];
        currentCity=[attributeDict objectForKey:@"name"];
    }else if([@"item" isEqualToString:currentTag]){
        flag=YES;
    }
}

// 解析文本,会多次解析，每次只解析1000个字符，如果多月1000个就会多次进入这个方法
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if([@"item" isEqualToString:currentTag]&&flag){
        [datas addObject:string];
        flag=NO;
    }
}

// 元素结束
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([@"string-array" isEqualToString:elementName]){
        [self.citys setObject:datas forKey:currentCity];
        datas=nil;
        currentCity=nil;
    }
}

// 文档结束
-(void)parserDidEndDocument:(NSXMLParser *)parser
{
}

@end
