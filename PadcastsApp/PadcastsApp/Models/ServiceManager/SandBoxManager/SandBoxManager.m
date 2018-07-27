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

@end

@implementation SandBoxManager

static NSString * const kDirectory = @"/images";

- (instancetype)init {
    self = [super init];
    if (self) {
        _fileManager = [[NSFileManager alloc] init];
        [self createDirectory];
    }
    return self;
}

-(void)createDirectory {
    _directory = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    [self createDirectoryWithPath:kDirectory];
    
    
}

-(void)createDirectoryWithPath:(NSString*)path {
    NSString *destinationPath = [self.directory stringByAppendingString:path];
    [self.fileManager createDirectoryAtPath:destinationPath withIntermediateDirectories:YES attributes:nil error:nil];
}

//removeFileAtURL

- (void)saveDataWithImage:(NSData*)data IntoSandBoxForItem:(ItemObject *)item {
    NSString *destinationPath = [self.directory stringByAppendingString:item.guiD];
    [self.fileManager createFileAtPath:destinationPath contents:data attributes:nil];
    item.image.localLink = destinationPath;
    
}

- (UIImage *)fetchImageFromSandBoxForItem:(ItemObject *)item {
    NSString *destinationPath = [self.directory stringByAppendingString:item.guiD];
    return [UIImage imageWithContentsOfFile:destinationPath];
}

//
//
//
//
//- (ItemObject *)fetchContentfromSandBox:(ItemObject *)item {
//    <#code#>
//}
//
//
//- (void)saveContent:(NSObject *)content IntoSandBoxForItem:(ItemObject *)item {
//    <#code#>
//}



@end
