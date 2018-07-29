//
//  ItemManagedObject+CoreDataProperties.m
//  PadcastsApp
//
//  Created by Dmitriy Tarelkin on 29/7/18.
//  Copyright © 2018 Dzmitry Tarelkin. All rights reserved.
//
//

#import "ItemManagedObject+CoreDataProperties.h"

@implementation ItemManagedObject (CoreDataProperties)

+ (NSFetchRequest<ItemManagedObject *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"ItemManagedObject"];
}

@dynamic author;
@dynamic details;
@dynamic duration;
@dynamic guid;
@dynamic pubDate;
@dynamic sourceType;
@dynamic title;
@dynamic isSaved;
@dynamic content;
@dynamic image;

@end
