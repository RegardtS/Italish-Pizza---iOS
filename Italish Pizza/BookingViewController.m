//
//  BookingViewController.m
//  Italish Pizza
//
//  Created by Saint on 2014/09/07.
//  Copyright (c) 2014 Saint. All rights reserved.
//

#import "BookingViewController.h"

@interface BookingViewController (){
    NSMutableArray *dataArray;
}

@end

@implementation BookingViewController

@synthesize tblBookings;



- (void)viewDidLoad{
    [super viewDidLoad];
    
    tblBookings.dataSource = self;
    tblBookings.delegate = self;
    
    dataArray = [[NSMutableArray alloc] init];
    
    //Today section data
    NSArray *todayItemsArray = [[NSArray alloc] initWithObjects:@"Mr Alex", @"Mr Kev", @"Mr M.", nil];
    NSDictionary *todayItemsArrayDict = [NSDictionary dictionaryWithObject:todayItemsArray forKey:@"data"];
    [dataArray addObject:todayItemsArrayDict];
    
    //Tomorrow section data
    NSArray *tomorrowItemsArray = [[NSArray alloc] initWithObjects:@"Mr Alex", @"Mr Kev", @"Mr M.", nil];
    NSDictionary *tomorrowItemsArrayDict = [NSDictionary dictionaryWithObject:tomorrowItemsArray forKey:@"data"];
    [dataArray addObject:tomorrowItemsArrayDict];
    
    //Week section data
    NSArray *weekItemsArray = [[NSArray alloc] initWithObjects:@"Mr Alex", @"Mr Kev", @"Mr M.", nil];
    NSDictionary *weekItemsArrayDict = [NSDictionary dictionaryWithObject:weekItemsArray forKey:@"data"];
    [dataArray addObject:weekItemsArrayDict];
    
    //Month section data
    NSArray *monthItemsArray = [[NSArray alloc] initWithObjects:@"Mr Alex", @"Mr Kev", @"Mr M.", nil];
    NSDictionary *monthItemsArrayDict = [NSDictionary dictionaryWithObject:monthItemsArray forKey:@"data"];
    [dataArray addObject:monthItemsArrayDict];
    
    //Later section data
    NSArray *laterItemsArray = [[NSArray alloc] initWithObjects:@"Mr Alex", @"Mr Kev", @"Mr M.", nil];
    NSDictionary *laterItemsArrayDict = [NSDictionary dictionaryWithObject:laterItemsArray forKey:@"data"];
    [dataArray addObject:laterItemsArrayDict];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [dataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //Number of rows it should expect should be based on the section
    NSDictionary *dictionary = [dataArray objectAtIndex:section];
    NSArray *array = [dictionary objectForKey:@"data"];
    return [array count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Today";
        case 1:
            return @"Tomorrow";
        case 2:
            return @"This Week";
        case 3:
            return @"This Month";
        case 4:
            return @"Later";
    }
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *dictionary = [dataArray objectAtIndex:indexPath.section];
    NSArray *array = [dictionary objectForKey:@"data"];
    NSString *cellValue = [array objectAtIndex:indexPath.row];
    cell.textLabel.text = cellValue;
    cell.detailTextLabel.text = cellValue;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *selectedCell = nil;
    NSDictionary *dictionary = [dataArray objectAtIndex:indexPath.section];
    NSArray *array = [dictionary objectForKey:@"data"];
    selectedCell = [array objectAtIndex:indexPath.row];
    
    NSLog(@"%@ %i", selectedCell, indexPath.row);
    
    [tblBookings deselectRowAtIndexPath:indexPath animated:YES];
}











































@end
