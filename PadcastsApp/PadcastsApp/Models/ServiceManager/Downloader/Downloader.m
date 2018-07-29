//
//  Downloader.m
//  PadcastsApp
//
//  Created by Dzmitry Tarelkin on 7/26/18.
//  Copyright © 2018 Dzmitry Tarelkin. All rights reserved.
//

#import "Downloader.h"
#import "SandBoxManager.h"


@interface Downloader() <NSURLSessionDelegate>
@property (strong, nonatomic) NSURL* currentURL;
@property (strong, nonatomic) NSMutableArray* blocks;
@end

@implementation Downloader


+(Downloader*)sharedDownloader {
    static Downloader* downloader = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        downloader = [[Downloader alloc] init];
        downloader.blocks = [NSMutableArray array];
    });
    return downloader;
}


-(void)downloadImageForItem:(ItemObject*)item withImageQuality:(ImageQuality)quality
        withCompletionBlock:(void(^)(NSData*data)) completion {
   
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
  
    
    
    dispatch_block_t block = dispatch_block_create(0, ^{
        NSURLSessionDownloadTask* task =
        [[NSURLSession sharedSession]
         downloadTaskWithURL:url
         completionHandler:^(NSURL * location, NSURLResponse * response, NSError * error) {
             
             dispatch_async(queue, ^{
                item.image.localLink = location.absoluteString;
                NSData* data = [NSData dataWithContentsOfURL:location options:NSDataReadingMappedIfSafe error:nil];
                [[SandBoxManager sharedSandBoxManager] saveDataWithImage:data IntoSandBoxForItem:item];
                 
                 dispatch_async(dispatch_get_main_queue(), ^{
                     completion(data);
                 });
             });
         }];
        [task resume];
    });
    
    //array of block
    [self.blocks addObject:block];
    block();
    
//    NSLog(@"counted blocks %lu",(unsigned long)self.blocks.count);
    
}
//
//- (void)cancelTasksThatDontNeedToBeDone:(NSInteger)task {
//    for (dispatch_block_t block in self.blocks) {
//        if ([self.blocks[task] isEqual:block]) {
//            dispatch_block_cancel(block);
//        }
//    }
//}

//-(void)downloadContentForItem:(ItemObject*)item {
//    NSURL *url = [NSURL URLWithString:item.content.webLink];
//
//    NSURLSessionConfiguration *config =
//    [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:item.content.webLink];
//    [config setDiscretionary:YES];
//    [config setSessionSendsLaunchEvents:YES];
//
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
//
//    NSURLSessionDownloadTask* downloadTask =
//    [session downloadTaskWithURL:url
//               completionHandler:^(NSURL * location, NSURLResponse * response, NSError * error) {
//                   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//                       NSData* data = [NSData dataWithContentsOfURL:location options:NSDataReadingMappedIfSafe error:nil];
//
//                       dispatch_async(dispatch_get_main_queue(), ^{
//                           NSLog(@"Downloading is Finished");
//                       });
//                   });
//               }];
//    [downloadTask resume];
//
//}


@end
