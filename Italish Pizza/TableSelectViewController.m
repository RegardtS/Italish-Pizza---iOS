//
//  TableSelectViewController.m
//  Italish Pizza
//
//  Created by Saint on 2014/10/19.
//  Copyright (c) 2014 Saint. All rights reserved.
//

#import "TableSelectViewController.h"
#import "DatabaseHelper.h"

@interface TableSelectViewController ()

@end

@implementation TableSelectViewController

DatabaseHelper *db;

int selectedTable = 0;
bool Selected = NO;

@synthesize btn1;
@synthesize btn2;
@synthesize btn3;
@synthesize btn4;
@synthesize btn5;
@synthesize btn6;
@synthesize btn7;
@synthesize btn8;
@synthesize btn9;
@synthesize btn10;
@synthesize btn11;
@synthesize btn12;
@synthesize btn13;
@synthesize btn14;
@synthesize btn0;
@synthesize theSelectedItems;

- (void)viewDidLoad {
    [super viewDidLoad];
    db = [[DatabaseHelper alloc] init];
}

- (IBAction)btnPressed:(id)sender {
    UIButton *temp = (UIButton *)sender;
    selectedTable = (int)temp.tag;
    Selected = YES;
    [self reset];
    temp.backgroundColor = [UIColor colorWithRed:37/255.0 green:155/255.0 blue:36/255.0 alpha:1];
}

-(void)reset{
    
    UIColor *bgc = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];
    
    btn1.backgroundColor =bgc;
    btn2.backgroundColor =bgc;
    btn3.backgroundColor =bgc;
    btn4.backgroundColor =bgc;
    btn5.backgroundColor =bgc;
    btn6.backgroundColor =bgc;
    btn7.backgroundColor =bgc;
    btn8.backgroundColor =bgc;
    btn9.backgroundColor =bgc;
    btn10.backgroundColor =bgc;
    btn11.backgroundColor =bgc;
    btn12.backgroundColor =bgc;
    btn13.backgroundColor =bgc;
    btn14.backgroundColor =bgc;
    btn0.backgroundColor =bgc;
}

- (IBAction)backPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    Selected = NO;
}

- (IBAction)btnTakeOrder:(id)sender {

    if (Selected) {
        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
        
        [outputFormatter setDateFormat:@"dd-MM-yyyy HH:mm"];
        NSString *dateString = [outputFormatter stringFromDate:[NSDate date]];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *auth = [defaults objectForKey:@"ID"];
        
        [db createBillWithTableNum:selectedTable withDate:dateString withStaffID:[auth integerValue]];
        
        NSString *tempSave = [NSString stringWithFormat:@"BillID%li",(long)[db getBillID]];
        [defaults setValue:theSelectedItems forKey:tempSave];
        [defaults synchronize];
        
        
        
        for (int i = 0; i < theSelectedItems.count; i++) {
            NSString *tempStr = [theSelectedItems objectAtIndex:i];
            
            NSArray * arrayT = [tempStr componentsSeparatedByString:@":"];
            NSMutableArray *tempAr = [[NSMutableArray alloc] init];
            tempAr = [db getAllStockIDWithCatID:[arrayT firstObject]];
            
            NSString *item = [tempAr objectAtIndex:[[arrayT lastObject] integerValue]];
            [db addBillItemsWithBillID:[db getBillID] withStockID:[item integerValue] withQuantity:1];
        }
        Selected = NO;
        [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:1] animated:YES];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No table selected" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    
    
    
}
@end






































































