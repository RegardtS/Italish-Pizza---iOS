//
//  BookingViewController.m
//  Italish Pizza
//
//  Created by Saint on 2014/09/07.
//  Copyright (c) 2014 Saint. All rights reserved.
//

#import "BookingViewController.h"
#import "VBFPopFlatButton.h"
#import "DatabaseHelper.h"

@interface BookingViewController ()<UIAlertViewDelegate>

@end

@implementation BookingViewController

@synthesize tblBookings;


@synthesize lblName;
@synthesize lblContact;
@synthesize lblTime;
@synthesize lblDate;
@synthesize lblSize;
@synthesize viewMain;
@synthesize lblNoBookings;

DatabaseHelper *db;

NSMutableArray *allDetails;


- (void)viewDidLoad{
    [super viewDidLoad];
    
    tblBookings.dataSource = self;
    tblBookings.delegate = self;
    
    allDetails = [[NSMutableArray alloc] init];
    
    [self createButton];
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self reset];
    
    [super viewWillAppear:animated];
}

-(void)reset{
    [allDetails removeAllObjects];
    allDetails = [db getAllBookings];
    [tblBookings reloadData];
    
    if (allDetails.count > 0) {
        viewMain.hidden = NO;
        lblNoBookings.hidden = YES;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [tblBookings selectRowAtIndexPath:indexPath
                                 animated:YES
                           scrollPosition:UITableViewScrollPositionNone];
        [self tableView:tblBookings didSelectRowAtIndexPath:indexPath];
    }else{
        viewMain.hidden = YES;
        lblNoBookings.hidden = NO;
    }
    
}


-(void)createButton{
    VBFPopFlatButton *btnCreate = [[VBFPopFlatButton alloc] initWithFrame:CGRectMake(1024-100, 80-48/2, 48 , 48) buttonType:buttonAddType buttonStyle:buttonRoundedStyle animateToInitialState:YES];
    
    
    btnCreate.roundBackgroundColor = [UIColor whiteColor];
    btnCreate.lineThickness = 2;
    btnCreate.tintColor = [UIColor colorWithRed:0.20392156862745098 green:0.596078431372549 blue:0.8588235294117647 alpha:1];
    
    [btnCreate addTarget:self
                  action:@selector(createBooking)
        forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnCreate];
}

-(void)createBooking{
    [self performSegueWithIdentifier:@"createBookingSegue" sender:self];
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [allDetails count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    NSArray* foo = [[allDetails objectAtIndex:indexPath.row] componentsSeparatedByString: @"--"];
    
    cell.textLabel.text = [foo objectAtIndex: 2];
    cell.detailTextLabel.text = [foo objectAtIndex: 3];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray* foo = [[allDetails objectAtIndex:indexPath.row] componentsSeparatedByString: @"--"];
    
    NSLog([allDetails objectAtIndex:indexPath.row]);
    
    NSString *name;
    NSString *contactNum;
    NSString *time = [foo objectAtIndex:2];
    NSString *date = [foo objectAtIndex:3];
    NSString *size = [foo lastObject];
    NSArray *newAR = [[db getCustomerInfoWithID:[foo objectAtIndex:1]]componentsSeparatedByString: @"--"];
    name = [NSString stringWithFormat:@"%@ %@",[newAR objectAtIndex:0],[newAR objectAtIndex:1]];
    contactNum =[newAR objectAtIndex:2];
    
    
    
    lblName.text = name;
    lblContact.text = contactNum;
    lblTime.text = time;
    lblDate.text = date;
    lblSize.text = size;
    
    
}

- (IBAction)btnDeletePressed:(id)sender {
    
    if (lblNoBookings.hidden) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirm" message:@"Are you sure you want to delete this booking?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete", nil];
        [alert show];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex != 0) {
        
        
        NSArray* foo = [[allDetails objectAtIndex:[tblBookings indexPathForSelectedRow].row] componentsSeparatedByString: @"--"];
        
        [db deleteBookingWithID:[foo firstObject]];
        [self reset];
    }
}











































@end
