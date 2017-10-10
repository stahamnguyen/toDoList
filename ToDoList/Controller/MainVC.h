//
//  ViewController.h
//  ToDoList
//
//  Created by Staham Nguyen on 10/10/2017.
//  Copyright © 2017 Staham Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainVC : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)addButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)editButtonPressed:(UIBarButtonItem *)sender;

@end

