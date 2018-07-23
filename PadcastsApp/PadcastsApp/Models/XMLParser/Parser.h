//
//  Parser.h
//  PadcastsApp
//
//  Created by Dzmitry Tarelkin on 7/23/18.
//  Copyright © 2018 Dzmitry Tarelkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Manager.h"
#import "Object.h"

@interface Parser : NSObject <NSXMLParserDelegate>
@property (strong, nonatomic) Object* object;
@property (strong, nonatomic) NSMutableArray<Object*>* arrayOfObjects;
@property (strong, nonatomic) NSDictionary *tags;
- (instancetype)initWithURL:(NSURL*)url resourceType:(SourceType)sourceType;
@end
