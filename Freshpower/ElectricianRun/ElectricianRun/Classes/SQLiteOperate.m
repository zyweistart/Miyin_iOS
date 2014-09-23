//
//  SQLiteOperate.m
//  ElectricianRun
//
//  Created by Start on 3/2/14.
//  Copyright (c) 2014 Start. All rights reserved.
//

#import "SQLiteOperate.h"

#define DBNAME    @"electrician.sqlite"

@implementation SQLiteOperate {
    sqlite3 *db;
}

- (id)init
{
    self=[super init];
    if(self){
        
    }
    return self;
}

- (BOOL)openDB
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:DBNAME];
    if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        return NO;
    }

    return YES;
}

- (BOOL)createTable1
{
    //新闻表
    NSString *ctNEWSql = @"CREATE TABLE IF NOT EXISTS PIC (ID INTEGER PRIMARY KEY AUTOINCREMENT,URL TEXT, NAME TEXT)";
    return [self execSql:ctNEWSql];
}

- (BOOL)createTable
{
    //新闻表
    NSString *ctNEWSql = @"CREATE TABLE IF NOT EXISTS NEW (ID INTEGER PRIMARY KEY AUTOINCREMENT,URL TEXT, NAME TEXT, ICO_NAME TEXT, FILE_NAME TEXT, CONTENT TEXT)";
    return [self execSql:ctNEWSql];
}

- (BOOL)execSql:(NSString *)sql
{
    
    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(db);
        return NO;
    }
    return YES;
}

- (NSMutableArray*)query1:(NSString*)sqlQuery
{
    NSMutableArray *data=[[NSMutableArray alloc]init];
    sqlite3_stmt * statement;
    if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            NSMutableDictionary *d=[[NSMutableDictionary alloc]init];
            char *url = (char*)sqlite3_column_text(statement, 1);
            NSString *urlStr = [[NSString alloc]initWithUTF8String:url];
            [d setObject:urlStr forKey:@"url"];
            
            char *name = (char*)sqlite3_column_text(statement, 2);
            NSString *nameStr = [[NSString alloc]initWithUTF8String:name];
            [d setObject:nameStr forKey:@"name"];
            
            [data addObject:d];
        }
    }
    sqlite3_close(db);
    return data;
}

- (NSMutableArray*)query:(NSString*)sqlQuery
{
    NSMutableArray *data=[[NSMutableArray alloc]init];
    sqlite3_stmt * statement;
    if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            NSMutableDictionary *d=[[NSMutableDictionary alloc]init];
            char *url = (char*)sqlite3_column_text(statement, 1);
            NSString *urlStr = [[NSString alloc]initWithUTF8String:url];
            [d setObject:urlStr forKey:@"url"];
            
            char *name = (char*)sqlite3_column_text(statement, 2);
            NSString *nameStr = [[NSString alloc]initWithUTF8String:name];
            [d setObject:nameStr forKey:@"name"];
            
            char *icon_name = (char*)sqlite3_column_text(statement, 3);
            NSString *icon_nameStr = [[NSString alloc]initWithUTF8String:icon_name];
            [d setObject:icon_nameStr forKey:@"icon_name"];
            
            char *file_name = (char*)sqlite3_column_text(statement, 4);
            NSString *file_nameStr = [[NSString alloc]initWithUTF8String:file_name];
            [d setObject:file_nameStr forKey:@"file_name"];
            
            char *content = (char*)sqlite3_column_text(statement, 5);
            NSString *contentStr = [[NSString alloc]initWithUTF8String:content];
            [d setObject:contentStr forKey:@"content"];
            
            [data addObject:d];
        }
    }
    sqlite3_close(db);
    return data;
}

@end
