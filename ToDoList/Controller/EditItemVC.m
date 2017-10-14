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


#pragma mark - Buttons methods

- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender {
    [self.delegate cancelButtonPressed];
}

- (IBAction)saveButtonPressed:(UIBarButtonItem *)sender {
    
    [self modifyItem];
    [self.delegate modifiedItems];
}


#pragma mark - Custom methods

- (void)modifyItem {
    
    self.item.name = self.nameTextField.text;
    self.item.location = self.locationTextField.text;
    self.item.performer = self.performerTextField.text;
    self.item.detail = self.detailTextView.text;
    self.item.dateOfCompletion = self.datePicker.date;
}

@end
