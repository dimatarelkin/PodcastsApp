//
//  Downloader.m
//  PadcastsApp
//
//  Created by Dzmitry Tarelkin on 7/26/18.
//  Copyright © 2018 Dzmitry Tarelkin. All rights reserved.
//

#import "Downloader.h"
#import "SandBoxManager.h"


@implementation Downloader


+(Downloader*)sharedDownloader {
    static Downloader* downloader = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        downloader = [[Downloader alloc] init];
    });
    return downloader;
}


-(void)downloadImageForItem:(ItemObject*)item withImageQuality:(ImageQuality)quality
        withCompletionBlock:(void(^)(NSData*)) completion {
    NSURL *url;
    
    if (item.sourceType == MP3SourceType) {
        url = [NSURL URLWithString: [NSString stringWithFormat:@"%@",item.image.webLink]];
    } else {
        url = [NSURL URLWithString: [NSString stringWithFormat:@"%@w=%d",item.image.webLink,quality]];
    }

    dispatch_queue_t queue;
    if (quality == ImageQualityHigh) {
     queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    } else {
     queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    }
    
    dispatch_async(queue, ^{
        NSData* data = [NSData dataWithContentsOfURL:url];
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(data);
        });
    });
  
//    NSURLSessionDownloadTask* task =
//    [[NSURLSession sharedSession]
//     downloadTaskWithURL:url
//       completionHandler:^(NSURL * location, NSURLResponse * response, NSError * error) {
//           item.image.localLink = location.absoluteString;
//           NSData* data = [NSData dataWithContentsOfURL:location options:NSDataReadingMappedIfSafe error:nil];
//           dispatch_async(dispatch_get_main_queue(), ^{
//               completion(data);
//           });
//       }];
//    [task resume];
    
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionDataTask *task = [session dataTaskWithURL:url
//                                        completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//
//            completion(data);
//        });
//        [session invalidateAndCancel];
//    }];
//    [task resume];
}
@end
