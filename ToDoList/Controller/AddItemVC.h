//
//  AddItemVC.h
//  ToDoList
//
//  Created by Staham Nguyen on 10/10/2017.
//  Copyright © 2017 Staham Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddItemVC : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *weightTextField;
@property (weak, nonatomic) IBOutlet UITextField *heightTextField;
@property (weak, nonatomic) IBOutlet UITextView *detailTextView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)addItemButtonPressed:(UIButton *)sender;
- (IBAction)cancelButtonPressed:(UIButton *)sender;

@end
