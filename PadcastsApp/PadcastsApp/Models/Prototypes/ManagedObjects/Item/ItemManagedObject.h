//
//  ItemManagedObject.h
//  PadcastsApp
//
//  Created by Dzmitry Tarelkin on 7/26/18.
//  Copyright © 2018 Dzmitry Tarelkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ImageManagedObject;
@class ContentManagedObject;


static NSString * const kItemEntity    = @"ItemManagedObject";
static NSString * const kContentEntity = @"ContentManagedObject";
static NSString * const kImageEntity   = @"ImageManagedObject";

static NSString * const kTitle         = @"title";
static NSString * const kAuthor        = @"author";
static NSString * const kDetails       = @"details";
static NSString * const kDuration      = @"duration";
static NSString * const kGuid          = @"guid";
static NSString * const kPubDate       = @"pubDate";
static NSString * const kSourceType    = @"sourceType";

static NSString * const kLocalLink     = @"localLink";
static NSString * const kWebLink       = @"webLink";


@interface ItemManagedObject : NSManagedObject

@property (strong,nonatomic) NSString * title;
@property (strong,nonatomic) NSString * author;
@property (strong,nonatomic) NSString * details;
@property (strong,nonatomic) NSString * duration;
@property (strong,nonatomic) NSString * guid;
@property (strong,nonatomic) NSDate   * pubDate;
@property (assign,nonatomic) NSNumber * sourceType;

//relations
@property (strong, nonatomic) ImageManagedObject *image;
@property (strong, nonatomic) ContentManagedObject* content;

@end
