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
-(void)changePassWithUserID:(NSInteger)ID withPassword:(NSString *)password;

//STAFF
-(void)addStaffWithUsername:(NSString *)username withPassword:(NSString *)password withAuthority:(NSInteger)auth;
-(NSMutableArray *)getAllStaff;
-(NSMutableArray *)getAllStaffUsernames;
-(void)updateStaff:(NSDictionary *)staffDetails;

//CUSTOMERS
-(void)addCustomerWithName:(NSString*)name withSurname:(NSString *)surname withContactNum:(NSString *)contactNum withEmail:(NSString *)email;
-(NSMutableArray *)getAllCustomers;
-(NSString *)getCustomerInfoWithID:(NSString *)ID;
-(void)updateCustomerWithID:(NSString *)ID WithName:(NSString*)name withSurname:(NSString *)surname withContactNum:(NSString *)contactNum withEmail:(NSString *)email;


//STOCKCATEGORIES
-(void)addStockCategory:(NSString *)categoryName;
-(NSMutableArray *)getAllStockCategories;
-(NSMutableArray *)getAllStockCatNames;


//STOCK
-(void)addStockItemWithName:(NSString *)name withDescription:(NSString *)description withPrice:(NSString *)price withCatID:(NSString *)ID;
-(NSMutableArray *)getAllStockWithCatID:(NSString *)ID;
-(NSMutableArray *)getAllStockIDWithCatID:(NSString *)ID;


//BOOKING
-(void)addBookingWithCustomerID:(NSInteger)custID withTime:(NSString *)time withDate:(NSString *)date withSize:(NSInteger)size;
-(NSMutableArray *)getAllBookings;
-(void)deleteBookingWithID:(NSString *)ID;

//BILL
-(void)createBillWithTableNum:(NSInteger)num withDate:(NSString *)date withStaffID:(NSInteger)ID;
-(NSInteger)getBillID;
-(NSMutableArray *)getAllOpenBills;
-(void)closeBillWithID:(NSInteger)ID amount:(NSString *)amount;
-(NSInteger)getAllTakeAwayBills;
-(NSInteger)getAllSitDownBills;



//BILL ITEMS
-(void)addBillItemsWithBillID:(NSInteger)BillID withStockID:(NSInteger)StockID withQuantity:(NSInteger)quantity;
-(void)removeAllBillItemsWithBillID:(NSInteger)BillID;
-(NSMutableArray *)getMostPopularItems;



@end
