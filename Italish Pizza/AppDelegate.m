//
//  AppDelegate.m
//  Italish Pizza
//
//  Created by Saint on 2014/09/01.
//  Copyright (c) 2014 Saint. All rights reserved.
//

#import "AppDelegate.h"
#import "DatabaseHelper.h"

@implementation AppDelegate

DatabaseHelper *db;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    

    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (![defaults objectForKey:@"Init"]) {
        db = [[DatabaseHelper alloc] init];
        [db startingStuff];
        [db addStaffWithUsername:@"Regi" withPassword:@"123" withAuthority:2];
        [db addStaffWithUsername:@"Mark" withPassword:@"123" withAuthority:1];
        [db addStaffWithUsername:@"Petrus" withPassword:@"123" withAuthority:0];
        [db addStaffWithUsername:@"Coffee lady" withPassword:@"123" withAuthority:0];
        
        
        [defaults setBool:YES forKey:@"Init"];
        [defaults synchronize];
        
        
        
        [self populateStockCategories];
        [self populateStock];
        
        
        
        
        
    }
    return YES;
}
- (void)populateStockCategories{
    [db addStockCategory:@"Starters"];
    [db addStockCategory:@"Main Course"];
    [db addStockCategory:@"Drinks - Alcoholic"];
    [db addStockCategory:@"Drinks - Non Alcohol"];
    [db addStockCategory:@"Drinks - Warm"];
}
- (void)populateStock{
//    Starters - category 1
    [db addStockItemWithName:@"Bacon Supreme"               withDescription:@"Bacon , mushrooms, green pepper and onion"                           withPrice:@"80.00"   withAmount:@"" withCatID:@"1"];
    [db addStockItemWithName:@"BBQ Roast Chicken"           withDescription:@"Chicken, BBQ sauce and Mozzarelle chesse"                            withPrice:@"75.00"   withAmount:@"" withCatID:@"1"];
    [db addStockItemWithName:@"Salami & Rocket"             withDescription:@"Thin-Sliced Salami and Baby Rocket Leaves"                           withPrice:@"90.00"   withAmount:@"" withCatID:@"1"];
    [db addStockItemWithName:@"Deluxe Chicken & Mushroom"   withDescription:@"Chopped Cooked Chicken, Thin-sliced Mushrooms and BBQ sauce"         withPrice:@"79.00"   withAmount:@"" withCatID:@"1"];
    [db addStockItemWithName:@"Cheesy Steak Melt"           withDescription:@"Shreddered Cheddar Cheese, Boneless Beaf Strips and Steak Seasoning" withPrice:@"56.00"   withAmount:@"" withCatID:@"1"];
    [db addStockItemWithName:@"Margherita"                  withDescription:@"Sliced Mozzarelle, Basil and Extra Virgin Olive Oil"                 withPrice:@"50.00"   withAmount:@"" withCatID:@"1"];
    [db addStockItemWithName:@"Hawaiin"                     withDescription:@"Sliced Pineapples and Sliced Bacon"                                  withPrice:@"46.00"   withAmount:@"" withCatID:@"1"];
    
//    Main Course - category 2
  
    [db addStockItemWithName:@"Primavera"                   withDescription:@""                                                                     withPrice:@"99.00"  withAmount:@"" withCatID:@"2"];
    [db addStockItemWithName:@"Casalinga & Rustica Pasta"   withDescription:@"Oyster Shells, Lumaconi Rigati, Rigatoni and Egg Garanelli"           withPrice:@"85.00"  withAmount:@"" withCatID:@"2"];
    [db addStockItemWithName:@"Mexican"                     withDescription:@"Seasoned Beef, hearty beans with pizza sauce and melted cheese"       withPrice:@"80.00"  withAmount:@"" withCatID:@"2"];
    [db addStockItemWithName:@"Four Seasons"                withDescription:@""                                                                     withPrice:@"89.00"  withAmount:@"" withCatID:@"2"];
    [db addStockItemWithName:@"Meaty Deluxe"                withDescription:@""                                                                     withPrice:@"120.00" withAmount:@"" withCatID:@"2"];
    [db addStockItemWithName:@"Club"                        withDescription:@""                                                                     withPrice:@"80.00"  withAmount:@"" withCatID:@"2"];
    [db addStockItemWithName:@"Seafood"                     withDescription:@""                                                                     withPrice:@"95.00"  withAmount:@"" withCatID:@"2"];
    [db addStockItemWithName:@"Cosmopoliton"                withDescription:@""                                                                     withPrice:@"87.00"  withAmount:@"" withCatID:@"2"];
    [db addStockItemWithName:@"Prego Steak Rool"            withDescription:@"Red chillies, Steak, garlic and lemon juice"                          withPrice:@"78.00"  withAmount:@"" withCatID:@"2"];
    [db addStockItemWithName:@"Caribbean"                   withDescription:@"Crushed Pineapple, Shredded Mozzarella and lime juice"                withPrice:@"69.00"  withAmount:@"" withCatID:@"2"];
    [db addStockItemWithName:@"Regina"                      withDescription:@"Ham and Mushrooms"                                                    withPrice:@"65.00"  withAmount:@"" withCatID:@"2"];
    [db addStockItemWithName:@"Macaroni & cheese"           withDescription:@"Macaroni and shredded Cheese"                                         withPrice:@"74.00"  withAmount:@"" withCatID:@"2"];
    [db addStockItemWithName:@"Alfredo"                     withDescription:@""                                                                     withPrice:@"78.00"  withAmount:@"" withCatID:@"2"];
    [db addStockItemWithName:@"Butter Chicken Curry"        withDescription:@""                                                                     withPrice:@"70.00"  withAmount:@"" withCatID:@"2"];
    [db addStockItemWithName:@"Carbonara"                   withDescription:@"Eggs, Cheese and Bacon"                                               withPrice:@"98.00"  withAmount:@"" withCatID:@"2"];
    [db addStockItemWithName:@"Bacon & Roast Chilli"        withDescription:@"Bacon and chilli"                                                     withPrice:@"76.00"  withAmount:@"" withCatID:@"2"];
    [db addStockItemWithName:@"Salami & Feta"               withDescription:@"Mushrooms, Sliced Salami, fresh Parsley and Crumbled Cheese"          withPrice:@"65.00"  withAmount:@"" withCatID:@"2"];
    [db addStockItemWithName:@"Bolognaise"                  withDescription:@"Spagetti, and bolognaise sauce"                                       withPrice:@"80.00"  withAmount:@"" withCatID:@"2"];
    [db addStockItemWithName:@"Arrabiata"                   withDescription:@"Garlic, Tomatoes and red chill peppers"                               withPrice:@"55.00"  withAmount:@"" withCatID:@"2"];
    [db addStockItemWithName:@"Chicken, Tomato & Cheese"    withDescription:@""                                                                     withPrice:@"75.00"  withAmount:@"" withCatID:@"2"];
    [db addStockItemWithName:@"Steak Bapoletana"            withDescription:@""                                                                     withPrice:@"79.00"  withAmount:@"" withCatID:@"2"];
    
//    Drinks - Alcoholic - category 3
    
    [db addStockItemWithName:@"Local Beers"                 withDescription:@"Castle Lites, Black Label, Heiniken"                                  withPrice:@"21.00"  withAmount:@"" withCatID:@"3"];
    [db addStockItemWithName:@"Ciders"                      withDescription:@"Smirnoff, Brutal Fruit and Hunters"                                   withPrice:@"23.00"  withAmount:@"" withCatID:@"3"];
    
//    Drinks - Non Alcohol - category 4
    
    [db addStockItemWithName:@"Large Sodas"                 withDescription:@"Coke, Fanta and Sprite"                                               withPrice:@"20.00"  withAmount:@"" withCatID:@"4"];
    [db addStockItemWithName:@"Medium Sodas"                withDescription:@"Coke, Fanta and Sprite"                                               withPrice:@"18.00"  withAmount:@"" withCatID:@"4"];
    [db addStockItemWithName:@"Double Thick Shakes"         withDescription:@"Lime, Chocolate and Strawberry"                                       withPrice:@"22.00"  withAmount:@"" withCatID:@"4"];
    [db addStockItemWithName:@"Orange Juice"                withDescription:@""                                                                     withPrice:@"19.00"  withAmount:@"" withCatID:@"4"];

//    Drinks - Warm - category 5
    
    [db addStockItemWithName:@"Americano Coffee"            withDescription:@"" withPrice:@"26.00" withAmount:@"" withCatID:@"5"];
    [db addStockItemWithName:@"Cappuccino"                  withDescription:@"" withPrice:@"22.00" withAmount:@"" withCatID:@"5"];
    [db addStockItemWithName:@"Espresso"                    withDescription:@"" withPrice:@"24.00" withAmount:@"" withCatID:@"5"];
    
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end






























