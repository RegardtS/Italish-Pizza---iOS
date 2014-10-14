//
//  LoginViewController.h
//  Italish Pizza
//
//  Created by Saint on 2014/09/01.
//  Copyright (c) 2014 Saint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *txtUsername;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) IBOutlet UIView *pinView;
@property (strong, nonatomic) IBOutlet UIButton *btnLogin;


- (IBAction)btnUsernameTapped:(id)sender;
- (IBAction)btnPasswordTapped:(id)sender;

- (IBAction)loginPressed:(id)sender;

- (IBAction)btnPinPressed:(id)sender;

@end
