//
//  CustomerViewController.m
//  Italish Pizza
//
//  Created by Saint on 2014/10/15.
//  Copyright (c) 2014 Saint. All rights reserved.
//

#import "CustomerViewController.h"
#import "VBFPopFlatButton.h"
#import "DatabaseHelper.h"


@interface CustomerViewController ()

@end

@implementation CustomerViewController


@synthesize tblView;

@synthesize currentPopoverSegue,pvc,fromBooking;


NSMutableArray *customerAllDetails;
NSMutableArray *customerNames;
NSMutableArray *customerContact;
NSMutableArray *customerID;



DatabaseHelper *db;



- (void)viewDidLoad {
    [super viewDidLoad];
    
    db =[[DatabaseHelper alloc] init];
    customerNames = [[NSMutableArray alloc] init];
    customerContact = [[NSMutableArray alloc] init];
    customerAllDetails = [[NSMutableArray alloc] init];
    customerID = [[NSMutableArray alloc] init];
    
    
    [self setupTableView];
    
    tblView.delegate = self;
    tblView.dataSource = self;
    
    
    VBFPopFlatButton *btnCreate = [[VBFPopFlatButton alloc] initWithFrame:CGRectMake(1024-100, 80-48/2, 48 , 48) buttonType:buttonAddType buttonStyle:buttonRoundedStyle animateToInitialState:YES];
    
    
    btnCreate.roundBackgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    btnCreate.lineThickness = 2;
    btnCreate.tintColor = [UIColor colorWithRed:0.20392156862745098 green:0.596078431372549 blue:0.8588235294117647 alpha:1];
    
    [btnCreate addTarget:self
                               action:@selector(createPressed)
                     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnCreate];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupTableView];
}

-(void)setupTableView{
    [customerAllDetails removeAllObjects];
    [customerNames removeAllObjects];
    [customerContact removeAllObjects];
    [customerID removeAllObjects];
    
    
    customerAllDetails = [db getAllCustomers];
    

    
    
    for (int i = 0; i < [customerAllDetails count]; i+=3) {
        [customerNames addObject:[customerAllDetails objectAtIndex:i]];
    }
    for (int i = 1; i < [customerAllDetails count]; i+=3) {
        [customerContact addObject:[customerAllDetails objectAtIndex:i]];
    }
    for (int i = 2; i < [customerAllDetails count]; i+=3) {
        [customerID addObject:[customerAllDetails objectAtIndex:i]];
    }
    
    
    
    
    [tblView reloadData];
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [customerNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [customerNames objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [customerContact objectAtIndex:indexPath.row];
    return cell;
}

-(void)createPressed{
    [self performSegueWithIdentifier:@"segPop" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"segPop"]) {
        currentPopoverSegue = (UIStoryboardPopoverSegue *)segue;
        pvc = [segue destinationViewController];
        [pvc setDelegate:self];
    }
    
   
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:[customerID objectAtIndex:indexPath.row] forKey:@"TempCustID"];
    [defaults setValue:[customerNames objectAtIndex:indexPath.row] forKey:@"TempCustName"];
    [defaults setValue:[customerContact objectAtIndex:indexPath.row] forKey:@"TempCustContact"];
    [defaults synchronize];
    if (fromBooking) {
        fromBooking = NO;
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self performSegueWithIdentifier:@"editSegue" sender:self];
    }
}

// PopViewControllerDelegate callback function
- (void)dismissWithSaveWithUsername:(NSString*)username withSurname:(NSString *)surname withContactNum:(NSString *)contactNum withEmail:(NSString *)email{
    [db addCustomerWithName:username withSurname:surname withContactNum:contactNum withEmail:email];
    [[currentPopoverSegue popoverController] dismissPopoverAnimated: YES]; // dismiss the popover
    [self setupTableView];
}



@end





























































































