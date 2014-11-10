//
//  CreatBookingViewController.m
//  Italish Pizza
//
//  Created by Saint on 2014/10/18.
//  Copyright (c) 2014 Saint. All rights reserved.
//

#import "CreatBookingViewController.h"
#import "CustomerViewController.h"
#import "DatabaseHelper.h"

@interface CreatBookingViewController ()<UITextFieldDelegate>

@end

@implementation CreatBookingViewController

@synthesize lblContact,lblDate,lblName,lblSize,lblTime,viewMain,viewTime;
@synthesize pickerDate,pickerTime;

bool isExtended = NO;

DatabaseHelper *db;


- (IBAction)btnTimeCancel:(id)sender {
    [self moveViews];
}

- (IBAction)btnTimeSave:(id)sender {
    if (pickerDate.isHidden) {
        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
        [outputFormatter setDateFormat:@"HH:mm"]; //24hr time format
        NSString *dateString = [outputFormatter stringFromDate:pickerTime.date];
        lblTime.text = dateString;
    }else{
        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
        [outputFormatter setDateFormat:@"dd-MM-yyyy"]; //24hr time format
        NSString *dateString = [outputFormatter stringFromDate:pickerDate.date];
        lblDate.text = dateString;
    }
            [self moveViews];
}

- (IBAction)pickerDate:(id)sender {
  
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    db = [[DatabaseHelper alloc] init];

    lblName.delegate = self;
    
    lblTime.delegate = self;
    lblDate.delegate = self;
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *currentDate = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setMonth:+3];
    NSDate *maxDate = [gregorian dateByAddingComponents:comps toDate:currentDate  options:0];

    
    pickerDate.minimumDate = currentDate;
    pickerDate.maximumDate = maxDate;
    
    
    
    
    int startHour = 9;
    int endHour = 22;
    
    NSDate *date1 = [NSDate date];
    NSCalendar *gregorian2 = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian2 components: NSUIntegerMax fromDate: date1];
    [components setHour: startHour];
    [components setMinute: 0];
    [components setSecond: 0];
    NSDate *startDate = [gregorian2 dateFromComponents: components];
    
    [components setHour: endHour];
    [components setMinute: 0];
    [components setSecond: 0];
    NSDate *endDate = [gregorian2 dateFromComponents: components];
    
    [pickerTime setDatePickerMode:UIDatePickerModeTime];
    [pickerTime setMinimumDate:startDate];
    [pickerTime setMaximumDate:endDate];
    [pickerTime setDate:startDate animated:YES];
    [pickerTime reloadInputViews];
    
    
    
    
   

    
    
}



- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField.tag == 1) {
        [self performSegueWithIdentifier:@"testingSegue" sender:self];
        return NO;
    }else if(textField.tag == 2){
        pickerTime.hidden = NO;
        pickerDate.hidden = YES;
    }else{
        pickerTime.hidden = YES;
        pickerDate.hidden = NO;
    }
    [self moveViews];

    return NO;
}

-(void)moveViews{
    if (!isExtended) {
        viewMain.frame =  CGRectMake(302, 142, 420, 515);
        viewTime.frame =  CGRectMake(1100, 257, 512, 296);
        
        [UIView animateWithDuration:0.25 animations:^{
            viewMain.frame =  CGRectMake(33, 142, 420, 515);
            viewTime.frame =  CGRectMake(482, 257, 512, 296);
        }];
        isExtended = YES;
        viewMain.userInteractionEnabled = NO;
    }else{
        viewMain.frame =  CGRectMake(33, 142, 420, 515);
        viewTime.frame =  CGRectMake(482, 257, 512, 296);
        
        [UIView animateWithDuration:0.25 animations:^{
            viewMain.frame =  CGRectMake(302, 142, 420, 515);
            viewTime.frame =  CGRectMake(1100, 257, 512, 296);
        }];
        isExtended = NO;
        viewMain.userInteractionEnabled = YES;
    }
}



-(void)viewWillAppear:(BOOL)animated{
    NSUserDefaults *sharedDefaults = [NSUserDefaults standardUserDefaults];
    lblName.text = [sharedDefaults objectForKey:@"TempCustName"];
    lblContact.text = [sharedDefaults objectForKey:@"TempCustContact"];
}


- (IBAction)btnCancel:(id)sender {
    NSUserDefaults *sharedDefaults = [NSUserDefaults standardUserDefaults];
    [sharedDefaults removeObjectForKey:@"TempCustName"];
    [sharedDefaults removeObjectForKey:@"TempCustContact"];
    [sharedDefaults removeObjectForKey:@"TempCustID"];
    [sharedDefaults synchronize];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnDone:(id)sender {
    if ([self checkIfValid]) {
        NSUserDefaults *sharedDefaults = [NSUserDefaults standardUserDefaults];
        [db addBookingWithCustomerID:[[sharedDefaults objectForKey:@"TempCustID"] integerValue] withTime:lblTime.text  withDate:lblDate.text withSize:[lblSize.text integerValue]];
        [sharedDefaults removeObjectForKey:@"TempCustName"];
        [sharedDefaults removeObjectForKey:@"TempCustContact"];
        [sharedDefaults removeObjectForKey:@"TempCustID"];
        [sharedDefaults synchronize];
        
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"All fields must be entered" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(BOOL)checkIfValid{
    if (lblName.text.length == 0) {
        return NO;
    }
    if (lblDate.text.length == 0) {
        return NO;
    }
    if (lblTime.text.length == 0) {
        return NO;
    }
    if (lblSize.text.length == 0) {
        return NO;
    }
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"testingSegue"]) {
        CustomerViewController *cust = (CustomerViewController *)segue.destinationViewController;
        cust.fromBooking = YES;
    }
}

@end



















































