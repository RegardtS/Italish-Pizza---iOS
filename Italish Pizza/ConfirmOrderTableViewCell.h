//
//  ConfirmOrderTableViewCell.h
//  Italish Pizza
//
//  Created by Saint on 2014/10/17.
//  Copyright (c) 2014 Saint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmOrderTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblQuantity;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblPrice;

@end
