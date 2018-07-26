//
//  ContentManagedObject.h
//  PadcastsApp
//
//  Created by Dzmitry Tarelkin on 7/26/18.
//  Copyright © 2018 Dzmitry Tarelkin. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ItemManagedObject;

@interface ContentManagedObject : NSManagedObject
@property (strong, nonatomic) NSString * localLink;
@property (strong, nonatomic) NSString * webLink;

//relation
@property (strong, nonatomic) ItemManagedObject *item;
@end
