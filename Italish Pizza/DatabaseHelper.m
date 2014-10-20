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
NSString *TABLE_STOCKCAT = @"STOCKCATEGORY";
NSString *TABLE_STOCK = @"STOCK";
NSString *TABLE_BILL = @"BILL";
NSString *TABLE_BILLITEMS = @"BILLITEMS";


// Staff Table Columns names
NSString *KEY_STAFF_ID = @"id";
NSString *KEY_STAFF_NAME = @"name";
NSString *KEY_STAFF_PASSWORD = @"password";
NSString *KEY_STAFF_AUTHORITY = @"authority";

//Booking Table Column names
NSString *KEY_BOOKING_ID = @"id";
NSString *KEY_BOOKING_CUSTOMERID = @"customerid";
NSString *KEY_BOOKING_TIME = @"time";
NSString *KEY_BOOKING_DATE = @"date";
NSString *KEY_BOOKING_SIZE = @"size";

//Customer Table Column names
NSString *KEY_CUSTOMER_ID = @"id";
NSString *KEY_CUSTOMER_NAME = @"name";
NSString *KEY_CUSTOMER_SURNAME = @"surname";
NSString *KEY_CUSTOMER_CONTACTNUM = @"contactnum";
NSString *KEY_CUSTOMER_EMAIL = @"email";

//StockCategory Table Column names
NSString *KEY_STOCKCAT_ID = @"id";
NSString *KEY_STOCKCAT_NAME = @"name";

//Stock Table Column names
NSString *KEY_STOCK_ID = @"id";
NSString *KEY_STOCK_NAME = @"name";
NSString *KEY_STOCK_DESCRIPTION = @"description";
NSString *KEY_STOCK_PRICE = @"price";
NSString *KEY_STOCK_CATEGORYID = @"categoryID";


//Bill Table Column names
NSString *KEY_BILL_ID = @"id";
NSString *KEY_BILL_TABLENUMBER = @"tablenumber";
NSString *KEY_BILL_DATEISSUED = @"dateissued";
NSString *KEY_BILL_STAFFID = @"staffID";
NSString *KEY_BILL_TOTALAMOUNT = @"amount";
NSString *KEY_BILL_CLOSED = @"closed";



//BillItems Table Column names
NSString *KEY_BILLITEMS_BILLID = @"billID";
NSString *KEY_BILLITEMS_QUANTITY = @"quantity";
NSString *KEY_BILLITEMS_STOCKID = @"stockID";



//Strings used to create the tables
NSString *CREATE_TABLE_STAFF;
NSString *CREATE_TABLE_BOOKING;
NSString *CREATE_TABLE_CUSTOMER;
NSString *CREATE_TABLE_STOCKCAT;
NSString *CREATE_TABLE_STOCK;
NSString *CREATE_TABLE_BILL;
NSString *CREATE_TABLE_BILLITEMS;

