//
//  ServiceManager.h
//  PadcastsApp
//
//  Created by Dzmitry Tarelkin on 7/24/18.
//  Copyright © 2018 Dzmitry Tarelkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parser.h"
#import "ItemObject.h"



@protocol ServiceDownloadDelegate <NSObject>
-(void)downloadingWasFinished:(NSArray*)result;
@end


@interface ServiceManager : NSObject <ParserDelegate>



//parser
-(void)downloadAndParseFileFromURL:(NSURL*)url withType:(SourceType)sourceType;
@property (weak, nonatomic) id<ServiceDownloadDelegate> delegate;

//coreData offline mode
-(void)saveDataItemsIntoCoreData:(NSArray<ItemObject*>*)items;
-(NSArray<ItemObject*>*)fetchDataFromCoreData;

//sandBox
-(void)saveContentIntoSandBox:(ItemObject*)item;
-(ItemObject*)fetchContentfromSandBox:(NSURL*)url;
@end
