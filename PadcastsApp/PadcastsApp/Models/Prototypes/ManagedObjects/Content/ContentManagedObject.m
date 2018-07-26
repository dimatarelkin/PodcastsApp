//
//  ContentManagedObject.m
//  PadcastsApp
//
//  Created by Dzmitry Tarelkin on 7/26/18.
//  Copyright © 2018 Dzmitry Tarelkin. All rights reserved.
//

#import "ContentManagedObject.h"
#import "ItemManagedObject.h"

@implementation ContentManagedObject
@dynamic localLink;
@dynamic webLink;

//relation
@dynamic item;


- (NSString *)localLink {
    NSString* localLink = nil;
    [self willAccessValueForKey:kLocalLink];
    localLink = [self primitiveValueForKey:kLocalLink];
    [self didAccessValueForKey:kLocalLink];
    NSLog(@"get localLink");
    
    return localLink;
}

- (void)setLocalLink:(NSString *)localLink {
    [self willChangeValueForKey:kLocalLink];
    [self setPrimitiveValue:localLink forKey:kLocalLink];
    [self didChangeValueForKey:kLocalLink];
    NSLog(@"set localLink");
}

- (NSString *)webLink {
    NSString* webLink = nil;
    [self willAccessValueForKey:kWebLink];
    webLink = [self primitiveValueForKey:kWebLink];
    [self didAccessValueForKey:kWebLink];
    NSLog(@"get webLink");
    
    return webLink;
}

- (void)setWebLink:(NSString *)webLink {
    [self willChangeValueForKey:kWebLink];
    [self setPrimitiveValue:webLink forKey:kWebLink];
    [self didChangeValueForKey:kWebLink];
    NSLog(@"set webLink");
}

//relation
- (ItemManagedObject *)item {
    ItemManagedObject* item = nil;
    [self willAccessValueForKey:kItemEntity];
    item = [self primitiveValueForKey:kItemEntity];
    [self didAccessValueForKey:kItemEntity];
    NSLog(@"get item");
    
    return item;
}

- (void)setItem:(ItemManagedObject *)item {
    [self willChangeValueForKey:kItemEntity];
    [self setPrimitiveValue:item forKey:kItemEntity];
    [self didChangeValueForKey:kItemEntity];
    NSLog(@"set item");
}
@end
