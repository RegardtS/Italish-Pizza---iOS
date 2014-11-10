//
//  ReportViewController.m
//  Italish Pizza
//
//  Created by Saint on 2014/10/18.
//  Copyright (c) 2014 Saint. All rights reserved.
//

#import "ReportViewController.h"
#import "PNChart.h"
#import "DatabaseHelper.h"

@interface ReportViewController ()

@end

@implementation ReportViewController

DatabaseHelper *db;

@synthesize lblSitDown,lblTakeAway,viewSitDown,viewMostPopular;

- (void)viewDidLoad {
    [super viewDidLoad];

    db = [[DatabaseHelper alloc] init];
    
    viewMostPopular.hidden = YES;
    
    
    NSMutableArray *popItems =[db getMostPopularItems];
    
    if ([popItems count] > 0) {
        NSMutableArray *items = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < [popItems count]; i++) {
            NSArray * arrayT = [[popItems objectAtIndex:i] componentsSeparatedByString:@"--"];
            [items addObject:[PNPieChartDataItem dataItemWithValue:[[arrayT lastObject] floatValue] color:[UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1] description:[arrayT firstObject]]];
        }
        
        PNPieChart *pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(0, 0, 240.0, 240.0) items:items];
        pieChart.descriptionTextColor = [UIColor blackColor];
        pieChart.descriptionTextFont  = [UIFont fontWithName:@"Avenir-Medium" size:14.0];
        [pieChart strokeChart];
        [viewMostPopular addSubview:pieChart];
    }
    
    
    
    
    NSInteger totalSit =[db getAllSitDownBills];
    NSInteger totalTake =[db getAllTakeAwayBills];
    
    if (totalSit == 0 & totalTake == 0) {
        [self reset];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No data available" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        lblSitDown.text = [NSString stringWithFormat:@"%li",(long)totalSit];
        lblTakeAway.text = [NSString stringWithFormat:@"%li",(long)totalTake];
        
        
        
        NSArray *itemsT = @[[PNPieChartDataItem dataItemWithValue:totalTake color:PNRed description:@"Take Aways"],
                            [PNPieChartDataItem dataItemWithValue:totalSit color:PNBlue description:@"Sit Down"]];
        
        
        
        PNPieChart *pieChart2 = [[PNPieChart alloc] initWithFrame:CGRectMake(0, 0, 240.0, 240.0) items:itemsT];
        pieChart2.descriptionTextColor = [UIColor whiteColor];
        pieChart2.descriptionTextFont  = [UIFont fontWithName:@"Avenir-Medium" size:14.0];
        [pieChart2 strokeChart];
        
        [viewSitDown addSubview:pieChart2];
    }
   
}

-(void)reset{
    viewSitDown.hidden = YES;
    viewMostPopular.hidden = YES;
}

- (IBAction)btnPopularItems:(id)sender {
    [self reset];
     viewMostPopular.hidden = NO;
}

- (IBAction)btnTakeSit:(id)sender {
    [self reset];
     viewSitDown.hidden = NO;
}
@end






































