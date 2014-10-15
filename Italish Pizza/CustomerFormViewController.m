//
//  CustomerFormViewController.m
//  Italish Pizza
//
//  Created by Saint on 2014/10/15.
//  Copyright (c) 2014 Saint. All rights reserved.
//

#import "CustomerFormViewController.h"

@interface CustomerFormViewController ()

@end

@implementation CustomerFormViewController

@synthesize txtContactNumber,txtEmail,txtName,txtSurname;
@synthesize delegate;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)btnSave:(id)sender {
    
    if(txtName.text.length == 0 || txtSurname.text.length == 0 || txtContactNumber.text.length == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"All required fields must be entered" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        [delegate dismissWithSaveWithUsername:txtName.text withSurname:txtSurname.text withContactNum:txtContactNumber.text withEmail:txtEmail.text];
    }
}


- (IBAction)btnClear:(id)sender {
    txtName.text = @"";
    txtSurname.text = @"";
    txtContactNumber.text = @"";
    txtEmail.text = @"";
}
@end
