//
//  EditItemVC.m
//  ToDoList
//
//  Created by Staham Nguyen on 10/10/2017.
//  Copyright © 2017 Staham Nguyen. All rights reserved.
//

#import "EditItemVC.h"

@interface EditItemVC () <UITextFieldDelegate>

@end

@implementation EditItemVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameTextField.delegate = self;
    self.locationTextField.delegate = self;
    self.performerTextField.delegate = self;
    
    self.nameTextField.text = self.item.name;
    self.locationTextField.text = self.item.location;
    self.performerTextField.text = self.item.performer;
    self.detailTextView.text = self.item.detail;
    self.datePicker.date = self.item.dateOfCompletion;
}


#pragma mark - Text Field methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return true;
}

- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender {
}

- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender {
}
@end
