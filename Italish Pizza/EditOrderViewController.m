//
//  EditOrderViewController.m
//  Italish Pizza
//
//  Created by Saint on 2014/10/19.
//  Copyright (c) 2014 Saint. All rights reserved.
//

#import "EditOrderViewController.h"
#import "ConfirmOrderTableViewCell.h"
#import "DatabaseHelper.h"
#import "EditAddItemViewController.h"


@interface EditOrderViewController () <UITextFieldDelegate,UIAlertViewDelegate>

@end

@implementation EditOrderViewController

@synthesize billID;


DatabaseHelper *db;

NSMutableArray *menuItemsName;
NSMutableArray *menuItemsPrices;
NSMutableArray *menuItemsQuantity;
NSMutableArray *selectedItems;

@synthesize tblView;
@synthesize lblTotal;
CGFloat totalPrice;


- (void)viewDidLoad {
    [super viewDidLoad];

    tblView.dataSource = self;
    tblView.delegate = self;
    
    db = [[DatabaseHelper alloc] init];
    
    menuItemsName = [[NSMutableArray alloc] init];
    menuItemsPrices = [[NSMutableArray alloc] init];
    menuItemsQuantity = [[NSMutableArray alloc] init];
    selectedItems = [[NSMutableArray alloc] init];
    
    
    
    
}


-(void)viewWillAppear:(BOOL)animated{
    [self setupInfo];
}

-(void)setupInfo{
    [selectedItems removeAllObjects];
    [menuItemsName removeAllObjects];
    [menuItemsPrices removeAllObjects];
    [menuItemsQuantity removeAllObjects];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *tempSave = [NSString stringWithFormat:@"BillID%i",billID];
    selectedItems = [defaults objectForKey:tempSave];
    
    
    NSMutableArray *godArray = [self getCountAndRemoveMultiples:selectedItems];
    
    NSArray *selectedItems = [godArray objectAtIndex:0];
    NSArray *selectedQuantities = [godArray objectAtIndex:1];
    
    totalPrice = 0;
    
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




- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnPay:(id)sender {

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Enter Amount Paid" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil] ;
    alertView.tag = 2;
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [[alertView textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
    [[alertView textFieldAtIndex:0] setDelegate:self];
    [alertView show];
    [[alertView textFieldAtIndex:0] becomeFirstResponder];
}
- (BOOL) textField: (UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString: (NSString *)string {
    if (!string.length){
        return YES;
    }
    if ([string intValue]){
        return YES;
    }
    
    if ([string isEqualToString:@"."]) {
        return YES;
    }
    if ([string isEqualToString:@"0"]) {
        return YES;
    }
    
    return NO;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(alertView.tag == 2 && buttonIndex != 0 ){
        CGFloat enteredAmount = [[alertView textFieldAtIndex:0].text floatValue];
        if (enteredAmount < totalPrice) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Insufficient funds" message:@"Insufficient amount entered" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }else{
            CGFloat difference = enteredAmount-totalPrice;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:[NSString stringWithFormat:@"Change required: %.02f",difference] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            alert.tag = 1;
            [alert show];
        }
    }
    if(alertView.tag == 1){
        [db closeBillWithID:billID amount:[NSString stringWithFormat:@"R %.02f",totalPrice]];
[self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:1] animated:YES];
    }
}


- (IBAction)btnAdd:(id)sender {
    [self performSegueWithIdentifier:@"addSegue" sender:self];
}

- (IBAction)btnPrint:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Print" message:@"Sending bill to printer" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];

}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"addSegue"]) {
        EditOrderViewController *cVC = [segue destinationViewController];
        cVC.billID = billID;
    }
}

@end















