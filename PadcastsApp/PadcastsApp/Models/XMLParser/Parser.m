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
@property (strong, nonatomic) NSString * foundValue;
@end

//    NSString *urlString = @"https://rss.simplecast.com/podcasts/4669/rss";

static NSString * const kElementTitle       = @"title";
static NSString * const kElementAuthor      = @"author";
static NSString * const kElementDescription = @"description";
static NSString * const kElementContent     = @"content";
static NSString * const kElementImage       = @"image";
static NSString * const kElementDuration    = @"duration";
static NSString * const kElementPubDate     = @"pubDate";











@implementation Parser

- (instancetype)initWithURL:(NSURL*)url resourceType:(SourceType)sourceType {
    self = [super init];
    if (self) {
//        [self downloadDataFromURL:url];
        _xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
        self.xmlParser.delegate = self;
        [self.xmlParser parse];
        
    }
    return self;
}




- (void)downloadDataFromURL:(NSURL *)url {
    NSURLSession* session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *downloadTask =
    [session downloadTaskWithURL:url completionHandler:^(NSURL *  location, NSURLResponse *  response, NSError *  error) {
        
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            NSURL* locationURL = location;
//
//            dispatch_async(dispatch_get_main_queue(), ^{
//                self.xmlParser = [NSXMLParser alloc] initWithContentsOfURL:<#(nonnull NSURL *)#>
//            });
//        });
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.url = location;
        });
     
    }];
    [downloadTask resume];
}



#pragma mark NSXMLParserDelegate
- (void)parserDidStartDocument:(NSXMLParser *)parser {
    self.arrayOfObjects = [[NSMutableArray alloc] init];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    //reload smth when parsing did ends
    NSLog(@"opbjects = %@ , %d", [self.arrayOfObjects componentsJoinedByString:@"-"], self.arrayOfObjects.count);
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"%@",[parseError localizedDescription]);
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict {
  
    if ([elementName isEqualToString:@"item"]) {
        self.object = [[Object alloc] init];
    }
    self.currentElement = elementName;
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
   
    if ([self.currentElement isEqualToString: @"title"]) {
        self.object.title = string;
    } else if ([self.currentElement isEqualToString: @"description"]) {
        self.object.descrip = string;
    } else if ([self.currentElement isEqualToString: @"pubDate"]) {
        self.object.publicationDate = string;
    } else if ([self.currentElement isEqualToString: @"itunes:author"]) {
        self.object.author = string;
    } else if ([self.currentElement isEqualToString: @"itunes:image"]) {
        self.object.image.webLink = string;
    } else if ([self.currentElement isEqualToString: @"itunes:duration"]) {
        self.object.duration = string;
    } else if ([self.currentElement isEqualToString: @"enclosure"]) {
        self.object.content.webLink = string;
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName {
    if ([elementName isEqualToString: @"item"]) {
        [self.arrayOfObjects addObject:self.object];
        NSLog(@"%@",[self.arrayOfObjects description]);
    }
}














@end
