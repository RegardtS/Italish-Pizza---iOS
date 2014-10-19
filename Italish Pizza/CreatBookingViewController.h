//
//  CreatBookingViewController.h
//  Italish Pizza
//
//  Created by Saint on 2014/10/18.
//  Copyright (c) 2014 Saint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreatBookingViewController : UIViewController

- (IBAction)btnCancel:(id)sender;
- (IBAction)btnDone:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *viewMain;
@property (strong, nonatomic) IBOutlet UITextField *lblName;
@property (strong, nonatomic) IBOutlet UITextField *lblContact;
@property (strong, nonatomic) IBOutlet UITextField *lblTime;
@property (strong, nonatomic) IBOutlet UITextField *lblDate;
@property (strong, nonatomic) IBOutlet UITextField *lblSize;

@property (strong, nonatomic) IBOutlet UIView *viewTime;

@property (strong, nonatomic) IBOutlet UIDatePicker *pickerTime;
- (IBAction)btnTimeCancel:(id)sender;
- (IBAction)btnTimeSave:(id)sender;
- (IBAction)pickerDate:(id)sender;
@property (strong, nonatomic) IBOutlet UIDatePicker *pickerDate;


@end
