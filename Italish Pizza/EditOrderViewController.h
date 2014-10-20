//
//  EditOrderViewController.h
//  Italish Pizza
//
//  Created by Saint on 2014/10/19.
//  Copyright (c) 2014 Saint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditOrderViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property int billID;


- (IBAction)backBtn:(id)sender;
- (IBAction)btnPay:(id)sender;
- (IBAction)btnAdd:(id)sender;
- (IBAction)btnPrint:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *tblView;
@property (strong, nonatomic) IBOutlet UILabel *lblTotal;

@end
