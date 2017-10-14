//
//  ItemDetailVC.m
//  ToDoList
//
//  Created by Staham Nguyen on 10/10/2017.
//  Copyright © 2017 Staham Nguyen. All rights reserved.
//

#import "ItemDetailVC.h"

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)editButtonPressed:(UIButton *)sender {
}

- (IBAction)backButtonPressed:(UIButton *)sender {
}
@end
