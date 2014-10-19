//
//  LoginViewController.m
//  Italish Pizza
//
//  Created by Saint on 2014/09/01.
//  Copyright (c) 2014 Saint. All rights reserved.
//

#import "LoginViewController.h"
#import "DatabaseHelper.h"

@interface LoginViewController () <UIActionSheetDelegate>



@end

@implementation LoginViewController

@synthesize txtPassword,txtUsername,pinView,btnLogin;

DatabaseHelper *db;
NSMutableArray *usernames;
Boolean iOS8BugKiller;
bool isShown = false;


-(void)viewWillAppear:(BOOL)animated{
   // [[self navigationController] setNavigationBarHidden:YES animated:NO];
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
    [self.navigationItem setHidesBackButton:YES];
}



- (void)viewDidLoad{
    [super viewDidLoad];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"LoggedIn"]) {
        [self performSegueWithIdentifier:@"tabbarSegue" sender:self];
    }
    
    db  = [[DatabaseHelper alloc] init];
    usernames = [[NSMutableArray alloc] init];
     [txtPassword setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
}



- (IBAction)btnUsernameTapped:(id)sender {
    usernames = [db getAllStaffUsernames];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select Username"
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil];
    
    // ObjC Fast Enumeration
    for (NSString *title in usernames) {
        [actionSheet addButtonWithTitle:title];
    }

    
    actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancel"];
    
    
    [actionSheet showInView:self.view];

    
    
    [actionSheet showInView:self.view];
    
    iOS8BugKiller = YES;
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (iOS8BugKiller) {
        iOS8BugKiller = NO;
        txtUsername.text = [usernames objectAtIndex:buttonIndex];
    }
}

-(void)actionSheetCancel:(UIActionSheet *)actionSheet{
    NSLog(@"get here?");
   // iOS8BugKiller = YES;
}

- (IBAction)btnPasswordTapped:(id)sender {
    

    
    if (!isShown) {
        pinView.frame =  CGRectMake(342, 391,341, 0);
        btnLogin.frame = CGRectMake(403, 499, 218, 30);

        [UIView animateWithDuration:0.25 animations:^{
            pinView.frame =  CGRectMake(342, 391, 341, 289);
            btnLogin.frame = CGRectMake(403, 688, 218, 30);
        }];
        isShown = true;
    } else {
        [UIView animateWithDuration:0.25 animations:^{
            pinView.frame =  CGRectMake(342, 391, 341, 0);
            btnLogin.frame = CGRectMake(403, 499, 218, 30);
        }];
        isShown = false;
    }
}

- (IBAction)loginPressed:(id)sender {
    
    if ([txtPassword.text length]==0 && [txtUsername.text length]==0) {
        [self showErrorAlert];
    }else{
        NSString *tempStr =[db loginWithUsername:txtUsername.text withPassword:txtPassword.text];
        NSArray * arrayT = [tempStr componentsSeparatedByString:@"--"];
        NSString *username = [arrayT firstObject];
        if (username.length == 0) {
            [self showErrorAlert];
        }else{
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setBool:YES forKey:@"LoggedIn"];
            [defaults setValue:username forKey:@"Username"];
            [defaults setValue:[arrayT lastObject] forKey:@"ID"];
            [defaults setValue:[arrayT objectAtIndex:1] forKey:@"Auth"];
            [defaults synchronize];
            [self cleanup];
            [self performSegueWithIdentifier:@"tabbarSegue" sender:self];
        }
    }
}

- (IBAction)btnPinPressed:(id)sender {
    NSInteger tag = [sender tag];
    
    if (tag == 10) {
        txtPassword.text = @"";
    }else if(tag == 11){
        txtPassword.text = [txtPassword.text substringToIndex:[txtPassword.text length] - 1];
    }else{
        txtPassword.text = [NSString stringWithFormat:@"%@%i",[txtPassword text],tag];
    }
    
}

-(void)cleanup{
    pinView.frame =  CGRectMake(342, 391, 341, 0);
    btnLogin.frame = CGRectMake(403, 499, 218, 30);
    txtPassword.text = @"";
    txtUsername.text = @"Username";
}

-(void)showErrorAlert{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Username or Password incorrect" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
}

@end













