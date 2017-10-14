//
//  EditItemVC.h
//  ToDoList
//
//  Created by Staham Nguyen on 10/10/2017.
//  Copyright © 2017 Staham Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"

@protocol EditItemVCProtocol <NSObject>

- (void)cancelButtonPressed;
- (void)modifiedItems;

@end


@interface EditItemVC : UIViewController

@property (weak, nonatomic) id <EditItemVCProtocol> delegate;
@property (strong, nonatomic) Item *item;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;
@property (weak, nonatomic) IBOutlet UITextField *performerTextField;
@property (weak, nonatomic) IBOutlet UITextView *detailTextView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender;

@end
