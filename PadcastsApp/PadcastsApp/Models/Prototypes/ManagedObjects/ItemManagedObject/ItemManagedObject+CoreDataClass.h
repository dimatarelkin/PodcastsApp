//
//  ItemManagedObject+CoreDataClass.h
//  PadcastsApp
//
//  Created by Dmitriy Tarelkin on 26/7/18.
//  Copyright © 2018 Dzmitry Tarelkin. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ContentManagedObject, ImageManagedObject;

NS_ASSUME_NONNULL_BEGIN

@interface ItemManagedObject : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "ItemManagedObject+CoreDataProperties.h"
