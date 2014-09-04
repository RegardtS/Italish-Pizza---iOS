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


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    tblUsers.delegate = self;
    tblUsers.dataSource = self;
    
    tblUsers.contentInset = UIEdgeInsetsMake(20.0f, 0.0f, 58.0f, 0.0f);


    db = [[DatabaseHelper alloc] init];
    
    
    arStaffNames=[[NSMutableArray alloc] init];
    arStaffAuth=[[NSMutableArray alloc] init];
    arStaffID=[[NSMutableArray alloc] init];
    
    arStaffDetails = [db getAllStaff];
    
    
    for (int i = 0; i < [arStaffDetails count]; i+=3) {
        [arStaffNames addObject:[arStaffDetails objectAtIndex:i]];
        [arStaffAuth addObject:[arStaffDetails objectAtIndex:i+1]];
        [arStaffID addObject:[arStaffDetails objectAtIndex:i+2]];
    }
    [arStaffNames addObject:@"Add new user"];
    
    arAuthChoices = @[@"Runner", @"Waiter", @"Manager"];
    pkAuth.delegate = self;
    pkAuth.dataSource = self;
    
    
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
    if (indexPath.row == [arStaffNames count]-1) {
        txtUsername.text = @"";
        txtPassword.text = @"";
        txtPasswordVerify.text = @"";
        lblUsername.text = @"<Username>";
    }else{
        lblUsername.text = [arStaffNames objectAtIndex:indexPath.row];
        
        //        KEY_STAFF_NAME,KEY_STAFF_AUTHORITY,KEY_STAFF_ID
        
    }
    
    
}


- (IBAction)btnSave:(id)sender {
    NSLog(@"saved pressed");
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














































