//
//  ServiceManager.h
//  PadcastsApp
//
//  Created by Dzmitry Tarelkin on 7/24/18.
//  Copyright © 2018 Dzmitry Tarelkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Parser.h"
#import "ItemObject.h"



@protocol ServiceDownloadDelegate <NSObject>
-(void)downloadingWasFinished:(NSArray*)result;
@end

//coreData offline mode
@protocol CoreDataHandlingProtocol <NSObject>
-(void)saveItemIntoCoreData:(ItemObject*)item;
-(void)deleteItemFromCoredata:(ItemObject*)item;
-(void)saveDataItemsIntoCoreData:(NSArray<ItemObject*>*)items;
-(NSArray<ItemObject*>*)fetchAllItemsFromCoreData;
-(ItemObject*)fetchItemfromCoredata:(NSString*)guid;
@end

//sandBox
@protocol SandBoxHanlderProtocol <NSObject>
-(void)saveContentIntoSandBoxForItem:(ItemObject*)item;
-(void)saveImageIntoSandBoxForItem:(ItemObject*)item;
-(UIImage*)fetchImageFromSandBoxForItem:(ItemObject*)item;  //returns image
-(ItemObject*)fetchContentfromSandBox:(ItemObject*)item;    //returns audio or video content
@end



@interface ServiceManager : NSObject <ParserDelegate, CoreDataHandlingProtocol, SandBoxHanlderProtocol>
//parser
-(void)downloadAndParseFileFromURL:(NSURL*)url withType:(SourceType)sourceType;
@property (weak, nonatomic) id<ServiceDownloadDelegate> delegate;


@end
