//
//  SQLiteOperate.h
//  ElectricianRun
//
//  Created by Start on 3/2/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <sqlite3.h>
@interface SQLiteOperate : NSObject

//打开数据库
- (BOOL)openDB;
//创建表
- (BOOL)createTable1;
//创建表
- (BOOL)createTable;
//执行SQL语句
- (BOOL)execSql:(NSString *)sql;
//查询语句
- (NSMutableArray*)query1:(NSString*)sqlQuery;
//查询语句
- (NSMutableArray*)query:(NSString*)sqlQuery;

@end
