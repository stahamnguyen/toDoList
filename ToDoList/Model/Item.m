//
//  Item.m
//  ToDoList
//
//  Created by Staham Nguyen on 10/10/2017.
//  Copyright © 2017 Staham Nguyen. All rights reserved.
//

#import "Item.h"

@implementation Item

- (instancetype)initWithDictionary: (NSDictionary *)itemDictionary
{
    self = [super init];
    if (self) {
        self.name = [itemDictionary objectForKey:ITEM_NAME];
        self.location = [itemDictionary objectForKey:ITEM_LOCATION];
        self.performer = [itemDictionary objectForKey:ITEM_PERFORMER];
        self.detail = [itemDictionary objectForKey:ITEM_DETAIL];
        self.dateOfCompletion = [itemDictionary objectForKey:ITEM_DATE];
        self.isCompleted = [[itemDictionary objectForKey:ITEM_COMPLETED] boolValue];
    }
    return self;
}

- (instancetype)init
{
    self = [self initWithDictionary:nil];
    
    return self;
}

@end
