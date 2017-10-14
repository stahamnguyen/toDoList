//
//  ViewController.m
//  ToDoList
//
//  Created by Staham Nguyen on 10/10/2017.
//  Copyright © 2017 Staham Nguyen. All rights reserved.
//

#import "MainVC.h"
#import "ItemDetailVC.h"

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
        item.showLatenessAlertToUser = [[NSUserDefaults standardUserDefaults] boolForKey:SHOW_LATENESS_ALERT];
        item.showCompletionAlertToUser = [[NSUserDefaults standardUserDefaults] boolForKey:SHOW_COMPLETION_ALERT];
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
    
    //Format date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:item.dateOfCompletion];
    cell.detailTextLabel.text = dateString;
    
    //Check if the user is late to do a task.
    BOOL isBehindSchedule = [self isCurrentDate:[NSDate date] greaterThanASpecificDate:item.dateOfCompletion];
    
    if (item.isCompleted) {
        cell.backgroundColor = [UIColor greenColor];
        
        if (item.showCompletionAlertToUser) {
            item.showCompletionAlertToUser = false;
            [[NSUserDefaults standardUserDefaults] setBool:item.showCompletionAlertToUser forKey:SHOW_COMPLETION_ALERT];
            
            [self createAlertWithTitle:@"Task completed" withMessage:nil andActionTitle:@"OK"];
        }
        
    } else if (isBehindSchedule) {
        cell.backgroundColor = [UIColor redColor];
        
        if (item.showLatenessAlertToUser) {
            item.showLatenessAlertToUser = false;
            [[NSUserDefaults standardUserDefaults] setBool:item.showLatenessAlertToUser forKey:SHOW_LATENESS_ALERT];
            
            [self createAlertWithTitle:@"You're failed, my friend!" withMessage:@"We're running out of time." andActionTitle:@"OK"];
        }
    } else {
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self changeCompletionStatusOfItemAt:indexPath];
    [tableView reloadData];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return true;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.items removeObjectAtIndex:indexPath.row];
        
        NSMutableArray *remainingItemsDictionary = [[NSMutableArray alloc] init];
        
        for (Item *item in self.items) {
            [remainingItemsDictionary addObject:[self returnDictionaryFromItem:item]];
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:remainingItemsDictionary forKey:OBJECT];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return true;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    Item *item = [self.items objectAtIndex:sourceIndexPath.row];
    [self.items removeObjectAtIndex:sourceIndexPath.row];
    [self.items insertObject:item atIndex:destinationIndexPath.row];
    
    [self saveItemsToNSUserDefaults];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"mainVCToItemDetailVC" sender:indexPath];
}


#pragma mark - Buttons methods

- (IBAction)addButtonPressed:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"mainVCToAddItemVC" sender:sender];
}

- (IBAction)editButtonPressed:(UIBarButtonItem *)sender {
    [self.tableView setEditing:!self.tableView.editing];
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
    } else if ([sender isKindOfClass:[NSIndexPath class]]) {
        
        if ([segue.destinationViewController isKindOfClass:[ItemDetailVC class]]) {
            ItemDetailVC *itemDetailVC = segue.destinationViewController;
            NSIndexPath *indexPath = sender;
            
            Item *item = [self.items objectAtIndex:indexPath.row];
            itemDetailVC.item = item;
        }
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

- (BOOL)isCurrentDate: (NSDate *) currentDate greaterThanASpecificDate: (NSDate *) specificDate {
    NSTimeInterval currentDateTimeInterval = [currentDate timeIntervalSince1970];
    NSTimeInterval specificDateTimeInterval = [specificDate timeIntervalSince1970];
    return currentDateTimeInterval > specificDateTimeInterval;
}

- (void)changeCompletionStatusOfItemAt: (NSIndexPath *)indexPath {
    //Process data
    Item *selectedItem = [self.items objectAtIndex:indexPath.row];
    
    NSMutableArray *itemsDictionaryArray = [[[NSUserDefaults standardUserDefaults] arrayForKey:OBJECT] mutableCopy];
    
    if (!itemsDictionaryArray) {
        itemsDictionaryArray = [[NSMutableArray alloc] init];
    }
    [itemsDictionaryArray removeObjectAtIndex:indexPath.row];
    
    selectedItem.isCompleted = !selectedItem.isCompleted;
    
    NSDictionary *itemsDictionary = [self returnDictionaryFromItem:selectedItem];
    [itemsDictionaryArray insertObject:itemsDictionary atIndex:indexPath.row];
    
    [[NSUserDefaults standardUserDefaults] setObject:itemsDictionaryArray forKey:OBJECT];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //Show alert
    if (selectedItem.isCompleted) {
        [self createAlertWithTitle:@"Task completed" withMessage:nil andActionTitle:@"OK"];
    } else {
        [self createAlertWithTitle:@"You're failed, my friend!" withMessage:@"We're running out of time." andActionTitle:@"OK"];
    }
}

- (void)createAlertWithTitle: (NSString *)title withMessage: (NSString *)message andActionTitle: (NSString *)actionTitle {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:nil];
    
    [alertController addAction:alertAction];
    [self presentViewController:alertController animated:true completion:nil];
    
}

- (void)saveItemsToNSUserDefaults {
    
    NSMutableArray *itemsDictionaryArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [self.items count]; i++) {
        NSDictionary *itemDictionary = [self returnDictionaryFromItem:self.items[i]];
        [itemsDictionaryArray addObject:itemDictionary];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:itemsDictionaryArray forKey:OBJECT];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
