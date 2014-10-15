//
//  DatabaseHelper.h
//  Italish Pizza
//
//  Created by Saint on 2014/09/01.
//  Copyright (c) 2014 Saint. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DatabaseHelper : NSObject

-(void)startingStuff;


//LOGIN
-(NSString *)loginWithUsername:(NSString *)username withPassword:(NSString *)password;

//STAFF
-(void)addStaffWithUsername:(NSString *)username withPassword:(NSString *)password withAuthority:(NSInteger)auth;
-(NSMutableArray *)getAllStaff;
-(NSMutableArray *)getAllStaffUsernames;
-(void)updateStaff:(NSDictionary *)staffDetails;

//CUSTOMERS
-(void)addCustomerWithName:(NSString*)name withSurname:(NSString *)surname withContactNum:(NSString *)contactNum withEmail:(NSString *)email;
-(NSMutableArray *)getAllCustomers;

//STOCKCATEGORIES
-(void)addStockCategory:(NSString *)categoryName;
-(NSMutableArray *)getAllStockCategories;

//STOCK
-(void)addStockItemWithName:(NSString *)name withDescription:(NSString *)description withPrice:(NSString *)price withAmount:(NSString *)amount withCatID:(NSString *)ID;




@end
