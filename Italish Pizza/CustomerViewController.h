//
//  CustomerViewController.h
//  Italish Pizza
//
//  Created by Saint on 2014/10/15.
//  Copyright (c) 2014 Saint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VBFPopFlatButton.h"
#import "CustomerFormViewController.h"

@interface CustomerViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,CustomerFormDelegate,UIPopoverControllerDelegate>


@property (strong, nonatomic) IBOutlet UITableView *tblView;


@property (strong, nonatomic) UIStoryboardPopoverSegue *currentPopoverSegue;
@property (strong, nonatomic) CustomerFormViewController *pvc;



@property (nonatomic) BOOL fromBooking;





@end
