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
    
    NSArray *itemsDictionaryArray = [[NSUserDefaults standardUserDefaults] arrayForKey:OBJECT];
    for (NSDictionary *itemDictionary in itemsDictionaryArray) {
        Item *item = [self returnItemfromDictionary:itemDictionary];
        [self.items addObject:item];
    }
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
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Location: %@, Performer: %@", item.location, item.performer];
    
    return cell;
}

#pragma mark - Buttons methods

- (IBAction)addButtonPressed:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"mainVCToAddItemVC" sender:sender];
}

- (IBAction)editButtonPressed:(UIBarButtonItem *)sender {
    
    
}

#pragma mark - AddItemProtocol methods

- (void)createdItem:(Item *)item {
    
    [self.items addObject:item];
    
    NSMutableArray *itemsDictionaryArray = [[[NSUserDefaults standardUserDefaults] arrayForKey:OBJECT] mutableCopy];
    if (!itemsDictionaryArray) {
        itemsDictionaryArray = [[NSMutableArray alloc] init];
    }
    NSDictionary *itemDictionary = [self returnDictionaryFromItem:item];
    [itemsDictionaryArray addObject:itemDictionary];
    [[NSUserDefaults standardUserDefaults] setObject:itemsDictionaryArray forKey:OBJECT];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self dismissViewControllerAnimated:true completion:nil];
    [self.tableView reloadData];
}

- (void)cancelled {
    
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.destinationViewController isKindOfClass:[AddItemVC class]]) {
        AddItemVC *destinationVC = segue.destinationViewController;
        destinationVC.delegate = self;
    }
}

#pragma mark - Custom methods

- (NSDictionary *)returnDictionaryFromItem: (Item *) item {
    
    NSDictionary *itemDictionary = @{
                                     ITEM_NAME : item.name,
                                     ITEM_LOCATION : item.location,
                                     ITEM_PERFORMER : item.performer,
                                     ITEM_DETAIL : item.detail,
                                     ITEM_DATE : item.dateOfCompletion,
                                     ITEM_COMPLETED : @(item.isCompleted)
                                     };
    return itemDictionary;
}

- (Item *)returnItemfromDictionary: (NSDictionary *) itemDictionary {
    
    Item *item = [[Item alloc] initWithDictionary:itemDictionary];
    return item;
}

@end
