//
//  UserViewController.m
//  Italish Pizza
//
//  Created by Saint on 2014/09/02.
//  Copyright (c) 2014 Saint. All rights reserved.
//

#import "UserViewController.h"
#import "DatabaseHelper.h"



@interface UserViewController ()


@end


@implementation UserViewController{
    NSArray *arStaffDetails;
    NSArray *arAuthChoices;
    NSMutableArray *arStaffNames;
    NSMutableArray *arStaffAuth;
    NSMutableArray *arStaffID;
    DatabaseHelper *db;
}

@synthesize tblUsers;
@synthesize pkAuth;
@synthesize txtUsername,txtPassword,txtPasswordVerify;
@synthesize lblUsername;
@synthesize containerView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    containerView.hidden = YES;
    
    tblUsers.delegate = self;
    tblUsers.dataSource = self;
    
    tblUsers.contentInset = UIEdgeInsetsMake(20.0f, 0.0f, 58.0f, 0.0f);
    
    
    db = [[DatabaseHelper alloc] init];
    
    
    arStaffNames=[[NSMutableArray alloc] init];
    arStaffAuth=[[NSMutableArray alloc] init];
    arStaffID=[[NSMutableArray alloc] init];
    
    
    
    
    arAuthChoices = @[@"Runner", @"Waiter", @"Manager"];
    pkAuth.delegate = self;
    pkAuth.dataSource = self;
    
    
    [self initalSetup];
    
    
}

-(void)initalSetup{
    [arStaffNames removeAllObjects];
    [arStaffAuth removeAllObjects];
    [arStaffID removeAllObjects];
    
    
    arStaffDetails = [db getAllStaff];
    for (int i = 0; i < [arStaffDetails count]; i+=3) {
        [arStaffNames addObject:[arStaffDetails objectAtIndex:i]];
        [arStaffAuth addObject:[arStaffDetails objectAtIndex:i+1]];
        [arStaffID addObject:[arStaffDetails objectAtIndex:i+2]];
    }
    [arStaffNames addObject:@"Add new user"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arStaffNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [arStaffNames objectAtIndex:indexPath.row];
    
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    
    UIView *customColorView = [[UIView alloc] init];
    customColorView.backgroundColor = [UIColor colorWithRed:0/255.0
                                                      green:0/255.0
                                                       blue:0/255.0
                                                      alpha:0.1];
    cell.selectedBackgroundView =  customColorView;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([containerView isHidden]) {
        containerView.hidden = NO;
    }
    
    if (indexPath.row == [arStaffNames count]-1) {
        txtUsername.text = @"";
        txtPassword.text = @"";
        txtPasswordVerify.text = @"";
        lblUsername.text = @"Tap to edit";
        [pkAuth selectRow:0 inComponent:0 animated:YES];
    }else{
        lblUsername.text = [arStaffNames objectAtIndex:indexPath.row];
        [pkAuth selectRow:[[arStaffAuth objectAtIndex:indexPath.row] integerValue] inComponent:0 animated:YES];
        [pkAuth reloadAllComponents];
    }
}


- (IBAction)btnSave:(id)sender {
    if (![txtPassword.text isEqualToString:txtPasswordVerify.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Passwords don't match" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }else if(![txtPassword hasText] || ![txtPasswordVerify hasText]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Password field may not be empty" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        NSIndexPath *selectedIndexPath = [tblUsers indexPathForSelectedRow];
        
        
        if([arStaffNames count]-1 == selectedIndexPath.row){
            
            [db addStaffWithUsername:lblUsername.text withPassword:txtPassword.text withAuthority:[pkAuth selectedRowInComponent:0]];
            
        }else{
            
            NSMutableDictionary *staffDetails = [[NSMutableDictionary alloc] init];
            [staffDetails setObject:lblUsername.text  forKey:@"Staff_Name"];
            [staffDetails setObject:txtPassword.text  forKey:@"Staff_Password"];
            [staffDetails setObject:[arAuthChoices objectAtIndex:[pkAuth selectedRowInComponent:0]]  forKey:@"Staff_Auth"];
            
            [staffDetails setObject:[arStaffID objectAtIndex:selectedIndexPath.row]  forKey:@"Staff_ID"];
            [db updateStaff:staffDetails];
            
        }
        
        [self initalSetup];
        [tblUsers reloadData];
        
        txtPassword.text = @"";
        txtPasswordVerify.text= @"";
        
    }
}




- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return arAuthChoices.count;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return arAuthChoices[row];
}



@end














































