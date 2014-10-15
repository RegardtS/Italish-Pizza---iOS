//
//  PendingOrdersViewController.m
//  Italish Pizza
//
//  Created by Saint on 2014/10/14.
//  Copyright (c) 2014 Saint. All rights reserved.
//

#import "PendingOrdersViewController.h"
#import "PendingOrderCollectionViewCell.h"

@interface PendingOrdersViewController ()

@property (nonatomic, strong) NSIndexPath *selectedItemIndexPath;

@end



@implementation PendingOrdersViewController

@synthesize cvOrders,selectedItemIndexPath;

NSArray *dataArray;



- (void)viewDidLoad {
    [super viewDidLoad];

    cvOrders.delegate = self;
    cvOrders.dataSource = self;
        
    
    
    NSMutableArray *firstSection = [[NSMutableArray alloc] init]; NSMutableArray *secondSection = [[NSMutableArray alloc] init];
    for (int i=0; i<5; i++) {
        [firstSection addObject:[NSString stringWithFormat:@"Cell %d", i]];
        [secondSection addObject:[NSString stringWithFormat:@"item %d", i]];
    }
    dataArray = [[NSArray alloc] initWithObjects:firstSection, secondSection, nil];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSMutableArray *sectionArray = [dataArray objectAtIndex:section];
    return [sectionArray count]; }
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    PendingOrderCollectionViewCell *cell = (PendingOrderCollectionViewCell *)[cvOrders dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];


//    edit
//    pay
//    delete
    
    UITapGestureRecognizer *tapPay = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [cell.lblPay addGestureRecognizer:tapPay];
    UITapGestureRecognizer *tapEdit = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [cell.lblEdit addGestureRecognizer:tapEdit];
    UITapGestureRecognizer *tapDelete = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [cell.lblDelete addGestureRecognizer:tapDelete];
    
    
    
    
    if (self.selectedItemIndexPath != nil && [indexPath compare:self.selectedItemIndexPath] == NSOrderedSame) {
        [cell.lblTimeOfOrder setHidden:YES];
        [cell.lblDelete setHidden:NO];
        
        [cell.lblBackgroundBlue setHidden:NO];
        [cell.lblEdit setHidden:NO];
        [cell.lblPay setHidden:NO];
        
    } else {
        [cell.lblDelete setHidden:YES];
        [cell.lblTimeOfOrder setHidden:NO];
        [cell.lblBackgroundBlue setHidden:YES];
        [cell.lblEdit setHidden:YES];
        [cell.lblPay setHidden:YES];
        
        
    }
    
    return cell;
    
}

-(void)handleTap:(UITapGestureRecognizer*)sender{
    
    UIView* view = sender.view;
    NSLog(@"log == %i",view.tag);
    
//    trash = 3
//    edit = 2
//    pay = 1
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    // always reload the selected cell, so we will add the border to that cell
    
    NSMutableArray *indexPaths = [NSMutableArray arrayWithObject:indexPath];
    
    if (self.selectedItemIndexPath)
    {
        // if we had a previously selected cell
        
        if ([indexPath compare:self.selectedItemIndexPath] == NSOrderedSame)
        {
            // if it's the same as the one we just tapped on, then we're unselecting it
            
            self.selectedItemIndexPath = nil;
        }
        else
        {
            // if it's different, then add that old one to our list of cells to reload, and
            // save the currently selected indexPath
            
            [indexPaths addObject:self.selectedItemIndexPath];
            self.selectedItemIndexPath = indexPath;
        }
    }
    else
    {
        // else, we didn't have previously selected cell, so we only need to save this indexPath for future reference
        
        self.selectedItemIndexPath = indexPath;
    }
    
    // and now only reload only the cells that need updating
    
    [collectionView reloadItemsAtIndexPaths:indexPaths];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([indexPath isEqual:selectedItemIndexPath]) {
        return  CGSizeMake(648, 330);
    }
    
    return  CGSizeMake(648, 265);   //normal
}




















































@end
