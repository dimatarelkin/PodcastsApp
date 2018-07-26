//
//  CoreDataManager.m
//  PadcastsApp
//
//  Created by Dzmitry Tarelkin on 7/26/18.
//  Copyright © 2018 Dzmitry Tarelkin. All rights reserved.
//

#import "CoreDataManager.h"
#import "ItemManagedObject.h"
#import "ImageManagedObject.h"
#import "ContentManagedObject.h"


@interface CoreDataManager ()
- (void)saveContext;
@end


static NSString * const kCoreDataBaseName = @"PadcastsApp";


@implementation CoreDataManager

#pragma mark - Core Data stack
@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:kCoreDataBaseName];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}


#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

//@property (strong,nonatomic) NSString * title;
//@property (strong,nonatomic) NSString * author;
//@property (strong,nonatomic) NSString * details;
//@property (strong,nonatomic) NSString * duration;
//@property (strong,nonatomic) NSString * guid;
//@property (strong,nonatomic) NSDate   * pubDate;
//@property (assign,nonatomic) NSNumber * sourceType;
//
////relations
//@property (strong, nonatomic) ImageManagedObject *image;
//@property (strong, nonatomic) ContentManagedObject* content;


#pragma mark - CoreDataHandlingProtocol Methods

- (void)saveItemIntoCoreData:(ItemObject *)item {
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:kItemEntity inManagedObjectContext:self.persistentContainer.viewContext];
    
    if (!entityDescription) {
        NSLog(@"could not find entity description");
        return;
    }
    
    ItemManagedObject* manageObject = [[ItemManagedObject alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:self.persistentContainer.viewContext];
    manageObject.title  = item.title;
    manageObject.author = item.author;
    manageObject.details = item.details;
    manageObject.duration = item.duration;
    manageObject.guid = item.guiD;
    manageObject.sourceType = [NSNumber numberWithInteger: item.sourceType];
    manageObject.image.webLink = item.image.webLink;
    manageObject.image.localLink = item.image.localLink;
    manageObject.content.webLink = item.content.webLink;
    manageObject.content.localLink = item.content.localLink;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"E, dd MMM yyyy HH:mm:ss Z"];
    NSDate *date = [dateFormat dateFromString:item.publicationDate];
    [dateFormat setDateFormat:@"E dd MMM yyyy HH:mm"];
    manageObject.pubDate = date;
    
    NSLog(@"title = %@",[manageObject description]);
    
    [self saveContext];
}

//- (void)deleteItemFromCoredata:(ItemObject *)item {
//    <#code#>
//}
//
//- (NSArray<ItemObject *> *)fetchAllItemsFromCoreData {
//    <#code#>
//}
//
//- (ItemObject *)fetchItemfromCoredata:(NSString*)guid {
//    <#code#>
//}
//
//- (void)saveDataItemsIntoCoreData:(NSArray<ItemObject *> *)items {
//    <#code#>
//}



@end
