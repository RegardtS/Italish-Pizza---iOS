//
//  LoginViewController.m
//  Italish Pizza
//
//  Created by Saint on 2014/09/01.
//  Copyright (c) 2014 Saint. All rights reserved.
//

#import "LoginViewController.h"
#import "DatabaseHelper.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize txtPassword,txtUsername;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)loginPressed:(id)sender {
    
    if ([txtPassword.text length]==0 && [txtUsername.text length]==0) {
        [self showErrorAlert];
    }else{
        
        DatabaseHelper *db = [[DatabaseHelper alloc] init];
        [db addUserWithUsername:@"Test" withPassword:@"Tester" withAuthority:@"test"];
        
        NSString *username =[db loginWithUsername:txtUsername.text withPassword:txtPassword.text];
        if (username.length == 0) {
            [self showErrorAlert];
        }else{
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setBool:YES forKey:@"LoggedIn"];
            [defaults setValue:username forKey:@"Username"];
            [defaults synchronize];
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

- (IBAction)nextTapped:(id)sender {
    [txtPassword becomeFirstResponder];
}

-(void)showErrorAlert{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Username or Password incorrect" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
}

@end













