//
//  ItemManagedObject.m
//  PadcastsApp
//
//  Created by Dzmitry Tarelkin on 7/26/18.
//  Copyright © 2018 Dzmitry Tarelkin. All rights reserved.
//

#import "ItemManagedObject.h"
#import "ContentManagedObject.h"
#import "ImageManagedObject.h"

@implementation ItemManagedObject
@dynamic title;
@dynamic author;
@dynamic details;
@dynamic duration;
@dynamic guid;
@dynamic pubDate;
@dynamic sourceType;

//relations
@dynamic image;
@dynamic content;


////1
//- (NSString *)title {
//    NSString* title = nil;
//    [self willAccessValueForKey:kTitle];
//    title = [self primitiveValueForKey:kTitle];
//    [self didAccessValueForKey:kTitle];
//    NSLog(@"get title");
//    
//    return title;
//}
//
//- (void)setTitle:(NSString *)title {
//    [self willChangeValueForKey:kTitle];
//    [self setPrimitiveValue:title forKey:kTitle];
//    [self didChangeValueForKey:kTitle];
//    NSLog(@"set title");
//}
//
////2
//- (NSString *)author {
//    NSString* author = nil;
//    [self willAccessValueForKey:kAuthor];
//    author = [self primitiveValueForKey:kAuthor];
//    [self didAccessValueForKey:kAuthor];
//    NSLog(@"get author");
//    
//    return author;
//}
//
//- (void)setAuthor:(NSString *)author {
//    [self willChangeValueForKey:kAuthor];
//    [self setPrimitiveValue:author forKey:kAuthor];
//    [self didChangeValueForKey:kAuthor];
//    NSLog(@"set author");
//}
//
////3
//- (NSString *)details {
//    NSString* details = nil;
//    [self willAccessValueForKey:kDetails];
//    details = [self primitiveValueForKey:kDetails];
//    [self didAccessValueForKey:kDetails];
//    NSLog(@"get details");
//    
//    return details;
//}
//
//- (void)setDetails:(NSString *)details {
//    [self willChangeValueForKey:kDetails];
//    [self setPrimitiveValue:details forKey:kDetails];
//    [self didChangeValueForKey:kDetails];
//    NSLog(@"set details");
//}
//
//
////4
//- (NSString *)duration {
//    NSString* duration = nil;
//    [self willAccessValueForKey:kDuration];
//    duration = [self primitiveValueForKey:kDuration];
//    [self didAccessValueForKey:kDuration];
//    NSLog(@"get duration");
//    
//    return duration;
//}
//
//- (void)setDuration:(NSString *)duration {
//    [self willChangeValueForKey:kDuration];
//    [self setPrimitiveValue:duration forKey:kDuration];
//    [self didChangeValueForKey:kDuration];
//    NSLog(@"set duration");
//}
//
//
////5
//- (NSString *)guid {
//    NSString* guid = nil;
//    [self willAccessValueForKey:kGuid];
//    guid = [self primitiveValueForKey:kGuid];
//    [self didAccessValueForKey:kGuid];
//    NSLog(@"get guid");
//    
//    return guid;
//}
//- (void)setGuid:(NSString *)guid {
//    [self willChangeValueForKey:kGuid];
//    [self setPrimitiveValue:guid forKey:kGuid];
//    [self didChangeValueForKey:kGuid];
//    NSLog(@"set guid");
//}
//
//
////6
//- (NSDate *)pubDate {
//    NSDate* pubDate = nil;
//    [self willAccessValueForKey:kPubDate];
//    pubDate = [self primitiveValueForKey:kPubDate];
//    [self didAccessValueForKey:kPubDate];
//    NSLog(@"get pubDate");
//    
//    return pubDate;
//}
//
//- (void)setPubDate:(NSDate *)pubDate {
//    [self willChangeValueForKey:kPubDate];
//    [self setPrimitiveValue:pubDate forKey:kPubDate];
//    [self didChangeValueForKey:kPubDate];
//    NSLog(@"set pubDate");
//}
//
//
////7
//- (NSNumber*)sourceType {
//    NSNumber* sourceType = nil;
//    [self willAccessValueForKey:kSourceType];
//    sourceType = [self primitiveValueForKey:kSourceType];
//    [self didAccessValueForKey:kSourceType];
//    NSLog(@"get sourceType");
//    
//    return sourceType;
//}
//- (void)setSourceType:(NSNumber*)sourceType {
//    [self willChangeValueForKey:kSourceType];
//    [self setPrimitiveValue:sourceType forKey:kSourceType];
//    [self didChangeValueForKey:kSourceType];
//    NSLog(@"set sourceType");
//}
//
//- (ImageManagedObject *)image {
//    ImageManagedObject* image = [[ImageManagedObject alloc] init];
//    [self willAccessValueForKey:kImageEntity];
//    image = [self primitiveValueForKey:kImageEntity];
//    [self didAccessValueForKey:kImageEntity];
//    NSLog(@"get sourceType");
//    
//    return image;
//}
//
//- (void)setImage:(ImageManagedObject *)image {
//    [self willChangeValueForKey:kImageEntity];
//    [self setPrimitiveValue:image forKey:kImageEntity];
//    [self didChangeValueForKey:kImageEntity];
//    NSLog(@"set image");
//}
//
//
//- (ContentManagedObject *)content {
//    ContentManagedObject* content = [[ContentManagedObject alloc] init];
//    [self willAccessValueForKey:kContentEntity];
//    content = [self primitiveValueForKey:kContentEntity];
//    [self didAccessValueForKey:kContentEntity];
//    NSLog(@"get content");
//    
//    return content;
//}
//
//- (void)setContent:(ContentManagedObject *)content {
//    [self willChangeValueForKey:kContentEntity];
//    [self setPrimitiveValue:content forKey:kContentEntity];
//    [self didChangeValueForKey:kContentEntity];
//    NSLog(@"set content");
//}

- (NSString *)description {
    return [NSString stringWithFormat:@"\n guid = %@\n title = %@\n author = %@\n duration = %@\n sourceType = %@\n pubDate = %@\n image.webLink = %@\n image.localLink = %@\n content.webLink = %@\n content.localLink = %@\n details = %@",
            self.guid,
            self.title,
            self.author,
            self.duration,
            self.sourceType,
            [self.pubDate description],
            self.image.webLink,
            self.image.localLink,
            self.content.webLink,
            self.content.localLink,
            self.details];
}
@end