//INITITIAL STARTUP
-(void)startingStuff{
    CREATE_TABLE_STAFF = [NSString stringWithFormat:@"CREATE TABLE %@ (%@ INTEGER PRIMARY KEY AUTOINCREMENT,%@ TEXT, %@ TEXT,%@ INT)",
                          TABLE_STAFF,
                          KEY_STAFF_ID,
                          KEY_STAFF_NAME,
                          KEY_STAFF_PASSWORD,
                          KEY_STAFF_AUTHORITY];
    
    CREATE_TABLE_BOOKING = [NSString stringWithFormat:@"CREATE TABLE %@ (%@ INTEGER PRIMARY KEY AUTOINCREMENT,%@ INT, %@ TEXT,%@ TEXT,%@ INT)",
                            TABLE_BOOKINGS,
                            KEY_BOOKING_ID,
                            KEY_BOOKING_CUSTOMERID,
                            KEY_BOOKING_TIME,
                            KEY_BOOKING_DATE,
                            KEY_BOOKING_SIZE];
    
    CREATE_TABLE_CUSTOMER = [NSString stringWithFormat:@"CREATE TABLE %@ (%@ INTEGER PRIMARY KEY AUTOINCREMENT, %@ TEXT,%@ TEXT, %@ TEXT, %@ TEXT)",
                             TABLE_CUSTOMER,
                             KEY_CUSTOMER_ID,
                             KEY_CUSTOMER_NAME,
                             KEY_CUSTOMER_SURNAME,
                             KEY_CUSTOMER_CONTACTNUM,
                             KEY_CUSTOMER_EMAIL];
    
    CREATE_TABLE_STOCKCAT = [NSString stringWithFormat:@"CREATE TABLE %@ (%@ INTEGER PRIMARY KEY AUTOINCREMENT, %@ TEXT)",
                             TABLE_STOCKCAT,
                             KEY_STOCKCAT_ID,
                             KEY_STOCKCAT_NAME];
    
    CREATE_TABLE_STOCK = [NSString stringWithFormat:@"CREATE TABLE %@ (%@ INTEGER PRIMARY KEY AUTOINCREMENT, %@ TEXT,%@ TEXT, %@ TEXT, %@ INT)",
                          TABLE_STOCK,
                          KEY_STOCK_ID,
                          KEY_STOCK_NAME,
                          KEY_STOCK_DESCRIPTION,
                          KEY_STOCK_PRICE,
                          KEY_STOCK_CATEGORYID];
    
    CREATE_TABLE_BILL =[NSString stringWithFormat:@"CREATE TABLE %@ (%@ INTEGER PRIMARY KEY AUTOINCREMENT, %@ INT,%@ TEXT, %@ INT, %@ TEXT, %@ INT)",
                        TABLE_BILL,
                        KEY_BILL_ID,
                        KEY_BILL_TABLENUMBER,
                        KEY_BILL_DATEISSUED,
                        KEY_BILL_STAFFID,
                        KEY_BILL_TOTALAMOUNT,
                        KEY_BILL_CLOSED
                        ];
    

    
    
    
    CREATE_TABLE_BILLITEMS =[NSString stringWithFormat:@"CREATE TABLE %@ (%@ INT, %@ INT,%@ INT)",
                        TABLE_BILLITEMS,
                        KEY_BILLITEMS_BILLID,
                        KEY_BILLITEMS_QUANTITY,
                        KEY_BILLITEMS_STOCKID];
    
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
            
            
            sql_stmt =[CREATE_TABLE_STOCKCAT cStringUsingEncoding:NSASCIIStringEncoding];
            if (sqlite3_exec(ItalishDB, sql_stmt, NULL, NULL, &errMsg) == SQLITE_OK){
                NSLog(@"Created sucessfully CREATE_TABLE_STOCKCAT");
            }else{
                NSLog(@"Failed to create tableB\n%s",errMsg);
            }
            
            sql_stmt =[CREATE_TABLE_STOCK cStringUsingEncoding:NSASCIIStringEncoding];
            if (sqlite3_exec(ItalishDB, sql_stmt, NULL, NULL, &errMsg) == SQLITE_OK){
                NSLog(@"Created sucessfully CREATE_TABLE_STOCK");
            }else{
                NSLog(@"Failed to create tableB\n%s",errMsg);
            }
            
            
            
            
            
            sql_stmt =[CREATE_TABLE_BILL cStringUsingEncoding:NSASCIIStringEncoding];
            if (sqlite3_exec(ItalishDB, sql_stmt, NULL, NULL, &errMsg) == SQLITE_OK){
                NSLog(@"Created sucessfully CREATE_TABLE_BILL");
            }else{
                NSLog(@"Failed to create tableB\n%s",errMsg);
            }
            
            
            sql_stmt =[CREATE_TABLE_BILLITEMS cStringUsingEncoding:NSASCIIStringEncoding];
            if (sqlite3_exec(ItalishDB, sql_stmt, NULL, NULL, &errMsg) == SQLITE_OK){
                NSLog(@"Created sucessfully CREATE_TABLE_BILL");
            }else{
                NSLog(@"Failed to create tableB\n%s",errMsg);
            }
            
            
            
            
            
            sqlite3_close(ItalishDB);
        } else {
            NSLog(@"Failed to create database");
        }
    }
    
    
    
    
}


//LOGIN
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
        
        // SELECT COUNT(*) from tableNAME
        
        
        NSString *querySQL = [NSString stringWithFormat: @"SELECT %@,%@,%@ FROM %@ WHERE %@=\"%@\" AND %@=\"%@\"",
                              KEY_STAFF_NAME,
                              KEY_STAFF_AUTHORITY,
                              KEY_STAFF_ID,
                              TABLE_STAFF,
                              KEY_STAFF_NAME,
                              username,
                              KEY_STAFF_PASSWORD,password];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(ItalishDB, query_stmt, -1, &statement, NULL) == SQLITE_OK){
            if (sqlite3_step(statement) == SQLITE_ROW){
                returnedStr = [NSString stringWithFormat:@"%@--%@--%@",[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)],[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)],[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)]];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(ItalishDB);
    }
    return returnedStr;
}



