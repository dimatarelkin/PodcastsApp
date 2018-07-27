//
//  Downloader.m
//  PadcastsApp
//
//  Created by Dzmitry Tarelkin on 7/26/18.
//  Copyright © 2018 Dzmitry Tarelkin. All rights reserved.
//

#import "Downloader.h"


@implementation Downloader


-(void)downloadImageForItem:(ItemObject*)item withCompletionBlock:(void(^)(NSData*)) completion {
    NSURL *url;
    if (item.sourceType == MP3SourceType) {
        url = [NSURL URLWithString: [NSString stringWithFormat:@"%@",item.image.webLink]];
    } else {
        url = [NSURL URLWithString: [NSString stringWithFormat:@"%@w=300",item.image.webLink]];
    }

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData* data = [NSData dataWithContentsOfURL:url];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(data);
        });
    });
  
    
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionDataTask *task = [session dataTaskWithURL:url
//                                        completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//            completion(data);
//        });
//        [session invalidateAndCancel];
//    }];
//    [task resume];
}
@end
