//
//  ContentManagedObject+CoreDataProperties.h
//  PadcastsApp
//
//  Created by Dmitriy Tarelkin on 26/7/18.
//  Copyright © 2018 Dzmitry Tarelkin. All rights reserved.
//
//

#import "ContentManagedObject+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ContentManagedObject (CoreDataProperties)

+ (NSFetchRequest<ContentManagedObject *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *localLink;
@property (nullable, nonatomic, copy) NSString *webLink;
@property (nullable, nonatomic, retain) ItemManagedObject *item;

@end

NS_ASSUME_NONNULL_END
