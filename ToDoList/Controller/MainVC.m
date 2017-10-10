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

- (NSMutableArray *)items {
    if(!_items) {
        _items = [[NSMutableArray alloc] init];
    }
    return _items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

#pragma mark - UITableView methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    //Configure cell
    Item *item = [self.items objectAtIndex:indexPath.row];
    cell.textLabel.text = item.name;
    
    return cell;
}

#pragma mark - Buttons methods

- (IBAction)addButtonPressed:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"mainVCToAddItemVC" sender:sender];
}

- (IBAction)editButtonPressed:(UIBarButtonItem *)sender {
    
    
}

#pragma mark - AddItemProtocol methods

-(void)createdItem:(Item *)item {
    
    [self.items addObject:item];
    [self dismissViewControllerAnimated:true completion:nil];
    [self.tableView reloadData];
}

-(void)cancelled {
    
}


@end
