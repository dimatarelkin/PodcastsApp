//
//  ServiceManager.m
//  PadcastsApp
//
//  Created by Dzmitry Tarelkin on 7/24/18.
//  Copyright © 2018 Dzmitry Tarelkin. All rights reserved.
//

#import "ServiceManager.h"
#import "CoreDataManager.h"
#import "SandBoxManager.h"
#import "Downloader.h"


@interface ServiceManager()
@property (strong, nonatomic) Parser          * parser;
@property (strong, nonatomic) CoreDataManager * coreDataManger;
@property (strong, nonatomic) SandBoxManager  * sandBoxManager;
@property (strong, nonatomic) Downloader      * downloadManager;
@end

@implementation ServiceManager


- (instancetype)init {
    self = [super init];
    if (self) {
        self.coreDataManger  = [[CoreDataManager alloc] init];
        self.sandBoxManager  = [[SandBoxManager alloc] init];
        self.downloadManager = [[Downloader alloc] init];
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

- (void)updateDataAndSetLocalLinks:(ItemObject *)item {
    [self.coreDataManger updateDataAndSetLocalLinks:item];
}








#warning incomplete sandbox methods
#pragma mark - SandBox Handler


- (UIImage *)fetchImageFromSandBoxForItem:(ItemObject *)item {
    return  [self.sandBoxManager fetchImageFromSandBoxForItem:item];
}

- (void)saveContent:(NSObject *)content IntoSandBoxForItem:(ItemObject *)item {
    [self.sandBoxManager saveContent:content IntoSandBoxForItem:item];
}

- (void)saveDataWithImage:(NSData*)data IntoSandBoxForItem:(ItemObject *)item{
    [self.sandBoxManager saveDataWithImage:data IntoSandBoxForItem:item];
}






#pragma mark - DownloadManager

-(void)downloadImageForItem:(ItemObject*)item withCompletionBlock:(void(^)(NSData*)) completion {
    
    [self.downloadManager downloadImageForItem:item withCompletionBlock:^(NSData* data) {
        completion(data);
        [self saveDataWithImage:data IntoSandBoxForItem:item];
    }];
    
}

@end
