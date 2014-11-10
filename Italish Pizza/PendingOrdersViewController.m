//
//  PendingOrdersViewController.m
//  Italish Pizza
//
//  Created by Saint on 2014/10/14.
//  Copyright (c) 2014 Saint. All rights reserved.
//

#import "PendingOrdersViewController.h"
#import "PendingOrderCollectionViewCell.h"
#import "VBFPopFlatButton.h"
#import "DatabaseHelper.h"
#import "NSDate+NVTimeAgo.h"
#import "EditOrderViewController.h"

@interface PendingOrdersViewController ()

@property (nonatomic, strong) NSIndexPath *selectedItemIndexPath;

@end



@implementation PendingOrdersViewController

@synthesize cvOrders,selectedItemIndexPath,lblNoCurrentOrders;

NSMutableArray *dataArray;

NSMutableArray *orderIDArray;
NSMutableArray *orderTableNumArray;
NSMutableArray *orderDate;


DatabaseHelper *db;


NSInteger temp = 0;


- (void)viewDidLoad {
    [super viewDidLoad];
    [self checkIfAuthorized];
    [self creatButton];

    db = [[DatabaseHelper alloc] init];
    
    dataArray = [[NSMutableArray alloc] init];
    orderIDArray= [[NSMutableArray alloc] init];
    orderTableNumArray= [[NSMutableArray alloc] init];
    orderDate= [[NSMutableArray alloc] init];
    
    cvOrders.delegate = self;
    cvOrders.dataSource = self;
    
//    [self setupInfo];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self setupInfo];
}

-(void)setupInfo{
 
    [orderDate removeAllObjects];
    [orderIDArray removeAllObjects];
    [orderTableNumArray removeAllObjects];
    [dataArray removeAllObjects];
    dataArray = [db getAllOpenBills];
    
    
    if ([dataArray count] > 0) {
        lblNoCurrentOrders.hidden = YES;
    }else{
        lblNoCurrentOrders.hidden = NO;
    }
    
    
    for (NSArray *tempAr in dataArray) {
        
        [orderIDArray addObject:[tempAr objectAtIndex:0]];
        [orderTableNumArray addObject:[tempAr objectAtIndex:1]];
        
        NSDateFormatter *dateFormatterForGettingDate = [[NSDateFormatter alloc] init];
        [dateFormatterForGettingDate setDateFormat:@"dd-MM-yyyy HH:mm"];
        NSString *dateSelected = [tempAr objectAtIndex:2];
        NSDate *dateFromStr = [dateFormatterForGettingDate dateFromString:dateSelected];
        
        [orderDate addObject:[dateFromStr formattedAsTimeAgo]];
    }
    
    [cvOrders reloadData];
}



-(void)checkIfAuthorized{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *auth = [defaults objectForKey:@"Auth"];
    if (![auth isEqualToString:@"2"]) {
        NSMutableArray *controllers = [NSMutableArray arrayWithArray:self.tabBarController.viewControllers];
        [controllers removeObjectAtIndex:[controllers count]-1];
        [self.tabBarController setViewControllers:controllers animated:YES];
    }
}

-(void)creatButton{
    VBFPopFlatButton *btnCreate = [[VBFPopFlatButton alloc] initWithFrame:CGRectMake(1024-100, 79, 48 , 48) buttonType:buttonAddType buttonStyle:buttonRoundedStyle animateToInitialState:YES];
    
    
    btnCreate.roundBackgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    btnCreate.lineThickness = 2;
    btnCreate.tintColor = [UIColor colorWithRed:0.20392156862745098 green:0.596078431372549 blue:0.8588235294117647 alpha:1];
    
    [btnCreate addTarget:self
                  action:@selector(createPressed)
        forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnCreate];
}

-(void)createPressed{
    [self performSegueWithIdentifier:@"orderSegue" sender:self];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [orderIDArray count];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    PendingOrderCollectionViewCell *cell = (PendingOrderCollectionViewCell *)[cvOrders dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.lblOrderNum.text = [orderIDArray objectAtIndex:indexPath.row];
    cell.lblTimeOfOrder.text = [orderDate objectAtIndex:indexPath.row];
    
    NSString *tableNum = [orderTableNumArray objectAtIndex:indexPath.row];
    
    if ([tableNum isEqualToString:@"0"]) {
        tableNum = @"Take Away";
    }else{
        tableNum = [NSString stringWithFormat:@"Table %@",tableNum];
    }
    
    cell.lblTableNum.text = tableNum;
    
    return cell;
}




- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    temp = [[orderIDArray objectAtIndex:indexPath.row] integerValue];
    [self performSegueWithIdentifier:@"orderDetailsSegue" sender:self];
    //    trash = 3
    //    edit = 2
    //    pay = 1

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"orderDetailsSegue"]) {
        EditOrderViewController *cVC = [segue destinationViewController];
        cVC.billID = (int)temp;
    }
}






















































@end
