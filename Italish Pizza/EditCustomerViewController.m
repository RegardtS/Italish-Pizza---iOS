//
//  EditCustomerViewController.m
//  Italish Pizza
//
//  Created by Saint on 2014/10/26.
//  Copyright (c) 2014 Saint. All rights reserved.
//

#import "EditCustomerViewController.h"
#import "DatabaseHelper.h"

@interface EditCustomerViewController ()

@end

@implementation EditCustomerViewController

DatabaseHelper *db;
@synthesize txtContactNum,txtEmail,txtName,txtSurname;
NSUserDefaults *defaults;


- (void)viewDidLoad {
    [super viewDidLoad];
    db = [[DatabaseHelper alloc] init];
    
    
    defaults = [NSUserDefaults standardUserDefaults];
    

    NSArray *newAR = [[db getCustomerInfoWithID:[defaults objectForKey:@"TempCustID"]]componentsSeparatedByString: @"--"];

    txtName.text = [newAR objectAtIndex:0];
    txtSurname.text = [newAR objectAtIndex:1];
    txtContactNum.text = [newAR objectAtIndex:2];
    if ([newAR count] > 2) {
        txtEmail.text = [newAR objectAtIndex:3];
    }
}

- (BOOL)validateEmailWithString:(NSString*)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


- (IBAction)btnCancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnUpdate:(id)sender {
    if(txtName.text.length == 0 || txtSurname.text.length == 0 || txtContactNum.text.length == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"All required fields must be entered" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }else if(txtEmail.text.length > 0){
        
        if (![self validateEmailWithString:txtEmail.text]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Email is invalid" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
    }else{
        [db updateCustomerWithID:[defaults objectForKey:@"TempCustID"] WithName:txtName.text withSurname:txtSurname.text withContactNum:txtContactNum.text withEmail:txtEmail.text];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end









































