//
//  PendingOrdersViewController.h
//  Italish Pizza
//
//  Created by Saint on 2014/10/14.
//  Copyright (c) 2014 Saint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PendingOrdersViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *cvOrders;

@property (strong, nonatomic) IBOutlet UILabel *lblNoCurrentOrders;

@end
