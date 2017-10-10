//
//  ViewController.m
//  ToDoList
//
//  Created by Staham Nguyen on 10/10/2017.
//  Copyright © 2017 Staham Nguyen. All rights reserved.
//

#import "MainVC.h"

@interface MainVC () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation MainVC

static NSString *cellId = @"cellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

#pragma mark - UITableView methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    //Configure cell
    cell.textLabel.text = @"Item";
    
    return cell;
}

#pragma mark - Buttons methods

- (IBAction)addButtonPressed:(UIBarButtonItem *)sender {
}

- (IBAction)editButtonPressed:(UIBarButtonItem *)sender {
}
@end
