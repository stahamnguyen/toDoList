//
//  Item.h
//  ToDoList
//
//  Created by Staham Nguyen on 10/10/2017.
//  Copyright © 2017 Staham Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *performer;
@property (nonatomic, strong) NSString *detail;
@property (nonatomic, strong) NSDate *dateOfCompletion;
@property (nonatomic) BOOL isCompleted;

@end
