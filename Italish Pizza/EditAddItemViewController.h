//
//  EditAddItemViewController.h
//  Italish Pizza
//
//  Created by Saint on 2014/10/19.
//  Copyright (c) 2014 Saint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditAddItemViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property int billID;

@property (strong, nonatomic) IBOutlet UITableView *tblSections;
@property (strong, nonatomic) IBOutlet UICollectionView *cvItems;

- (IBAction)btnBack:(id)sender;
- (IBAction)btnDone:(id)sender;

@end
