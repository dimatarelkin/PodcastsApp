//
//  Parser.m
//  PadcastsApp
//
//  Created by Dzmitry Tarelkin on 7/23/18.
//  Copyright © 2018 Dzmitry Tarelkin. All rights reserved.
//

#import "Parser.h"



@interface Parser()
@property (strong, nonatomic) NSXMLParser *xmlParser;
@property (strong, nonatomic) NSURL * url;
@property (strong, nonatomic) NSString * currentElement;
@property (strong, nonatomic) NSMutableDictionary *resultObject;
@property (assign, nonatomic) SourceType currentSourceType;
@property (strong, nonatomic) NSMutableArray* arrayOfObjects;
@property (strong, nonatomic) NSArray *tags;

@end



@implementation Parser



-(void)beginDownloadingWithURL:(NSURL*)url andSourceType:(SourceType)sourceType {
    self.currentSourceType = sourceType;
    self.tags = @[kElementItem,    kElementTitle,
                  kElementAuthor,  kElementDescription,
                  kElementDuration,kElementPubDate, kElementID];
    [self downloadDataFromURL:url];
}


- (void)downloadDataFromURL:(NSURL *)url{
    NSURLSession* session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *downloadTask =
    [session downloadTaskWithURL:url completionHandler:^(NSURL *  location, NSURLResponse *  response, NSError *  error) {

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
             NSData* data = [NSData dataWithContentsOfURL:location];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.xmlParser = [[NSXMLParser alloc] initWithData:data];
                self.xmlParser.delegate = self;
                [self.xmlParser parse];
            });
        });
    }];
    [downloadTask resume];
}



#pragma mark - NSXMLParserDelegate
- (void)parserDidStartDocument:(NSXMLParser *)parser {
    self.arrayOfObjects = [[NSMutableArray alloc] init]; //array of dicts
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    //reload smth when parsing did ends
    NSLog(@"objects =  %lu", (unsigned long)self.arrayOfObjects.count);
    
    //parser ends work
    NSArray* data = [NSArray arrayWithArray: [self getResultsFrom:self.arrayOfObjects]];
    
    //inform the delegate
    [self.delegate downloadingWasFinishedWithResult:data];
//    NSLog(@"%@", [self.delegate  description]);
    
}



-(NSArray*)getResultsFrom:(NSMutableArray*)arrayOfDicts {
    NSMutableArray* results = [NSMutableArray array];
    for (NSDictionary* objects in arrayOfDicts) {
        ItemObject* obj = [[ItemObject alloc] initWithDictionary:objects andSourceType:self.currentSourceType];
//        NSLog(@"obj = %@", [obj description]);
        [results addObject:obj];
    }
    return results;
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict {
    self.currentElement = elementName;

    if ([self.currentElement isEqualToString:kElementItem]) {
        self.resultObject = [NSMutableDictionary dictionary];
        
        for ( NSString* tag in self.tags ) {
            self.resultObject[tag] = [[NSMutableString alloc] init];
        }
    }
    
    if ([self.currentElement isEqualToString:kElementImage]) {
        [self.resultObject setObject:[attributeDict objectForKey:@"href"] forKey:kElementImage];
    }

    if ([self.currentElement isEqualToString:kElementContent]) {
        [self.resultObject setObject:[attributeDict objectForKey:@"url"] forKey:kElementContent];
    }
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    NSString * resultString;
    for ( NSString* tag in self.tags) {
        if ([self.currentElement isEqualToString:tag]) {
            resultString = [self parseString:string];
            [self.resultObject[tag] appendString:resultString];
        }
    }
}


-(NSString*)parseString:(NSString*)string {
    NSMutableString * resultString = [NSMutableString stringWithString:string];
    NSRange range;
//    [string stringByReplacingOccurrencesOfString:@"  " withString:@""];
//    [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//    [string stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    
    if ([resultString containsString:@"\n      "]) {
        range = [resultString rangeOfString:@"\n      "];
        [resultString deleteCharactersInRange:range];
    }

    if ([resultString containsString:@"  "]) {
        range = [resultString rangeOfString:@"  "];
        [resultString deleteCharactersInRange:range];
    }

    if ([resultString containsString:@"\n"]) {
        range = [resultString rangeOfString:@"\n"];
        [resultString deleteCharactersInRange:range];
    }
    
    return [resultString copy];
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName {

    if ([elementName isEqualToString: kElementItem]) {
        [self.arrayOfObjects addObject:self.resultObject];
//        NSLog(@"%@",[self.resultObject description]);
    }
}


- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"parser error = %@",[parseError localizedDescription]);
}




@end
