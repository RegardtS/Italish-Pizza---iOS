//
//  TableSelectViewController.h
//  Italish Pizza
//
//  Created by Saint on 2014/10/19.
//  Copyright (c) 2014 Saint. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableSelectViewController : UIViewController


@property(weak, nonatomic)  NSArray* theSelectedItems;

- (IBAction)btnPressed:(id)sender;
- (IBAction)backPressed:(id)sender;
- (IBAction)btnTakeOrder:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btn1;
@property (strong, nonatomic) IBOutlet UIButton *btn2;
@property (strong, nonatomic) IBOutlet UIButton *btn3;
@property (strong, nonatomic) IBOutlet UIButton *btn4;
@property (strong, nonatomic) IBOutlet UIButton *btn5;
@property (strong, nonatomic) IBOutlet UIButton *btn6;
@property (strong, nonatomic) IBOutlet UIButton *btn7;
@property (strong, nonatomic) IBOutlet UIButton *btn8;
@property (strong, nonatomic) IBOutlet UIButton *btn9;
@property (strong, nonatomic) IBOutlet UIButton *btn10;
@property (strong, nonatomic) IBOutlet UIButton *btn11;
@property (strong, nonatomic) IBOutlet UIButton *btn12;
@property (strong, nonatomic) IBOutlet UIButton *btn13;
@property (strong, nonatomic) IBOutlet UIButton *btn14;
@property (strong, nonatomic) IBOutlet UIButton *btn0;


@end
