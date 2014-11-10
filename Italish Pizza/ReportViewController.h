//
//  ReportViewController.h
//  Italish Pizza
//
//  Created by Saint on 2014/10/18.
//  Copyright (c) 2014 Saint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportViewController : UIViewController

- (IBAction)btnPopularItems:(id)sender;
- (IBAction)btnTakeSit:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *viewSitDown;
@property (strong, nonatomic) IBOutlet UILabel *lblTakeAway;
@property (strong, nonatomic) IBOutlet UILabel *lblSitDown;

@property (strong, nonatomic) IBOutlet UIView *viewMostPopular;

@end
