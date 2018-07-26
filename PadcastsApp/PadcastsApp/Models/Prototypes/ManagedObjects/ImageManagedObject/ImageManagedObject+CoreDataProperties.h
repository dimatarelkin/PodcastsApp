//
//  ImageManagedObject+CoreDataProperties.h
//  PadcastsApp
//
//  Created by Dmitriy Tarelkin on 26/7/18.
//  Copyright © 2018 Dzmitry Tarelkin. All rights reserved.
//
//

#import "ImageManagedObject+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ImageManagedObject (CoreDataProperties)

+ (NSFetchRequest<ImageManagedObject *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *localLink;
@property (nullable, nonatomic, copy) NSString *webLink;
@property (nullable, nonatomic, retain) ItemManagedObject *item;

@end

NS_ASSUME_NONNULL_END
