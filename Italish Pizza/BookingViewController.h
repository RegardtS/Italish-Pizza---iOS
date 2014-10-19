//
//  BookingViewController.h
//  Italish Pizza
//
//  Created by Saint on 2014/09/07.
//  Copyright (c) 2014 Saint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tblBookings;

@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblContact;
@property (strong, nonatomic) IBOutlet UILabel *lblTime;
@property (strong, nonatomic) IBOutlet UILabel *lblDate;
@property (strong, nonatomic) IBOutlet UILabel *lblSize;
- (IBAction)btnDeletePressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *viewMain;
@property (strong, nonatomic) IBOutlet UILabel *lblNoBookings;

@end
