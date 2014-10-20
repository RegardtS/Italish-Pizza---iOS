//
//  StockViewController.m
//  Italish Pizza
//
//  Created by Saint on 2014/10/15.
//  Copyright (c) 2014 Saint. All rights reserved.
//

#import "StockViewController.h"
#import "StockTableViewCell.h"
#import "DatabaseHelper.h"

@interface StockViewController ()

@end

@implementation StockViewController

@synthesize tblView,categories;
DatabaseHelper *db;



NSMutableArray *dataArray;




- (void)viewDidLoad {
    [super viewDidLoad];

    
    tblView.delegate =self;
    tblView.dataSource = self;
    
   

    db = [[DatabaseHelper alloc] init];
    
    
    
}



-(void)viewWillAppear:(BOOL)animated{
    [self initSetup];
}

-(void)initSetup{
    
    dataArray = [[NSMutableArray alloc] init];
    
    NSMutableArray *stockCat = [[NSMutableArray alloc] init];
    stockCat = [db getAllStockCategories];
    
    
    categories= [[NSMutableArray alloc] init];
    NSMutableArray *categoriesID = [[NSMutableArray alloc] init];
    for (int i = 0; i < [stockCat count]; i++) {
        if (i%2!=0) {
            [categories addObject:[stockCat objectAtIndex:i]];
        }else{
            [categoriesID addObject:[stockCat objectAtIndex:i]];
        }
    }
    
    
    for (int i = 0 ; i < [categoriesID count]; i++) {
        
        NSMutableArray *ItemsArray = [[NSMutableArray alloc] init];
        ItemsArray = [db getAllStockWithCatID:[NSString stringWithFormat:@"%i",i]];
        
        if ([ItemsArray count]>0) {
            NSDictionary *firstItemsArrayDict = [NSDictionary dictionaryWithObject:ItemsArray forKey:@"data"];
            [dataArray addObject:firstItemsArrayDict];
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [dataArray count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //Number of rows it should expect should be based on the section
    NSDictionary *dictionary = [dataArray objectAtIndex:section];
    NSArray *array = [dictionary objectForKey:@"data"];
    return [array count];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
        return [categories objectAtIndex:section];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    StockTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[StockTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *dictionary = [dataArray objectAtIndex:indexPath.section];
    NSArray *array = [dictionary objectForKey:@"data"];
    NSString *cellValue = [array objectAtIndex:indexPath.row];
    
    NSArray * arrayT = [cellValue componentsSeparatedByString:@"--"];
    
    
    
    cell.lblTitle.text =(NSString *)[arrayT firstObject];
    cell.lblPrice.text =[NSString stringWithFormat:@"R%@",(NSString *)[arrayT lastObject]];
    
    
    
    return cell;
}




@end
