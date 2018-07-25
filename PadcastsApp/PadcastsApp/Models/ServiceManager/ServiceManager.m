//
//  ServiceManager.m
//  PadcastsApp
//
//  Created by Dzmitry Tarelkin on 7/24/18.
//  Copyright © 2018 Dzmitry Tarelkin. All rights reserved.
//

#import "ServiceManager.h"


@interface ServiceManager()
@property (strong, nonatomic) Parser *parser;
@end

@implementation ServiceManager


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
    
}

-(NSArray<ItemObject*>*)fetchDataFromCoreData {
    NSArray* array;
    return array;
}





#pragma mark - SandBox Handler
-(void)saveContentIntoSandBox:(ItemObject*)item {
    
}
-(ItemObject*)fetchContentfromSandBox:(NSURL*)url {
    ItemObject *item = [[ItemObject alloc] init];
    return item;
}






@end
