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


-(void)addUserWithUsername:(NSString *)username withPassword:(NSString *)password withAuthority:(NSInteger)auth;
-(NSString *)loginWithUsername:(NSString *)username withPassword:(NSString *)password;
-(NSMutableArray *)getAllStaff;

@end
