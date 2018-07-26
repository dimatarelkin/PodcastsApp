//
//  ServiceManager.m
//  PadcastsApp
//
//  Created by Dzmitry Tarelkin on 7/24/18.
//  Copyright © 2018 Dzmitry Tarelkin. All rights reserved.
//

#import "ServiceManager.h"
#import "CoreDataManager.h"


@interface ServiceManager()
@property (strong, nonatomic) Parser *parser;
@property (strong, nonatomic) CoreDataManager* coreDataManger;
@end

@implementation ServiceManager


- (instancetype)init {
    self = [super init];
    if (self) {
        self.coreDataManger = [[CoreDataManager alloc] init];
    }
    return self;
}

#pragma mark - XMLParser + ParserDelegate

-(void)downloadAndParseFileFromURL:(NSURL*)url withType:(SourceType)sourceType {
    self.parser = [[Parser alloc] init];
    self.parser.delegate = self;
    [self.parser  beginDownloadingWithURL:url andSourceType:sourceType];

}


- (void)downloadingWasFinishedWithResult:(NSArray *)result {
    //inform the delegate(tableView)
    [self.delegate downloadingWasFinished:result];
}





#pragma mark - CoreData offline mode
-(void)saveDataItemsIntoCoreData:(NSArray<ItemObject*>*)items {
    [self.coreDataManger saveDataItemsIntoCoreData:items];
}

- (void)deleteItemFromCoredata:(ItemObject *)item {
    [self.coreDataManger deleteItemFromCoredata:item];
}


- (NSArray<ItemObject *> *)fetchAllItemsFromCoreData {
    return [self.coreDataManger fetchAllItemsFromCoreData];
}


- (ItemObject *)fetchItemfromCoredata:(NSString*)guid {
    return [self.coreDataManger fetchItemfromCoredata:guid];
}


- (void)saveItemIntoCoreData:(ItemObject *)item {
    [self.coreDataManger saveItemIntoCoreData:item];
}







#warning incomplete sandbox methods
#pragma mark - SandBox Handler
-(void)saveContentIntoSandBox:(ItemObject*)item {
    
}
-(ItemObject*)fetchContentfromSandBox:(NSURL*)url {
    ItemObject *item = [[ItemObject alloc] init];
    return item;
}






@end
