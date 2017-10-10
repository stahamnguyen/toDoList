//
//  AddItemVC.h
//  ToDoList
//
//  Created by Staham Nguyen on 10/10/2017.
//  Copyright © 2017 Staham Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"

@protocol AddItemProtocol <NSObject>

- (void)createdItem: (Item *) item;
- (void)cancelled;

@end

@interface AddItemVC : UIViewController

@property (weak, nonatomic) id <AddItemProtocol> delegate;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;
@property (weak, nonatomic) IBOutlet UITextField *performerTextField;
@property (weak, nonatomic) IBOutlet UITextView *detailTextView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)addItemButtonPressed:(UIButton *)sender;
- (IBAction)cancelButtonPressed:(UIButton *)sender;

@end
