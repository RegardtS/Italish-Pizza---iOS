//
//  CustomerFormViewController.h
//  Italish Pizza
//
//  Created by Saint on 2014/10/15.
//  Copyright (c) 2014 Saint. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomerFormDelegate;


@interface CustomerFormViewController : UIViewController 

@property (strong, nonatomic) IBOutlet UITextField *txtName;
@property (strong, nonatomic) IBOutlet UITextField *txtSurname;
@property (strong, nonatomic) IBOutlet UITextField *txtContactNumber;
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;

- (IBAction)btnSave:(id)sender;
- (IBAction)btnClear:(id)sender;

@property (weak) id <CustomerFormDelegate> delegate;


@end

@protocol CustomerFormDelegate <NSObject>
@required
- (void)dismissWithSaveWithUsername:(NSString*)username withSurname:(NSString *)surname withContactNum:(NSString *)contactNum withEmail:(NSString *)email;

@end
