//
//  ConfirmViewController.m
//  Italish Pizza
//
//  Created by Saint on 2014/10/17.
//  Copyright (c) 2014 Saint. All rights reserved.
//

#import "ConfirmViewController.h"
#import "ConfirmOrderTableViewCell.h"
#import "DatabaseHelper.h"
#import "TableSelectViewController.h"

@interface ConfirmViewController ()

@end

@implementation ConfirmViewController

@synthesize tblView,selectedItems,lblTotal,barbtnTakeOrder;

DatabaseHelper *db;

NSMutableArray *menuItemsName;
NSMutableArray *menuItemsPrices;
NSMutableArray *menuItemsQuantity;


- (void)viewDidLoad {
    [super viewDidLoad];
    tblView.dataSource = self;
    tblView.delegate = self;
    
    db = [[DatabaseHelper alloc] init];
    
    menuItemsName = [[NSMutableArray alloc] init];
    menuItemsPrices = [[NSMutableArray alloc] init];
    menuItemsQuantity = [[NSMutableArray alloc] init];
    
    
    NSMutableArray *godArray = [self getCountAndRemoveMultiples:selectedItems];
    
    NSArray *selectedItems = [godArray objectAtIndex:0];
    NSArray *selectedQuantities = [godArray objectAtIndex:1];
    
    CGFloat totalPrice = 0;
    
    for (int i = 0; i < selectedQuantities.count; i++) {
        NSString *tempStr = [selectedItems objectAtIndex:i];
        
        NSArray * arrayT = [tempStr componentsSeparatedByString:@":"];
        NSMutableArray *tempAr = [[NSMutableArray alloc] init];
        tempAr = [db getAllStockWithCatID:[arrayT firstObject]];
        
        NSString *item = [tempAr objectAtIndex:[[arrayT lastObject] integerValue]];
        
        NSArray * arrayTemp = [item componentsSeparatedByString:@"--"];
        [menuItemsName addObject:[arrayTemp firstObject]];
        [menuItemsQuantity addObject:[NSString stringWithFormat:@"%@",[selectedQuantities objectAtIndex:i]]];

        CGFloat strFloat = (CGFloat)[[arrayTemp lastObject] floatValue];
        strFloat *= (CGFloat)[[selectedQuantities objectAtIndex:i] floatValue];
        [menuItemsPrices addObject:[NSString stringWithFormat:@"%.02f",strFloat]];
        
        
        totalPrice += strFloat;
        
    }
    
    lblTotal.text = [NSString stringWithFormat:@"R %.02f",totalPrice];

    
    
}

-(NSMutableArray *)getCountAndRemoveMultiples:(NSArray *)array{
    NSMutableArray *newArray = [[NSMutableArray alloc]initWithArray:(NSArray *)array];
    NSMutableArray *countArray = [NSMutableArray new];
    int countInt = 1;
    for (int i = 0; i < newArray.count; ++i) {
        NSString *string = [newArray objectAtIndex:i];
        for (int j = i+1; j < newArray.count; ++j) {
            if ([string isEqualToString:[newArray objectAtIndex:j]]) {
                [newArray removeObjectAtIndex:j];
                countInt++;
            }
        }
        [countArray addObject:[NSNumber numberWithInt:countInt]];
        countInt = 1;
    }
    NSMutableArray *finalArray = [[NSMutableArray alloc] initWithObjects:newArray, countArray, nil];
    return finalArray;
}







-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    ConfirmOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ConfirmOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    
    cell.lblTitle.text =[menuItemsName objectAtIndex:indexPath.row];
    cell.lblQuantity.text =[menuItemsQuantity objectAtIndex:indexPath.row];
    cell.lblPrice.text =[NSString stringWithFormat:@"R %@",[menuItemsPrices objectAtIndex:indexPath.row]];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [menuItemsName count];
}

- (IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnTakeOrder:(id)sender {
    [self performSegueWithIdentifier:@"tableSegue" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"tableSegue"]) {
        TableSelectViewController *cVC = [segue destinationViewController];
        cVC.theSelectedItems = selectedItems;
    }
}


@end

























