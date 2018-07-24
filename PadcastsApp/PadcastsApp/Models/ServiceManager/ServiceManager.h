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

@interface ServiceManager : NSObject
-(void)downloadAndParseFileFromURL:(NSURL*)url withType:(SourceType)soureceType;
@end
