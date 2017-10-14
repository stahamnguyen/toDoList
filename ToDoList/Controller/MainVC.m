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

- (BOOL)isCurrentDate: (NSDate *) currentDate greaterThanASpecificDate: (NSDate *) specificDate {
    NSTimeInterval currentDateTimeInterval = [currentDate timeIntervalSince1970];
    NSTimeInterval specificDateTimeInterval = [specificDate timeIntervalSince1970];
    return currentDateTimeInterval > specificDateTimeInterval;
}

- (void)changeCompletionStatusOfItemAt: (NSIndexPath *)indexPath {
    Item *selectedItem = [self.items objectAtIndex:indexPath.row];
    selectedItem.isCompleted = !selectedItem.isCompleted;
}

- (void)createAlertWithTitle: (NSString *)title withMessage: (NSString *)message andActionTitle: (NSString *)actionTitle {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:nil];
    
    [alertController addAction:alertAction];
    [self presentViewController:alertController animated:true completion:nil];
    
}

@end
