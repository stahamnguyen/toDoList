//
//  ItemDetailVC.m
//  ToDoList
//
//  Created by Staham Nguyen on 10/10/2017.
//  Copyright © 2017 Staham Nguyen. All rights reserved.
//

#import "ItemDetailVC.h"
#import "EditItemVC.h"

@interface ItemDetailVC ()

@end

@implementation ItemDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameLabel.text = self.item.name;
    self.locationLabel.text = self.item.location;
    self.performerLabel.text = self.item.performer;
    self.detailLabel.text = self.item.detail;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:self.item.dateOfCompletion];
    self.dateLabel.text = dateString;
}

- (IBAction)backButtonPressed:(UIButton *)sender {
    [self.delegate backButtonPressed];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.destinationViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationVC = segue.destinationViewController;
        EditItemVC *editItemVC = [navigationVC viewControllers][0];
        
        editItemVC.item = self.item;
        editItemVC.delegate = self;
    }
}

- (void)modifiedItems {
    
    self.nameLabel.text = self.item.name;
    self.locationLabel.text = self.item.location;
    self.performerLabel.text = self.item.performer;
    self.detailLabel.text = self.item.detail;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:self.item.dateOfCompletion];
    self.dateLabel.text = dateString;
    [self dismissViewControllerAnimated:true completion:nil];
    [self.delegate itemModified];
}

- (void)cancelButtonPressed {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
