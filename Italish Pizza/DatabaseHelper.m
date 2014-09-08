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

//TABLE NAMES
NSString *TABLE_STAFF = @"STAFF";
NSString *TABLE_BOOKINGS = @"BOOKING";
NSString *TABLE_CUSTOMER = @"CUSTOMER";


// Staff Table Columns names
NSString *KEY_STAFF_ID = @"id";
NSString *KEY_STAFF_NAME = @"name";
NSString *KEY_STAFF_PASSWORD = @"password";
NSString *KEY_STAFF_AUTHORITY = @"authority";


//Booking Table Column names
NSString *KEY_BOOKING_ID = @"id";
NSString *KEY_BOOKING_NAME = @"name";
NSString *KEY_BOOKING_TIME = @"time";
NSString *KEY_BOOKING_DATE = @"date";
NSString *KEY_BOOKING_CONTACT = @"contact";
NSString *KEY_BOOKING_SIZE = @"size";



//Customer Table Column names
NSString *KEY_CUSTOMER_ID = @"id";
NSString *KEY_CUSTOMER_NAME = @"name";
NSString *KEY_CUSTOMER_CONTACTNUM = @"contactnum";
NSString *KEY_CUSTOMER_EMAIL = @"email";



NSString *CREATE_TABLE_STAFF;
NSString *CREATE_TABLE_BOOKING;
NSString *CREATE_TABLE_CUSTOMER;



             


-(void)startingStuff{
    CREATE_TABLE_STAFF = [NSString stringWithFormat:@"CREATE TABLE %@ (%@ INTEGER PRIMARY KEY AUTOINCREMENT,%@ TEXT, %@ TEXT,%@ INT)",
                          TABLE_STAFF,
                          KEY_STAFF_ID,
                          KEY_STAFF_NAME,
                          KEY_STAFF_PASSWORD,
                          KEY_STAFF_AUTHORITY];
    
    CREATE_TABLE_BOOKING = [NSString stringWithFormat:@"CREATE TABLE %@ (%@ INTEGER PRIMARY KEY AUTOINCREMENT,%@ TEXT, %@ TEXT,%@ TEXT, %@ TEXT,%@ INT)",
                            TABLE_BOOKINGS,
                            KEY_BOOKING_ID,
                            KEY_BOOKING_NAME,
                            KEY_BOOKING_TIME,
                            KEY_BOOKING_DATE,
                            KEY_BOOKING_CONTACT,
                            KEY_BOOKING_SIZE];
    
    CREATE_TABLE_CUSTOMER = [NSString stringWithFormat:@"CREATE TABLE %@ (%@ INTEGER PRIMARY KEY AUTOINCREMENT, %@ TEXT, %@ TEXT, %@ TEXT)",
                             TABLE_CUSTOMER,
                             KEY_CUSTOMER_ID,
                             KEY_CUSTOMER_NAME,
                             KEY_CUSTOMER_CONTACTNUM,
                             KEY_CUSTOMER_EMAIL];
    
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
            
            sql_stmt =[CREATE_TABLE_BOOKING cStringUsingEncoding:NSASCIIStringEncoding];
            if (sqlite3_exec(ItalishDB, sql_stmt, NULL, NULL, &errMsg) == SQLITE_OK){
                NSLog(@"Created sucessfully CREATE_TABLE_BOOKING");
            }else{
                NSLog(@"Failed to create tableB\n%s",errMsg);
            }

            
            sql_stmt =[CREATE_TABLE_CUSTOMER cStringUsingEncoding:NSASCIIStringEncoding];
            if (sqlite3_exec(ItalishDB, sql_stmt, NULL, NULL, &errMsg) == SQLITE_OK){
                NSLog(@"Created sucessfully CREATE_TABLE_CUSTOMER");
            }else{
                NSLog(@"Failed to create tableB\n%s",errMsg);
            }
            
            
            
            sqlite3_close(ItalishDB);
        } else {
            NSLog(@"Failed to create database");
        }
    }
    
    
    
    
}



-(void)addStaffWithUsername:(NSString *)username withPassword:(NSString *)password withAuthority:(NSInteger)auth{
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
        NSString *insertStatement = [NSString stringWithFormat:@"INSERT INTO %@ (%@,%@,%@) VALUES(\"%@\",\"%@\",%i) ",
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
            NSString *querySQL = [NSString stringWithFormat:@"SELECT %@,%@,%@ FROM %@",KEY_STAFF_NAME,KEY_STAFF_AUTHORITY,KEY_STAFF_ID,TABLE_STAFF];
            const char *query_stmt = [querySQL UTF8String];
            if (sqlite3_prepare_v2(ItalishDB, query_stmt, -1, &statement, NULL) == SQLITE_OK){
                while (sqlite3_step(statement)== SQLITE_ROW) {
                    NSString *CAT = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text( statement, 0)];
                    [tempArray addObject:CAT];
                    CAT = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text( statement, 1)];
                    [tempArray addObject:CAT];
                    CAT = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text( statement, 2)];
                    [tempArray addObject:CAT];
                }
                sqlite3_finalize(statement);
            }
            sqlite3_close(ItalishDB);
        }
        return tempArray;
    }




-(void)updateStaff:(NSDictionary *)staffDetails{
    NSString *docsDir;
    NSArray *dirPaths;
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    dbPath = [[NSString alloc]initWithString: [docsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",DATABASE_NAME]]];
    sqlite3_stmt *statement = nil;
    const char *dbpath = [dbPath UTF8String];
    if (sqlite3_open(dbpath, &ItalishDB) == SQLITE_OK) {
        const char *update_stmt;
        
        int auth = 0;
        if ([staffDetails[@"Staff_Auth"] isEqualToString:@"Manager"]) {
            auth = 2;
        }else if([staffDetails[@"Staff_Auth"] isEqualToString:@"Waiter"]){
            auth = 1;
        }
        
        
        
        NSString *updateStatement = [NSString stringWithFormat:@"UPDATE %@ SET %@ = \"%@\", %@ = \"%@\", %@ = %i WHERE %@=%@",
                                     TABLE_STAFF,
                                     KEY_STAFF_NAME,
                                     staffDetails[@"Staff_Name"],
                                     KEY_STAFF_PASSWORD,
                                     staffDetails[@"Staff_Password"],
                                     KEY_STAFF_AUTHORITY,
                                     auth,
                                     KEY_STAFF_ID,
                                     staffDetails[@"Staff_ID"]];
        NSLog(@"query == %@",updateStatement);
        update_stmt = [updateStatement UTF8String];
        sqlite3_prepare_v2(ItalishDB, update_stmt, -1, &statement, NULL);
        sqlite3_step(statement);
    }
    sqlite3_finalize(statement);
    sqlite3_close(ItalishDB);
}



@end

































