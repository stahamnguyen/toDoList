//
//  AddItemVC.m
//  ToDoList
//
//  Created by Staham Nguyen on 10/10/2017.
//  Copyright © 2017 Staham Nguyen. All rights reserved.
//

#import "AddItemVC.h"

@interface AddItemVC () <UITextFieldDelegate>

@end

@implementation AddItemVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameTextField.delegate = self;
    self.locationTextField.delegate = self;
    self.performerTextField.delegate = self;
}

#pragma mark - Text Field methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return true;
}

#pragma mark - Button methods

- (IBAction)addItemButtonPressed:(UIButton *)sender {
    
    Item *item = [self createNewItem];
    
    [self.delegate createdItem:item];
}

- (IBAction)cancelButtonPressed:(UIButton *)sender {
    
    [self.delegate cancelled];
}

#pragma mark - Custom methods

- (Item *)createNewItem {
    Item *item = [[Item alloc] init];
    item.name = self.nameTextField.text;
    item.location = self.locationTextField.text;
    item.performer = self.performerTextField.text;
    item.detail = self.detailTextView.text;
    item.dateOfCompletion = self.datePicker.date;
    
    return item;
}

@end
