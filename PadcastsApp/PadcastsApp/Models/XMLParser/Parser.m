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

@end

//    NSString *urlString = @"https://rss.simplecast.com/podcasts/4669/rss";

static NSString * const kElementItem        = @"item";
static NSString * const kElementTitle       = @"title";
static NSString * const kElementAuthor      = @"itunes:author";
static NSString * const kElementDescription = @"description";
static NSString * const kElementContent     = @"enclosure";
static NSString * const kElementImage       = @"itunes:image";
static NSString * const kElementDuration    = @"itunes:duration";
static NSString * const kElementPubDate     = @"pubDate";
static NSString * const kElementID          = @"guid";




@implementation Parser

- (instancetype)initWithURL:(NSURL*)url resourceType:(SourceType)sourceType {
    self = [super init];
    if (self) {
        self.tags = @[kElementItem, kElementTitle, kElementAuthor,
                      kElementDescription, kElementContent,
                      kElementImage,kElementPubDate, kElementID];
        [self downloadDataFromURL:url];
    }
    return self;
}




- (void)downloadDataFromURL:(NSURL *)url {
    NSURLSession* session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *downloadTask =
    [session downloadTaskWithURL:url completionHandler:^(NSURL *  location, NSURLResponse *  response, NSError *  error) {

        NSData* data = [NSData dataWithContentsOfURL:location];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.xmlParser = [[NSXMLParser alloc] initWithData:data];
            self.xmlParser.delegate = self;
            [self.xmlParser parse];
        });
        [session invalidateAndCancel];
    }];
    [downloadTask resume];
}



#pragma mark NSXMLParserDelegate
- (void)parserDidStartDocument:(NSXMLParser *)parser {
    self.arrayOfObjects = [[NSMutableArray alloc] init];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    //reload smth when parsing did ends
    NSLog(@"opbjects = %@ , %d", [self.arrayOfObjects componentsJoinedByString:@"\n"], self.arrayOfObjects.count);
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict {

    self.currentElement = elementName;
    if ([self.currentElement isEqualToString:kElementItem]) {
        self.resultObject = [NSMutableDictionary dictionary];
        for ( NSString* tag in self.tags ) {
            self.resultObject[tag] = [[NSMutableString alloc] init];
        }
    }
    
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {

    for ( NSString* tag in self.tags) {
        if ([self.currentElement isEqualToString:tag]) {
            [self.resultObject[tag] appendString:string];
        }
    }
//        if ([self.currentElement isEqualToString:kElementTitle]) {
//            [self.object setTitle:string];
//            NSLog(@"title - %@, string = %@",self.object.title, string);
//        } else if ([self.currentElement isEqualToString: kElementDescription]) {
//            self.object.descrip = string;
//            NSLog(@"descrip - %@, string = %@",self.object.descrip, string);
//        } else if ([self.currentElement isEqualToString: kElementPubDate]) {
//            self.object.publicationDate = string;
//            NSLog(@"publicationDate - %@, string = %@",self.object.publicationDate, string);
//        } else if ([self.currentElement isEqualToString: kElementAuthor]) {
//            self.object.author = string;
//            NSLog(@"author - %@, string = %@",self.object.author, string);
//        } else if ([self.currentElement isEqualToString: kElementImage]) {
//            self.object.image.webLink = string;
//            NSLog(@"image - %@, string = %@",self.object.image.webLink, string);
//        } else if ([self.currentElement isEqualToString: kElementDuration]) {
//            self.object.duration = string;
//            NSLog(@"duration - %@, string = %@",self.object.duration, string);
//        } else if ([self.currentElement isEqualToString: kElementContent]) {
//            self.object.content.webLink = string;
//            NSLog(@"content - %@, string = %@",self.object.content.webLink, string);
//        } else if ([self.currentElement isEqualToString: kElementID]){
//            self.object.guiD = string;
//            NSLog(@"guid - %@, string = %@",self.object.guiD, string);
//        }

}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName {

    if ([elementName isEqualToString: kElementItem]) {
        [self.arrayOfObjects addObject:self.resultObject];
        NSLog(@"%@",[self.resultObject description]);
    }
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"%@",[parseError localizedDescription]);
}












@end
