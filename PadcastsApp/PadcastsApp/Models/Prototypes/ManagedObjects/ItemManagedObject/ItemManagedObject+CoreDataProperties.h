//
//  ItemManagedObject+CoreDataProperties.h
//  PadcastsApp
//
//  Created by Dmitriy Tarelkin on 26/7/18.
//  Copyright © 2018 Dzmitry Tarelkin. All rights reserved.
//
//

#import "ItemManagedObject+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ItemManagedObject (CoreDataProperties)

+ (NSFetchRequest<ItemManagedObject *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *author;
@property (nullable, nonatomic, copy) NSString *details;
@property (nullable, nonatomic, copy) NSString *duration;
@property (nullable, nonatomic, copy) NSString *guid;
@property (nullable, nonatomic, copy) NSDate *pubDate;
@property (nonatomic) int64_t sourceType;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, retain) ContentManagedObject *content;
@property (nullable, nonatomic, retain) ImageManagedObject *image;

@end

NS_ASSUME_NONNULL_END
