//
//  EditAddItemViewController.m
//  Italish Pizza
//
//  Created by Saint on 2014/10/19.
//  Copyright (c) 2014 Saint. All rights reserved.
//

#import "EditAddItemViewController.h"
#import "DatabaseHelper.h"
#import "ItemCollectionViewCell.h"
#import "ConfirmViewController.h"

@interface EditAddItemViewController ()

@end

@implementation EditAddItemViewController





@synthesize tblSections,cvItems,billID;

DatabaseHelper *db;

NSMutableArray *sections;
NSMutableArray *itemNames;
NSMutableArray *itemPrices;
NSMutableArray *items;
NSMutableArray *selectedItems;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    db = [[DatabaseHelper alloc] init];
    sections = [[NSMutableArray alloc] init];
    itemNames = [[NSMutableArray alloc] init];
    itemPrices = [[NSMutableArray alloc] init];
    items = [[NSMutableArray alloc] init];
    
    selectedItems = [[NSMutableArray alloc] init];
    
    
    sections = [db getAllStockCatNames];
    
    tblSections.delegate = self;
    tblSections.dataSource = self;
    
    cvItems.delegate = self;
    cvItems.dataSource = self;
    
    items = [db getAllStockWithCatID:@"1"];
    
    
    [cvItems setAllowsSelection:YES];
    [tblSections selectRowAtIndexPath:0 animated:NO scrollPosition:UITableViewScrollPositionNone];
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    cell.textLabel.text = [sections objectAtIndex:indexPath.row];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [sections count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    items = [db getAllStockWithCatID:[NSString stringWithFormat:@"%i",indexPath.row+1]];
    
    [cvItems reloadData];
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    
    ItemCollectionViewCell *cell = (ItemCollectionViewCell *)[cvItems dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.tag = indexPath.row;
    
    
    NSArray * arrayT = [[items objectAtIndex:indexPath.row] componentsSeparatedByString:@"--"];
    
    
    cell.lblName.text = (NSString *)[arrayT firstObject];
    cell.lblPrice.text = [NSString stringWithFormat:@"R%@",(NSString *)[arrayT lastObject]];
    
    
    UITapGestureRecognizer *tapper = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [cell.btnDelete addGestureRecognizer:tapper];
    
    
    
    if([self checkIfSelected:indexPath]){
        cell.btnDelete.hidden = NO;
        cell.lblQuantity.hidden = NO;
        cell.lblTotalPrice.hidden = NO;
        
        NSInteger quantity = [self getQuantityWithTag:cell.tag];
        cell.lblQuantity.text = [NSString stringWithFormat:@"x %i",quantity];
        
        CGFloat strFloat = (CGFloat)[[arrayT lastObject] floatValue]*quantity;
        cell.lblTotalPrice.text = [NSString stringWithFormat:@"R %.02f",strFloat];
        
        
        
        
    }else{
        cell.btnDelete.hidden = YES;
        cell.lblQuantity.hidden = YES;
        cell.lblTotalPrice.hidden = YES;
    }
    
    
    
    return cell;
}

-(BOOL)checkIfSelected:(NSIndexPath *)indexPath{
    for (int i = 0; i <[selectedItems count]; i++) {
        NSArray *subString = [[selectedItems objectAtIndex:i ] componentsSeparatedByString:@":"];
        if ([[subString objectAtIndex:0] isEqualToString:[NSString stringWithFormat:@"%i",tblSections.indexPathForSelectedRow.row+1]]) {
            if ([[subString objectAtIndex:1] isEqualToString:[NSString stringWithFormat:@"%i",indexPath.row]]) {
                return YES;
            }
        }
    }
    return NO;
}

-(NSInteger )getQuantityWithTag:(NSInteger)tag{
    
    NSString *stringToCheck = [NSString stringWithFormat:@"%i:%i",[tblSections indexPathForSelectedRow].row+1,tag];
    NSInteger counter = 0;
    
    for (NSString *temp in selectedItems) {
        if([temp isEqualToString:stringToCheck]){
            counter++;
        }
    }
    return counter;
}



-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [items count];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    NSString *selectedItem =[NSString stringWithFormat:@"%i:%i",[tblSections indexPathForSelectedRow].row+1,indexPath.row];
    [selectedItems addObject:selectedItem];
    [cvItems reloadData];
}


-(void)tapped:(UITapGestureRecognizer *)gestureRecognizer{
    CGPoint p = [gestureRecognizer locationInView:cvItems];
    NSIndexPath *indexPath = [cvItems indexPathForItemAtPoint:p];
    ItemCollectionViewCell* cell = (ItemCollectionViewCell *)[cvItems cellForItemAtIndexPath:indexPath];
    NSString *tempStr =[NSString stringWithFormat:@"%i:%i",[tblSections indexPathForSelectedRow].row+1,cell.tag];
    if ([selectedItems containsObject:tempStr]) {
        NSUInteger indexOfItem = [selectedItems indexOfObject:tempStr];
        [selectedItems removeObjectAtIndex:indexOfItem];
        [cvItems reloadData];
    }
}





- (IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnDone:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *tempSave = [NSString stringWithFormat:@"BillID%i",billID];
    NSArray *tempAr = [defaults objectForKey:tempSave];
    NSMutableArray *tempMutAr = [[NSMutableArray alloc] initWithArray:tempAr];
    [tempMutAr addObjectsFromArray:selectedItems];
    [defaults setValue:tempMutAr forKey:tempSave];
    [defaults synchronize];
    
    [db removeAllBillItemsWithBillID:billID];
    
        
        for (int i = 0; i < selectedItems.count; i++) {
            NSString *tempStr = [selectedItems objectAtIndex:i];
            NSArray * arrayT = [tempStr componentsSeparatedByString:@":"];
            NSMutableArray *tempAr = [[NSMutableArray alloc] init];
            tempAr = [db getAllStockIDWithCatID:[arrayT firstObject]];
            NSString *item = [tempAr objectAtIndex:[[arrayT lastObject] integerValue]];
            [db addBillItemsWithBillID:[db getBillID] withStockID:[item integerValue] withQuantity:1];
        }

    [self.navigationController popViewControllerAnimated:YES];
    
    
    
}
@end





















