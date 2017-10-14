//
//  ItemDetailVC.h
//  ToDoList
//
//  Created by Staham Nguyen on 10/10/2017.
//  Copyright © 2017 Staham Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"
#import "EditItemVC.h"

@protocol ItemDetailVCProtocol <NSObject>

- (void)backButtonPressed;
- (void)itemModified;

@end


@interface ItemDetailVC : UIViewController <EditItemVCProtocol>

@property (strong, nonatomic) Item *item;
@property (weak, nonatomic) id <ItemDetailVCProtocol> delegate;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *performerLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

- (IBAction)backButtonPressed:(UIButton *)sender;

@end
