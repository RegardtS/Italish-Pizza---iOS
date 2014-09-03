//
//  UserViewController.h
//  Italish Pizza
//
//  Created by Saint on 2014/09/02.
//  Copyright (c) 2014 Saint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tblUsers;
@property (strong, nonatomic) IBOutlet UIPickerView *pkAuth;

@property (strong, nonatomic) IBOutlet UITextField *txtUsername;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) IBOutlet UITextField *txtPasswordVerify;

- (IBAction)btnSave:(id)sender;

@end
