//
//  CreateOrderViewController.h
//  Italish Pizza
//
//  Created by Saint on 2014/10/17.
//  Copyright (c) 2014 Saint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateOrderViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tblSections;
@property (strong, nonatomic) IBOutlet UICollectionView *cvItems;

- (IBAction)btnDonePressed:(id)sender;
- (IBAction)btnDeletePressed:(id)sender;

@end
