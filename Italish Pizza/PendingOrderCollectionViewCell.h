//
//  PendingOrderCollectionViewCell.h
//  Italish Pizza
//
//  Created by Saint on 2014/10/14.
//  Copyright (c) 2014 Saint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PendingOrderCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblTableNum;
@property (strong, nonatomic) IBOutlet UILabel *lblOrderNum;
@property (strong, nonatomic) IBOutlet UILabel *lblCurrentTotal;
@property (strong, nonatomic) IBOutlet UILabel *lblTimeOfOrder;

@property (strong, nonatomic) IBOutlet UIView *lblBackgroundBlue;

@property (strong, nonatomic) IBOutlet UILabel *lblEdit;
@property (strong, nonatomic) IBOutlet UILabel *lblPay;

@property (strong, nonatomic) IBOutlet UIView *lblDelete;

@end
