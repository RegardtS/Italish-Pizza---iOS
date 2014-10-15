//
//  StockViewController.h
//  Italish Pizza
//
//  Created by Saint on 2014/10/15.
//  Copyright (c) 2014 Saint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StockViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tblView;

@end
