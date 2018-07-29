//
//  Downloader.h
//  PadcastsApp
//
//  Created by Dzmitry Tarelkin on 7/26/18.
//  Copyright © 2018 Dzmitry Tarelkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ServiceManager.h"

@interface Downloader : NSObject <DownloadManagerProtocol>
+(Downloader*)sharedDownloader;
@end
