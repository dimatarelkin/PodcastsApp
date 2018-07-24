//
//  Parser.h
//  PadcastsApp
//
//  Created by Dzmitry Tarelkin on 7/23/18.
//  Copyright © 2018 Dzmitry Tarelkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ItemObject.h"

@interface Parser : NSObject <NSXMLParserDelegate>
@property (strong, nonatomic) NSMutableArray* arrayOfObjects;
@property (strong, nonatomic) NSArray *tags;
- (instancetype)initWithURL:(NSURL*)url resourceType:(SourceType)sourceType;
@end
