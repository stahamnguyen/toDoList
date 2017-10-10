//
//  ItemDetailVC.h
//  ToDoList
//
//  Created by Staham Nguyen on 10/10/2017.
//  Copyright © 2017 Staham Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemDetailVC : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UILabel *lengthHeightLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

- (IBAction)editButtonPressed:(UIButton *)sender;
- (IBAction)backButtonPressed:(UIButton *)sender;

@end
