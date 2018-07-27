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


#pragma mark - CoreDataHandlingProtocol Methods
//ADD
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

//DELETE
- (void)deleteItemFromCoredata:(ItemObject *)item {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:kItemEntity];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"guid == %@",item.guiD];
    [fetchRequest setPredicate:predicate];
    
    ItemManagedObject *manageObject = [[self.persistentContainer.viewContext executeFetchRequest:fetchRequest error:nil] firstObject];
    if ([item.guiD isEqualToString: manageObject.guid]) {
        [self.persistentContainer.viewContext deleteObject:manageObject];
        [self saveContext];
        NSLog(@"Object has been deleted");
    }
}


//UPDATE
-(void)updateDataAndSetLocalLinks:(ItemObject*)item {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:kItemEntity];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"guid == %@",item.guiD];
    [fetchRequest setPredicate:predicate];
    
    ItemManagedObject *manageObject = [[self.persistentContainer.viewContext executeFetchRequest:fetchRequest error:nil] firstObject];
    if ([item.guiD isEqualToString: manageObject.guid]) {
        manageObject.title  = item.title;
        manageObject.author = item.author;
        manageObject.details = item.details;
        manageObject.duration = item.duration;
        manageObject.sourceType = item.sourceType;
        manageObject.pubDate = [self createDateFromString:item.publicationDate];
        manageObject.content.localLink = item.content.localLink;
        manageObject.content.webLink = item.content.webLink;
        manageObject.image.localLink = item.image.localLink;
        manageObject.image.webLink = item.image.webLink;
        
        NSLog(@"item = %@", [item description]);
        [self saveContext];
        NSLog(@"Object has been updated");
    }
}

-(NSDate*)createDateFromString:(NSString*)string {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"E dd MMM yyyy HH:mm"];
    NSDate *date = [dateFormat dateFromString:string];
    return date;
}


- (ItemObject *)fetchItemfromCoredata:(NSString*)guid {
    ItemObject *item = [[ItemObject alloc] init];
    NSArray *items = [self fetchAllItemsFromCoreData];
    
    for (ItemObject* itemObj in items ) {
        if ([guid isEqualToString:item.guiD]) {
            item = itemObj;
        }
    }
    return item;
}



-(void)deleteAllDataFromCoreData {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:kItemEntity];
    NSArray* results;
    
    if (!fetchRequest) {
        NSLog(@"error with fetch request");
    } else {
        results = [self.persistentContainer.viewContext executeFetchRequest:fetchRequest error:nil];
        if (results.count == 0) {
            NSLog(@"Context is empty");
        } else {
            for (ItemManagedObject *manageObject in results) {
                //cleaning context
                [manageObject.managedObjectContext deleteObject:manageObject];
            }
            [self saveContext];
            NSLog(@"Context have been cleaned");
        }
    }
}

- (NSArray<ItemObject *> *)fetchAllItemsFromCoreData {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:kItemEntity];
    NSArray* results;
    NSMutableArray* items = [NSMutableArray array];
    
    if (!fetchRequest) {
        NSLog(@"error with fetch request");
    } else {
        results = [self.persistentContainer.viewContext executeFetchRequest:fetchRequest error:nil];
        
        for (ItemManagedObject *manageObject in results) {
            ItemObject* item = [[ItemObject alloc] init];
          
            item.title = manageObject.title ;
            item.author =  manageObject.author;
            item.details = manageObject.details;
            item.duration = manageObject.duration;
            item.sourceType = (NSInteger)manageObject.sourceType == 0 ? MP3SourceType : TEDSourceType;
//            item.publicationDate = manageObject.pubDate;
            item.content.localLink = manageObject.content.localLink;
            item.content.webLink = manageObject.content.webLink;
            item.image.localLink = manageObject.image.localLink;
            item.image.webLink = manageObject.image.webLink;
            [items addObject:item];
        }
        
        if (items.count == 0) {
            NSLog(@"Context is empty");
        } else {
            NSLog(@"All Tasks have been fetched");
            NSLog(@"fetch %@",[items componentsJoinedByString:@"-"]);
        }
    }
    
    return items;
}




//
//- (void)saveDataItemsIntoCoreData:(NSArray<ItemObject *> *)items {
//    <#code#>
//}



@end