-(void)changePassWithUserID:(NSInteger)ID withPassword:(NSString *)password{
    NSString *docsDir;
    NSArray *dirPaths;
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    dbPath = [[NSString alloc]initWithString: [docsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",DATABASE_NAME]]];
    sqlite3_stmt *statement = nil;
    const char *dbpath = [dbPath UTF8String];
    if (sqlite3_open(dbpath, &ItalishDB) == SQLITE_OK) {
        const char *update_stmt;
        
        NSString *updateStatement = [NSString stringWithFormat:@"UPDATE %@ SET %@ = \"%@\" WHERE %@=%i",
                                     TABLE_STAFF,
                                     KEY_STAFF_PASSWORD,
                                     password,
                                     KEY_STAFF_ID,
                                     ID];
        update_stmt = [updateStatement UTF8String];
        sqlite3_prepare_v2(ItalishDB, update_stmt, -1, &statement, NULL);
        sqlite3_step(statement);
    }
    sqlite3_finalize(statement);
    sqlite3_close(ItalishDB);
}


//STAFF
-(void)addStaffWithUsername:(NSString *)username withPassword:(NSString *)password withAuthority:(NSInteger)auth{
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
        insert_stmt = [insertStatement UTF8String];
        sqlite3_prepare_v2(ItalishDB, insert_stmt, -1, &statement, NULL);
        sqlite3_step(statement);
    }
    sqlite3_finalize(statement);
    sqlite3_close(ItalishDB);
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
        update_stmt = [updateStatement UTF8String];
        sqlite3_prepare_v2(ItalishDB, update_stmt, -1, &statement, NULL);
        sqlite3_step(statement);
    }
    sqlite3_finalize(statement);
    sqlite3_close(ItalishDB);
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
-(NSMutableArray *)getAllStaffUsernames{
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    NSString *docsDir;
    NSArray *dirPaths;
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    dbPath = [[NSString alloc]initWithString: [docsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",DATABASE_NAME]]];
    
    const char *dbpath = [dbPath UTF8String];
    sqlite3_stmt    *statement;
    if (sqlite3_open(dbpath, &ItalishDB) == SQLITE_OK){
        NSString *querySQL = [NSString stringWithFormat:@"SELECT %@ FROM %@",KEY_STAFF_NAME,TABLE_STAFF];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(ItalishDB, query_stmt, -1, &statement, NULL) == SQLITE_OK){
            while (sqlite3_step(statement)== SQLITE_ROW) {
                NSString *CAT = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text( statement, 0)];
                [tempArray addObject:CAT];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(ItalishDB);
    }
    return tempArray;
}


//CUSTOMER
-(void)addCustomerWithName:(NSString*)name withSurname:(NSString *)surname withContactNum:(NSString *)contactNum withEmail:(NSString *)email{
    NSString *docsDir;
    NSArray *dirPaths;
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    dbPath = [[NSString alloc]initWithString: [docsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",DATABASE_NAME]]];
    sqlite3_stmt *statement = nil;
    const char *dbpath = [dbPath UTF8String];
    if (sqlite3_open(dbpath, &ItalishDB) == SQLITE_OK) {
        const char *insert_stmt;
        NSString *insertStatement = [NSString stringWithFormat:@"INSERT INTO %@ (%@,%@,%@,%@) VALUES(\"%@\",\"%@\",\"%@\",\"%@\")",
                                     TABLE_CUSTOMER,
                                     KEY_CUSTOMER_NAME,
                                     KEY_CUSTOMER_SURNAME,
                                     KEY_CUSTOMER_CONTACTNUM,
                                     KEY_CUSTOMER_EMAIL,
                                     name,
                                     surname,
                                     contactNum,
                                     email];
        insert_stmt = [insertStatement UTF8String];
        sqlite3_prepare_v2(ItalishDB, insert_stmt, -1, &statement, NULL);
        sqlite3_step(statement);
    }
    sqlite3_finalize(statement);
    sqlite3_close(ItalishDB);
}
-(NSMutableArray *)getAllCustomers{
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    NSString *docsDir;
    NSArray *dirPaths;
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    dbPath = [[NSString alloc]initWithString: [docsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",DATABASE_NAME]]];
    const char *dbpath = [dbPath UTF8String];
    sqlite3_stmt    *statement;
    if (sqlite3_open(dbpath, &ItalishDB) == SQLITE_OK){
        NSString *querySQL = [NSString stringWithFormat:@"SELECT %@,%@,%@,%@ FROM %@",KEY_CUSTOMER_NAME,KEY_CUSTOMER_SURNAME,KEY_CUSTOMER_CONTACTNUM,KEY_CUSTOMER_ID,TABLE_CUSTOMER];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(ItalishDB, query_stmt, -1, &statement, NULL) == SQLITE_OK){
            while (sqlite3_step(statement)== SQLITE_ROW) {
                NSString *CAT = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text( statement, 0)];
                CAT = [NSString stringWithFormat:@"%@ %@",CAT, [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text( statement, 1)]];
                [tempArray addObject:CAT];
                CAT = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text( statement, 2)];
                [tempArray addObject:CAT];
                CAT = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text( statement, 3)];
                [tempArray addObject:CAT];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(ItalishDB); 
    }
    return tempArray;
}
-(NSString *)getCustomerInfoWithID:(NSString *)ID{
    NSString *tempStr = @"";
    
    NSString *docsDir;
    NSArray *dirPaths;
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    dbPath = [[NSString alloc]initWithString: [docsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",DATABASE_NAME]]];
    
    const char *dbpath = [dbPath UTF8String];
    sqlite3_stmt    *statement;
    if (sqlite3_open(dbpath, &ItalishDB) == SQLITE_OK){
        NSString *querySQL = [NSString stringWithFormat:@"SELECT %@,%@,%@,%@ FROM %@ WHERE %@ = %@",KEY_CUSTOMER_NAME,KEY_CUSTOMER_SURNAME,KEY_CUSTOMER_CONTACTNUM,KEY_CUSTOMER_EMAIL,TABLE_CUSTOMER, KEY_CUSTOMER_ID,ID];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(ItalishDB, query_stmt, -1, &statement, NULL) == SQLITE_OK){
            if (sqlite3_step(statement)== SQLITE_ROW) {
                tempStr = [NSString stringWithFormat:@"%@--%@--%@--%@",
                [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text( statement, 0)],
                [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text( statement, 1)],
                [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text( statement, 2)],
                 [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text( statement, 3)]
             ];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(ItalishDB);
    }
    return tempStr;
}


//STOCKCATEGORY
-(void)addStockCategory:(NSString *)categoryName{
    NSString *docsDir;
    NSArray *dirPaths;
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    dbPath = [[NSString alloc]initWithString: [docsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",DATABASE_NAME]]];
    sqlite3_stmt *statement = nil;
    const char *dbpath = [dbPath UTF8String];
    if (sqlite3_open(dbpath, &ItalishDB) == SQLITE_OK) {
        const char *insert_stmt;
        NSString *insertStatement = [NSString stringWithFormat:@"INSERT INTO %@ (%@) VALUES(\"%@\")",
                                     TABLE_STOCKCAT,
                                     KEY_STOCKCAT_NAME,
                                     categoryName];
        insert_stmt = [insertStatement UTF8String];
        sqlite3_prepare_v2(ItalishDB, insert_stmt, -1, &statement, NULL);
        sqlite3_step(statement);
    }
    sqlite3_finalize(statement);
    sqlite3_close(ItalishDB);
}
-(NSMutableArray *)getAllStockCategories{
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    NSString *docsDir;
    NSArray *dirPaths;
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    dbPath = [[NSString alloc]initWithString: [docsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",DATABASE_NAME]]];
    
    const char *dbpath = [dbPath UTF8String];
    sqlite3_stmt    *statement;
    if (sqlite3_open(dbpath, &ItalishDB) == SQLITE_OK){
        NSString *querySQL = [NSString stringWithFormat:@"SELECT %@,%@ FROM %@",KEY_STOCKCAT_ID,KEY_STOCKCAT_NAME,TABLE_STOCKCAT];
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
-(NSMutableArray *)getAllStockCatNames{
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    NSString *docsDir;
    NSArray *dirPaths;
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    dbPath = [[NSString alloc]initWithString: [docsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",DATABASE_NAME]]];
    
    const char *dbpath = [dbPath UTF8String];
    sqlite3_stmt    *statement;
    if (sqlite3_open(dbpath, &ItalishDB) == SQLITE_OK){
        NSString *querySQL = [NSString stringWithFormat:@"SELECT %@ FROM %@",KEY_STOCKCAT_NAME,TABLE_STOCKCAT];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(ItalishDB, query_stmt, -1, &statement, NULL) == SQLITE_OK){
            while (sqlite3_step(statement)== SQLITE_ROW) {
                NSString *CAT = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text( statement, 0)];
                [tempArray addObject:CAT];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(ItalishDB);
    }
    return tempArray;
}

//STOCK
-(void)addStockItemWithName:(NSString *)name withDescription:(NSString *)description withPrice:(NSString *)price withCatID:(NSString *)ID{
    NSString *docsDir;
    NSArray *dirPaths;
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    dbPath = [[NSString alloc]initWithString: [docsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",DATABASE_NAME]]];
    sqlite3_stmt *statement = nil;
    const char *dbpath = [dbPath UTF8String];
    if (sqlite3_open(dbpath, &ItalishDB) == SQLITE_OK) {
        const char *insert_stmt;
        NSString *insertStatement = [NSString stringWithFormat:@"INSERT INTO %@ (%@,%@,%@,%@) VALUES(\"%@\",\"%@\",\"%@\",%@)",
                                     TABLE_STOCK,
                                     KEY_STOCK_NAME,
                                     KEY_STOCK_DESCRIPTION,
                                     KEY_STOCK_PRICE,
                                     KEY_STOCK_CATEGORYID,
                                     name,
                                     description,
                                     price,
                                     ID];
        insert_stmt = [insertStatement UTF8String];
        sqlite3_prepare_v2(ItalishDB, insert_stmt, -1, &statement, NULL);
        sqlite3_step(statement);
    }
    sqlite3_finalize(statement);
    sqlite3_close(ItalishDB);
}
-(NSMutableArray *)getAllStockWithCatID:(NSString *)ID{
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    NSString *docsDir;
    NSArray *dirPaths;
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    dbPath = [[NSString alloc]initWithString: [docsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",DATABASE_NAME]]];
    
    const char *dbpath = [dbPath UTF8String];
    sqlite3_stmt    *statement;
    if (sqlite3_open(dbpath, &ItalishDB) == SQLITE_OK){
        NSString *querySQL = [NSString stringWithFormat:@"SELECT %@,%@ FROM %@ WHERE %@ = %@",KEY_STOCK_NAME,KEY_STOCK_PRICE,TABLE_STOCK, KEY_STOCK_CATEGORYID, ID];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(ItalishDB, query_stmt, -1, &statement, NULL) == SQLITE_OK){
            while (sqlite3_step(statement)== SQLITE_ROW) {
                NSString *CAT = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text( statement, 0)];
                CAT = [NSString stringWithFormat:@"%@ -- %@",CAT,[[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text( statement, 1)]];
                [tempArray addObject:CAT];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(ItalishDB);
    }
    return tempArray;
}
-(NSMutableArray *)getAllStockIDWithCatID:(NSString *)ID{
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    NSString *docsDir;
    NSArray *dirPaths;
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    dbPath = [[NSString alloc]initWithString: [docsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",DATABASE_NAME]]];
    
    const char *dbpath = [dbPath UTF8String];
    sqlite3_stmt    *statement;
    if (sqlite3_open(dbpath, &ItalishDB) == SQLITE_OK){
        NSString *querySQL = [NSString stringWithFormat:@"SELECT %@ FROM %@ WHERE %@ = %@",KEY_STOCK_ID,TABLE_STOCK, KEY_STOCK_CATEGORYID, ID];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(ItalishDB, query_stmt, -1, &statement, NULL) == SQLITE_OK){
            while (sqlite3_step(statement)== SQLITE_ROW) {
                NSString *CAT = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text( statement, 0)];
//                CAT = [NSString stringWithFormat:@"%@--%@--%@",CAT,[[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text( statement, 1)],
//                       [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text( statement, 2)]
//                       ];
                [tempArray addObject:CAT];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(ItalishDB);
    }
    return tempArray;
}

//BOOKING
-(void)addBookingWithCustomerID:(NSInteger)custID withTime:(NSString *)time withDate:(NSString *)date withSize:(NSInteger)size{
    NSString *docsDir;
    NSArray *dirPaths;
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    dbPath = [[NSString alloc]initWithString: [docsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",DATABASE_NAME]]];
    sqlite3_stmt *statement = nil;
    const char *dbpath = [dbPath UTF8String];
    if (sqlite3_open(dbpath, &ItalishDB) == SQLITE_OK) {
        const char *insert_stmt;
        NSString *insertStatement = [NSString stringWithFormat:@"INSERT INTO %@ (%@,%@,%@,%@) VALUES(%i,\"%@\",\"%@\",%i) ",
                                     TABLE_BOOKINGS,
                                     KEY_BOOKING_CUSTOMERID,
                                     KEY_BOOKING_TIME,
                                     KEY_BOOKING_DATE,
                                     KEY_BOOKING_SIZE,
                                     custID,
                                     time,
                                     date,
                                     size
                                     ];
        insert_stmt = [insertStatement UTF8String];
        sqlite3_prepare_v2(ItalishDB, insert_stmt, -1, &statement, NULL);
        sqlite3_step(statement);
    }
    sqlite3_finalize(statement);
    sqlite3_close(ItalishDB);
}
-(NSMutableArray *)getAllBookings{
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    NSString *docsDir;
    NSArray *dirPaths;
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    dbPath = [[NSString alloc]initWithString: [docsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",DATABASE_NAME]]];
    
    const char *dbpath = [dbPath UTF8String];
    sqlite3_stmt    *statement;
    if (sqlite3_open(dbpath, &ItalishDB) == SQLITE_OK){
        NSString *querySQL = [NSString stringWithFormat:@"SELECT %@,%@,%@,%@,%@ FROM %@ ORDER BY substr(%@, 7, 4),substr(%@, 4, 2),substr(%@, 1, 2)",
                              KEY_BOOKING_ID,
                              KEY_BOOKING_CUSTOMERID,
                              KEY_BOOKING_TIME,
                              KEY_BOOKING_DATE,
                              KEY_BOOKING_SIZE,
                              TABLE_BOOKINGS,
                              KEY_BOOKING_DATE,
                              KEY_BOOKING_DATE,
                              KEY_BOOKING_DATE];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(ItalishDB, query_stmt, -1, &statement, NULL) == SQLITE_OK){
            while (sqlite3_step(statement)== SQLITE_ROW) {
                NSString *CAT = [NSString stringWithFormat:@"%@--%@--%@--%@--%@",
                                 [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text( statement, 0)],
                                 [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text( statement, 1)],
                                 [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text( statement, 2)],
                                 [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text( statement, 3)],
                                 [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text( statement, 4)]
                                 ];
                [tempArray addObject:CAT];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(ItalishDB);
    }
    return tempArray;
}
-(void)deleteBookingWithID:(NSString *)ID{
//    DELETE FROM table_name
//    WHERE [condition]
    NSString *docsDir;
    NSArray *dirPaths;
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    dbPath = [[NSString alloc]initWithString: [docsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",DATABASE_NAME]]];
    sqlite3_stmt *statement = nil;
    const char *dbpath = [dbPath UTF8String];
    if (sqlite3_open(dbpath, &ItalishDB) == SQLITE_OK) {
        const char *insert_stmt;
        NSString *insertStatement = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = %@",
                                     TABLE_BOOKINGS,
                                     KEY_BOOKING_ID,
                                     ID];
        insert_stmt = [insertStatement UTF8String];
        sqlite3_prepare_v2(ItalishDB, insert_stmt, -1, &statement, NULL);
        sqlite3_step(statement);
    }
    sqlite3_finalize(statement);
    sqlite3_close(ItalishDB);
}

//BILL
-(void)createBillWithTableNum:(NSInteger)num withDate:(NSString *)date withStaffID:(NSInteger)ID{
    NSString *docsDir;
    NSArray *dirPaths;
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    dbPath = [[NSString alloc]initWithString: [docsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",DATABASE_NAME]]];
    sqlite3_stmt *statement = nil;
    const char *dbpath = [dbPath UTF8String];
    if (sqlite3_open(dbpath, &ItalishDB) == SQLITE_OK) {
        const char *insert_stmt;
        NSString *insertStatement = [NSString stringWithFormat:@"INSERT INTO %@ (%@,%@,%@,%@) VALUES(%i,\"%@\",%i, 0) ",
                                     TABLE_BILL,
                                     KEY_BILL_TABLENUMBER,
                                     KEY_BILL_DATEISSUED,
                                     KEY_BILL_STAFFID,
                                     KEY_BILL_CLOSED,
                                     num,
                                     date,
                                     ID
                                     ];
        insert_stmt = [insertStatement UTF8String];
        sqlite3_prepare_v2(ItalishDB, insert_stmt, -1, &statement, NULL);
        sqlite3_step(statement);
    }
    sqlite3_finalize(statement);
    sqlite3_close(ItalishDB);
}
-(NSInteger)getBillID{
    NSString *tempStr = @"";
    NSString *docsDir;
    NSArray *dirPaths;
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    dbPath = [[NSString alloc]initWithString: [docsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",DATABASE_NAME]]];
    const char *dbpath = [dbPath UTF8String];
    sqlite3_stmt    *statement;
    if (sqlite3_open(dbpath, &ItalishDB) == SQLITE_OK){
        NSString *querySQL = [NSString stringWithFormat:@"SELECT %@ FROM %@ ORDER BY %@ DESC LIMIT 1",KEY_BILL_ID,TABLE_BILL,KEY_BILL_ID];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(ItalishDB, query_stmt, -1, &statement, NULL) == SQLITE_OK){
            if (sqlite3_step(statement)== SQLITE_ROW) {
                tempStr = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text( statement, 0)];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(ItalishDB);
    }
    return [tempStr integerValue];
}
-(NSMutableArray *)getAllOpenBills{
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    NSString *docsDir;
    NSArray *dirPaths;
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    dbPath = [[NSString alloc]initWithString: [docsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",DATABASE_NAME]]];
    const char *dbpath = [dbPath UTF8String];
    sqlite3_stmt    *statement;
    if (sqlite3_open(dbpath, &ItalishDB) == SQLITE_OK){
        NSString *querySQL = [NSString stringWithFormat:@"SELECT %@,%@,%@,%@ FROM %@ WHERE %@ = 0 ORDER BY %@ DESC",
                              KEY_BILL_ID,
                              KEY_BILL_TABLENUMBER,
                              KEY_BILL_DATEISSUED,
                              KEY_BILL_STAFFID,
                              TABLE_BILL,
                              KEY_BILL_CLOSED,
                              KEY_BILL_ID
                              ];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(ItalishDB, query_stmt, -1, &statement, NULL) == SQLITE_OK){
            while (sqlite3_step(statement)== SQLITE_ROW) {
                NSMutableArray *loopArray = [[NSMutableArray alloc] init];
                
                
                [loopArray addObject:[[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text( statement, 0)]];
                [loopArray addObject:[[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text( statement, 1)]];
                [loopArray addObject:[[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text( statement, 2)]];
                [loopArray addObject:[[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text( statement, 3)]];
                

                [tempArray addObject:loopArray];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(ItalishDB);
    }
    return tempArray;
}
-(void)closeBillWithID:(NSInteger)ID amount:(NSString *)amount{
    NSString *docsDir;
    NSArray *dirPaths;
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    dbPath = [[NSString alloc]initWithString: [docsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",DATABASE_NAME]]];
    sqlite3_stmt *statement = nil;
    const char *dbpath = [dbPath UTF8String];
    if (sqlite3_open(dbpath, &ItalishDB) == SQLITE_OK) {
        const char *update_stmt;
        
        NSString *updateStatement = [NSString stringWithFormat:@"UPDATE %@ SET %@ = 1, %@ = \"%@\" WHERE %@=%i",
                                     TABLE_BILL,
                                     KEY_BILL_CLOSED,
                                     KEY_BILL_TOTALAMOUNT,
                                     amount,
                                     KEY_BILL_ID,
                                     ID];
        update_stmt = [updateStatement UTF8String];
        sqlite3_prepare_v2(ItalishDB, update_stmt, -1, &statement, NULL);
        sqlite3_step(statement);
    }
    sqlite3_finalize(statement);
    sqlite3_close(ItalishDB);
}
-(NSInteger)getAllTakeAwayBills{
    NSInteger counter;
    NSString *docsDir;
    NSArray *dirPaths;
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    dbPath = [[NSString alloc]initWithString: [docsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",DATABASE_NAME]]];
    const char *dbpath = [dbPath UTF8String];
    sqlite3_stmt    *statement;
    if (sqlite3_open(dbpath, &ItalishDB) == SQLITE_OK){
        NSString *querySQL = [NSString stringWithFormat: @"SELECT COUNT(*) FROM %@ WHERE %@=0",
                              TABLE_BILL,
                              KEY_BILL_TABLENUMBER];
        
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(ItalishDB, query_stmt, -1, &statement, NULL) == SQLITE_OK){
            if (sqlite3_step(statement) == SQLITE_ROW){
                counter = [[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)] integerValue];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(ItalishDB);
    }
    return counter;
}
-(NSInteger)getAllSitDownBills{
    NSInteger counter;
    NSString *docsDir;
    NSArray *dirPaths;
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    dbPath = [[NSString alloc]initWithString: [docsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",DATABASE_NAME]]];
    const char *dbpath = [dbPath UTF8String];
    sqlite3_stmt    *statement;
    if (sqlite3_open(dbpath, &ItalishDB) == SQLITE_OK){
        NSString *querySQL = [NSString stringWithFormat: @"SELECT COUNT(*) FROM %@ WHERE %@!=0",
                              TABLE_BILL,
                              KEY_BILL_TABLENUMBER];
        
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(ItalishDB, query_stmt, -1, &statement, NULL) == SQLITE_OK){
            if (sqlite3_step(statement) == SQLITE_ROW){
                counter = [[NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)] integerValue];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(ItalishDB);
    }
    return counter;
}


//BILL ITEMS
-(void)addBillItemsWithBillID:(NSInteger)BillID withStockID:(NSInteger)StockID withQuantity:(NSInteger)quantity{
    NSString *docsDir;
    NSArray *dirPaths;
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    dbPath = [[NSString alloc]initWithString: [docsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",DATABASE_NAME]]];
    sqlite3_stmt *statement = nil;
    const char *dbpath = [dbPath UTF8String];
    if (sqlite3_open(dbpath, &ItalishDB) == SQLITE_OK) {
        const char *insert_stmt;
        NSString *insertStatement = [NSString stringWithFormat:@"INSERT INTO %@ (%@,%@,%@) VALUES(%i,%i,%i) ",
                                     TABLE_BILLITEMS,
                                     KEY_BILLITEMS_BILLID,
                                     KEY_BILLITEMS_STOCKID,
                                     KEY_BILLITEMS_QUANTITY,
                                     BillID,
                                     StockID,
                                     quantity
                                     ];
        insert_stmt = [insertStatement UTF8String];
        sqlite3_prepare_v2(ItalishDB, insert_stmt, -1, &statement, NULL);
        sqlite3_step(statement);
    }
    sqlite3_finalize(statement);
    sqlite3_close(ItalishDB);
}
-(void)removeAllBillItemsWithBillID:(NSInteger)BillID{
    NSString *docsDir;
    NSArray *dirPaths;
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    dbPath = [[NSString alloc]initWithString: [docsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",DATABASE_NAME]]];
    sqlite3_stmt *statement = nil;
    const char *dbpath = [dbPath UTF8String];
    if (sqlite3_open(dbpath, &ItalishDB) == SQLITE_OK) {
        const char *insert_stmt;
        NSString *insertStatement = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = %i",
                                     TABLE_BILLITEMS,
                                     KEY_BILLITEMS_BILLID,
                                     BillID
                                     ];
        insert_stmt = [insertStatement UTF8String];
        sqlite3_prepare_v2(ItalishDB, insert_stmt, -1, &statement, NULL);
        sqlite3_step(statement);
    }
    sqlite3_finalize(statement);
    sqlite3_close(ItalishDB);
    
}
-(NSMutableArray *)getMostPopularItems{
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    NSString *docsDir;
    NSArray *dirPaths;
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    dbPath = [[NSString alloc]initWithString: [docsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",DATABASE_NAME]]];
    const char *dbpath = [dbPath UTF8String];
    sqlite3_stmt    *statement;
    if (sqlite3_open(dbpath, &ItalishDB) == SQLITE_OK){
        NSString *querySQL = [NSString stringWithFormat:@"SELECT name, count(*) FROM BILLITEMS Inner Join STOCK on id = stockID Group by stockID Order by 2 desc LIMIT 5"];
        const char *query_stmt = [querySQL UTF8String];
        if (sqlite3_prepare_v2(ItalishDB, query_stmt, -1, &statement, NULL) == SQLITE_OK){
            while (sqlite3_step(statement)== SQLITE_ROW) {
                NSString *CAT = [NSString stringWithFormat:@"%@--%@",
                                 [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text( statement, 0)],
                                 [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text( statement, 1)]];
                [tempArray addObject:CAT];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(ItalishDB);
    }
    return tempArray;
}


@end

































