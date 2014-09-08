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

@end
