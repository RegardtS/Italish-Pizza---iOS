//
//  EditCustomerViewController.h
//  Italish Pizza
//
//  Created by Saint on 2014/10/26.
//  Copyright (c) 2014 Saint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditCustomerViewController : UIViewController

- (IBAction)btnCancel:(id)sender;
- (IBAction)btnUpdate:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txtName;
@property (strong, nonatomic) IBOutlet UITextField *txtSurname;
@property (strong, nonatomic) IBOutlet UITextField *txtContactNum;
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@end
