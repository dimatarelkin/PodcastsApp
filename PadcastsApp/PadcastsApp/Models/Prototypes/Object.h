//
//  Object.h
//  PadcastsApp
//
//  Created by Dzmitry Tarelkin on 7/23/18.
//  Copyright © 2018 Dzmitry Tarelkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Content.h"
#import "Image.h"

typedef enum {
    MP3SourceType,
    TEDSourceType
} SourceType;


@interface Object : NSObject
@property (strong, nonatomic) NSString  * guiD;
@property (strong, nonatomic) NSString  * title;
@property (strong, nonatomic) NSString  * author;
@property (strong, nonatomic) NSString  * descrip;
@property (strong, nonatomic) Content   * content;
@property (strong, nonatomic) Image     * image;
@property (strong, nonatomic) NSString  * duration;
@property (strong, nonatomic) NSString  * publicationDate;
@property (assign, nonatomic) SourceType  sourceType;

@end
