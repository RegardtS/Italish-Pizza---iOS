//
//  DatabaseHelper.m
//  Italish Pizza
//
//  Created by Saint on 2014/09/01.
//  Copyright (c) 2014 Saint. All rights reserved.
//

#import "DatabaseHelper.h"
#import <sqlite3.h>

@implementation DatabaseHelper

NSString *dbPath;
sqlite3 *ItalishDB;


//DATABASE NAME
NSString *DATABASE_NAME = @"ItalishDB.db";

NSString *TABLE_STAFF = @"STAFF";

// Staff Table Columns names
NSString *KEY_STAFF_NAME = @"name";
NSString *KEY_STAFF_PASSWORD = @"password";
NSString *KEY_STAFF_AUTHORITY = @"authority";

NSString *CREATE_TABLE_STAFF;


-(void)startingStuff{
    CREATE_TABLE_STAFF = [NSString stringWithFormat:@"CREATE TABLE %@ (id INTEGER PRIMARY KEY AUTOINCREMENT,%@ TEXT, %@ TEXT,%@ TEXT)",
                          TABLE_STAFF,KEY_STAFF_NAME,KEY_STAFF_PASSWORD,KEY_STAFF_AUTHORITY];
    
    [self createDB];
}

-(void)createDB{
    NSString *docsDir;
    NSArray *dirPaths;
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    dbPath = [[NSString alloc]initWithString: [docsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",DATABASE_NAME]]];
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath: dbPath ] == NO){
        const char *dbpath = [dbPath UTF8String];
        if (sqlite3_open(dbpath, & ItalishDB) == SQLITE_OK){
            char *errMsg;
            const char *sql_stmt =  [CREATE_TABLE_STAFF cStringUsingEncoding:NSASCIIStringEncoding];
            if (sqlite3_exec(ItalishDB, sql_stmt, NULL, NULL, &errMsg) == SQLITE_OK){
                NSLog(@"Created sucessfully CREATE_TABLE_STAFF");
            }else{
                NSLog(@"Failed to create table\n%s",errMsg);
            }
            sqlite3_close(ItalishDB);
        } else {
            NSLog(@"Failed to create database");
        }
    }
}



-(void)addUserWithUsername:(NSString *)username withPassword:(NSString *)password withAuthority:(NSString *)auth{
    NSLog(@"is it even getting here?");
    NSString *docsDir;
    NSArray *dirPaths;
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    dbPath = [[NSString alloc]initWithString: [docsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",DATABASE_NAME]]];
    sqlite3_stmt *statement = nil;
    const char *dbpath = [dbPath UTF8String];
    if (sqlite3_open(dbpath, &ItalishDB) == SQLITE_OK) {
        const char *insert_stmt;
        NSString *insertStatement = [NSString stringWithFormat:@"INSERT INTO %@ (%@,%@,%@) VALUES(\"%@\",\"%@\",\"%@\") ",
                                     TABLE_STAFF,
                                     KEY_STAFF_NAME,
                                     KEY_STAFF_PASSWORD,
                                     KEY_STAFF_AUTHORITY,
                                     username,
                                     password,
                                     auth
                                     ];
        NSLog(@"insert == %@",insertStatement);
        insert_stmt = [insertStatement UTF8String];
        sqlite3_prepare_v2(ItalishDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_ROW){
            NSLog(@"Success");
        }else{
            NSLog(@"Problem");
        }
    }
    sqlite3_finalize(statement);
    sqlite3_close(ItalishDB);
}

-(NSString *)loginWithUsername:(NSString *)username withPassword:(NSString *)password{
    NSString *returnedStr;
    NSString *docsDir;
    NSArray *dirPaths;
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    dbPath = [[NSString alloc]initWithString: [docsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",DATABASE_NAME]]];
    sqlite3_stmt *statement = nil;
    const char *dbpath = [dbPath UTF8String];
    if (sqlite3_open(dbpath, &ItalishDB) == SQLITE_OK){
        
        NSString *querySQL = [NSString stringWithFormat: @"SELECT %@ FROM %@ WHERE %@=\"%@\" AND %@=\"%@\"",KEY_STAFF_NAME,TABLE_STAFF,KEY_STAFF_NAME,username,KEY_STAFF_PASSWORD,password];
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(ItalishDB, query_stmt, -1, &statement, NULL) == SQLITE_OK){
            if (sqlite3_step(statement) == SQLITE_ROW){
                returnedStr = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(ItalishDB);
    }
    return returnedStr;
}

-(NSMutableArray *)getAllStaff{
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        
        NSString *docsDir;
        NSArray *dirPaths;
        dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        docsDir = dirPaths[0];
        dbPath = [[NSString alloc]initWithString: [docsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",DATABASE_NAME]]];
        
        const char *dbpath = [dbPath UTF8String];
        sqlite3_stmt    *statement;
        if (sqlite3_open(dbpath, &ItalishDB) == SQLITE_OK){
            NSString *querySQL = [NSString stringWithFormat:@"SELECT %@,%@ FROM %@",KEY_STAFF_NAME,KEY_STAFF_AUTHORITY,TABLE_STAFF];
            const char *query_stmt = [querySQL UTF8String];
            if (sqlite3_prepare_v2(ItalishDB, query_stmt, -1, &statement, NULL) == SQLITE_OK){
                while (sqlite3_step(statement)== SQLITE_ROW) {
                    NSString *CAT = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text( statement, 0)];
                    [tempArray addObject:CAT];
                    CAT = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text( statement, 1)];
                    [tempArray addObject:CAT];
                }
                sqlite3_finalize(statement);
            }
            sqlite3_close(ItalishDB);
        }
        return tempArray;
    }



@end

































