//
//  ProfileViewController.m
//  Italish Pizza
//
//  Created by Saint on 2014/10/16.
//  Copyright (c) 2014 Saint. All rights reserved.
//

#import "ProfileViewController.h"
#import "DatabaseHelper.h"

@interface ProfileViewController () <UIAlertViewDelegate,UITextFieldDelegate>

@end

@implementation ProfileViewController

NSString *tempPass;
DatabaseHelper *db;

@synthesize lblUsername;

- (void)viewDidLoad {
    [super viewDidLoad];
    db = [[DatabaseHelper alloc] init];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    lblUsername.text = [defaults objectForKey:@"Username"];
    
}



- (IBAction)btnLogout:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Logout" message:@"Are you sure you want to log out?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Logout", nil];
    alert.tag = 1;
    [alert show];
}

- (IBAction)btnChangePass:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"New Password" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil] ;
    alertView.tag = 2;
    alertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
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
    return NO;
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1) {
        if (buttonIndex !=0) {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults removeObjectForKey:@"LoggedIn"];
            [defaults removeObjectForKey:@"ID"];
            [defaults synchronize];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else if(alertView.tag == 2 && buttonIndex != 0 && [alertView textFieldAtIndex:0].text.length > 0){
        tempPass =[alertView textFieldAtIndex:0].text;
        UIAlertView *alertView2 = [[UIAlertView alloc] initWithTitle:@"Retype Password" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil] ;
        alertView2.tag = 3;
        alertView2.alertViewStyle = UIAlertViewStyleSecureTextInput;
        [[alertView2 textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
        [[alertView2 textFieldAtIndex:0] setDelegate:self];
        [alertView2 show];
        [[alertView2 textFieldAtIndex:0] becomeFirstResponder];
    }else if(buttonIndex != 0){
        if ([[alertView textFieldAtIndex:0].text  isEqualToString:tempPass]) {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            [db changePassWithUserID:[[defaults objectForKey:@"ID"] integerValue] withPassword:tempPass];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Successfully changed password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }else if([alertView textFieldAtIndex:0].text.length > 0){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure" message:@"New passwords didn't match" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Password cant be blank" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
        }
    }
    
}



@end
