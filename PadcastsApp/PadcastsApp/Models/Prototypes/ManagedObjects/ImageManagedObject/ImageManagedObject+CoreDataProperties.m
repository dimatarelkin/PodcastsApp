//
//  ImageManagedObject+CoreDataProperties.m
//  PadcastsApp
//
//  Created by Dmitriy Tarelkin on 26/7/18.
//  Copyright © 2018 Dzmitry Tarelkin. All rights reserved.
//
//

#import "ImageManagedObject+CoreDataProperties.h"

@implementation ImageManagedObject (CoreDataProperties)

+ (NSFetchRequest<ImageManagedObject *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"ImageManagedObject"];
}

@dynamic localLink;
@dynamic webLink;
@dynamic item;

@end
