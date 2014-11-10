//
//  CustomerFormViewController.m
//  Italish Pizza
//
//  Created by Saint on 2014/10/15.
//  Copyright (c) 2014 Saint. All rights reserved.
//

#import "CustomerFormViewController.h"

@interface CustomerFormViewController ()<UITextFieldDelegate>

@end

@implementation CustomerFormViewController

@synthesize txtContactNumber,txtEmail,txtName,txtSurname;
@synthesize delegate;


- (void)viewDidLoad {
    [super viewDidLoad];
    txtContactNumber.delegate = self;
}


- (IBAction)btnSave:(id)sender {
    if(txtName.text.length == 0 || txtSurname.text.length == 0 || txtContactNumber.text.length == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"All required fields must be entered" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }else if(![self validateEmailWithString:txtEmail.text]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Email is invalid" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        [delegate dismissWithSaveWithUsername:txtName.text withSurname:txtSurname.text withContactNum:txtContactNumber.text withEmail:txtEmail.text];
    }
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if([string length]==0){
        return YES;
    }

    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    if (newLength > 10) {
        return NO;
    }
    
    NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    for (int i = 0; i < [string length]; i++) {
        unichar c = [string characterAtIndex:i];
        if ([myCharSet characterIsMember:c]) {
            return YES;
        }
    }
    return NO;
}



- (BOOL)validateEmailWithString:(NSString*)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}



- (IBAction)btnClear:(id)sender {
    txtName.text = @"";
    txtSurname.text = @"";
    txtContactNumber.text = @"";
    txtEmail.text = @"";
}
@end
