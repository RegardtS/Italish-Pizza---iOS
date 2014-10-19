//
//  ConfirmViewController.h
//  Italish Pizza
//
//  Created by Saint on 2014/10/17.
//  Copyright (c) 2014 Saint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(weak, nonatomic)  NSArray* selectedItems;

@property (strong, nonatomic) IBOutlet UITableView *tblView;
@property (strong, nonatomic) IBOutlet UILabel *lblTotal;

- (IBAction)btnBack:(id)sender;
- (IBAction)btnTakeOrder:(id)sender;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *barbtnTakeOrder;

@end
