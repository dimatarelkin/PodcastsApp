//
//  Manager.h
//  PadcastsApp
//
//  Created by Dzmitry Tarelkin on 7/23/18.
//  Copyright © 2018 Dzmitry Tarelkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parser.h"


@protocol DownloadManagerPrototcol <NSObject>
-(void)initWithURL:(NSURL*)url;
-(void)downloadDataFromURL:(NSURL*)url;
@end

@interface Manager : NSObject
-(instancetype)initWithXMLParser;
@end
