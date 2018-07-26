//
//  ContentManagedObject+CoreDataProperties.m
//  PadcastsApp
//
//  Created by Dmitriy Tarelkin on 26/7/18.
//  Copyright © 2018 Dzmitry Tarelkin. All rights reserved.
//
//

#import "ContentManagedObject+CoreDataProperties.h"

@implementation ContentManagedObject (CoreDataProperties)

+ (NSFetchRequest<ContentManagedObject *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"ContentManagedObject"];
}

@dynamic localLink;
@dynamic webLink;
@dynamic item;

@end
