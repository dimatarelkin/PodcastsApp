//
//  CoreDataManager.m
//  PadcastsApp
//
//  Created by Dzmitry Tarelkin on 7/26/18.
//  Copyright © 2018 Dzmitry Tarelkin. All rights reserved.
//

#import "CoreDataManager.h"
#import "ItemManagedObject+CoreDataClass.h"
#import "ImageManagedObject+CoreDataClass.h"
#import "ContentManagedObject+CoreDataClass.h"

static NSString * const kItemEntity = @"ItemManagedObject";
static NSString * const kImageEntity = @"ImageManagedObject";
static NSString * const kContentEntity = @"ContentManagedObject";

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
    NSEntityDescription *imageEntityDiscription = [NSEntityDescription entityForName:kImageEntity inManagedObjectContext:self.persistentContainer.viewContext];
    NSEntityDescription *contentEntityDiscription = [NSEntityDescription entityForName:kContentEntity inManagedObjectContext:self.persistentContainer.viewContext];
    
    if (!entityDescription) {
        NSLog(@"could not find entity description");
        return;
    }
    
    ItemManagedObject* manageObject = [[ItemManagedObject alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:self.persistentContainer.viewContext];
    ImageManagedObject *imageManagedObject = [[ImageManagedObject alloc] initWithEntity:imageEntityDiscription insertIntoManagedObjectContext:self.persistentContainer.viewContext];
    ContentManagedObject *contentManagedObject = [[ContentManagedObject alloc] initWithEntity:contentEntityDiscription insertIntoManagedObjectContext:self.persistentContainer.viewContext];
    
    manageObject.title  = item.title;
    manageObject.author = item.author;
    manageObject.details = item.details;
    manageObject.duration = item.duration;
    manageObject.guid = item.guiD;
    manageObject.sourceType = item.sourceType;
    manageObject.pubDate = [self createDateFromString:item.publicationDate];
    
    [manageObject setImage:imageManagedObject];
    imageManagedObject.localLink = item.image.localLink;
    imageManagedObject.webLink = item.image.webLink;
    
    [manageObject setContent: contentManagedObject];
    contentManagedObject.localLink = item.content.localLink;
    contentManagedObject.webLink = item.content.webLink;
    
    
    NSLog(@" local content = %@, web = %@",contentManagedObject.localLink, contentManagedObject.webLink);
    NSLog(@" image content = %@, web = %@",imageManagedObject.localLink, imageManagedObject.webLink);
    NSLog(@"title = %@",[manageObject description]);
    
    [self saveContext];
}

-(NSDate*)createDateFromString:(NSString*)string {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"E dd MMM yyyy HH:mm"];
    NSDate *date = [dateFormat dateFromString:string];
    return date;
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
