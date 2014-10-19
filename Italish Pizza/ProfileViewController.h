//
//  ProfileViewController.h
//  Italish Pizza
//
//  Created by Saint on 2014/10/16.
//  Copyright (c) 2014 Saint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController

- (IBAction)btnLogout:(id)sender;
- (IBAction)btnChangePass:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *lblUsername;

@end
