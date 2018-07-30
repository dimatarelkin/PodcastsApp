//
//  CoreDataManager.m
//  PadcastsApp
//
//  Created by Dzmitry Tarelkin on 7/26/18.
//  Copyright © 2018 Dzmitry Tarelkin. All rights reserved.
//

#import "CoreDataManager.h"
#import "ItemMO+CoreDataClass.h"

static NSString * const kItemEntity = @"ItemMO";


@interface CoreDataManager ()
- (void)saveContext;
@end


static NSString * const kCoreDataBaseName = @"PadcastsApp";


@implementation CoreDataManager

+(CoreDataManager *)sharedManager {
    static CoreDataManager* manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CoreDataManager alloc] init];
    });
    
    return manager;
}

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
    
    if (!entityDescription) {
        NSLog(@"could not find entity description");
        return;
    }
    
    ItemMO* manageObject = [[ItemMO alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:self.persistentContainer.viewContext];
    manageObject.title  = item.title;
    manageObject.author = item.author;
    manageObject.details = item.details;
    manageObject.duration = item.duration;
    manageObject.guid = item.guiD;
    manageObject.sourceType = item.sourceType;
    manageObject.pubDate = [self createDateFromString:item.publicationDate];
    manageObject.isSaved = item.isSaved;
    
    manageObject.imageLocalLink = item.image.localLink;
    manageObject.imageWebLink = item.image.webLink;
  
    manageObject.contentLocalLink = item.content.localLink;
    manageObject.contentWebLink = item.content.webLink;
    
    
//    NSLog(@" local content = %@, web = %@",manageObject.contentLocalLink, manageObject.contentWebLink);
//    NSLog(@" image content = %@, web = %@",manageObject.imageLocalLink, manageObject.imageWebLink);
//    NSLog(@"title = %@",[manageObject description]);
    
    [self saveContext];
}

//DELETE
- (void)deleteItemFromCoredata:(ItemObject *)item {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:kItemEntity];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"guid == %@",item.guiD];
    [fetchRequest setPredicate:predicate];
    
    ItemMO *manageObject = [[self.persistentContainer.viewContext executeFetchRequest:fetchRequest error:nil] firstObject];
    if ([item.guiD isEqualToString: manageObject.guid]) {
        [self.persistentContainer.viewContext deleteObject:manageObject];
        [self saveContext];
        NSLog(@"Object has been deleted");
    }
}


//UPDATE
-(void)updateDataAndSetLocalLinks:(ItemObject*)item {
    NSFetchRequest *fetchRequest = [ItemMO fetchRequest];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"guid == %@",item.guiD];
    [fetchRequest setPredicate:predicate];

    ItemMO *manageObject = [[self.persistentContainer.viewContext executeFetchRequest:fetchRequest error:nil] firstObject];
    if ([item.guiD isEqualToString: manageObject.guid]) {
        manageObject.title  = item.title;
        manageObject.author = item.author;
        manageObject.details = item.details;
        manageObject.duration = item.duration;
        manageObject.sourceType = item.sourceType;
        manageObject.pubDate = [self createDateFromString:item.publicationDate];

        manageObject.contentLocalLink = item.content.localLink;
        manageObject.contentWebLink = item.content.webLink;
        manageObject.imageLocalLink = item.image.localLink;
        manageObject.imageWebLink = item.image.webLink;

        NSLog(@"item = %@", [item description]);
        [self saveContext];
        NSLog(@"Object has been updated");
    }
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
            for (ItemMO *manageObject in results) {
                //cleaning context
                [manageObject.managedObjectContext deleteObject:manageObject];
            }
            [self saveContext];
            NSLog(@"Context have been cleaned");
        }
    }
}


- (NSArray<ItemObject *> *)fetchAllItemsFromCoreData {
    NSFetchRequest *fetchRequest = [ItemMO fetchRequest];
    NSArray* results;
    NSMutableArray* items = [NSMutableArray array];
    
    if (!fetchRequest) {
        NSLog(@"error with fetch request");
    } else {
        results = [self.persistentContainer.viewContext executeFetchRequest:fetchRequest error:nil];
        
        for (ItemMO *manageObject in results) {
            ItemObject* item = [[ItemObject alloc] init];
            Image* img = [[Image alloc] init];
            Content* content = [[Content alloc] init];
           
          
            item.guiD = manageObject.guid;
            item.title = manageObject.title ;
            item.author =  manageObject.author;
            item.details = manageObject.details;
            item.duration = manageObject.duration;
            item.sourceType = (NSInteger)manageObject.sourceType == 0 ? MP3SourceType : TEDSourceType;
            item.publicationDate = [self stringFromDate: manageObject.pubDate];
            
            content.localLink = manageObject.contentLocalLink;
            content.webLink = manageObject.contentWebLink;
            img.localLink = manageObject.imageLocalLink;
            img.webLink = manageObject.imageWebLink;
            item.image = img;
            item.content = content;

            item.isSaved = manageObject.isSaved;
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

- (void)saveDataItemsIntoCoreData:(NSArray<ItemObject *> *)items {
    for (ItemObject* item in items  ) {
        [self saveItemIntoCoreData:item];
    }
}



#pragma mark - DateFormatting
-(NSString*)stringFromDate:(NSDate*)date {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"E dd MMM yyyy HH:mm"];
    NSString *string = [dateFormat stringFromDate:date];
    return string;
}

-(NSDate*)createDateFromString:(NSString*)string {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"E dd MMM yyyy HH:mm"];
    NSDate *date = [dateFormat dateFromString:string];
    return date;
}


@end
