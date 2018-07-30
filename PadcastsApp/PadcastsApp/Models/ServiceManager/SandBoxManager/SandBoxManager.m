//
//  SandBoxManager.m
//  PadcastsApp
//
//  Created by Dzmitry Tarelkin on 7/26/18.
//  Copyright © 2018 Dzmitry Tarelkin. All rights reserved.
//

#import "SandBoxManager.h"

@interface SandBoxManager()
@property (strong,nonatomic) NSString * directory;
@property (strong, nonatomic) NSFileManager* fileManager;

@property (assign, nonatomic) int counter;
@end

@implementation SandBoxManager

static NSString * const kDirectory = @"/Images";


+(SandBoxManager*)sharedSandBoxManager {
    static SandBoxManager* manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SandBoxManager alloc] init];
        manager.counter = 0;
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _fileManager = [NSFileManager defaultManager];
        [self createDirectory];
    }
    return self;
}

-(void)createDirectory {
    self.directory = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    [self createDirectoryWithPath:kDirectory];
    
    
}

-(void)createDirectoryWithPath:(NSString*)path {
    NSString *destinationPath = [self.directory stringByAppendingPathComponent:path];
    self.directory = destinationPath;
    [self.fileManager createDirectoryAtPath:destinationPath withIntermediateDirectories:NO attributes:nil error:nil];
}

//removeFileAtURL

- (void)saveDataWithImage:(NSData*)data IntoSandBoxForItem:(ItemObject *)item {
    
    NSString *destinationPath = [self.directory stringByAppendingPathComponent:item.guiD];
    
    [self.fileManager createFileAtPath:destinationPath contents:data attributes:nil];
    item.image.localLink = destinationPath;
    NSLog(@"link = %@",destinationPath);
    
}


- (UIImage *)fetchImageFromSandBoxForItem:(ItemObject *)item {
    
    if ([self.fileManager fileExistsAtPath:item.image.localLink]) {
        NSData *data = [NSData dataWithContentsOfFile:item.image.localLink];
        return [UIImage imageWithData:data];
    } else {
        NSLog(@"filie don't exists");
        return nil;
    }
    
}


#warning sandbox content downloading
- (ItemObject *)fetchContentfromSandBox:(ItemObject *)item {
    return item;
}


- (void)saveContent:(NSObject *)content IntoSandBoxForItem:(ItemObject *)item {
    
}






@end
