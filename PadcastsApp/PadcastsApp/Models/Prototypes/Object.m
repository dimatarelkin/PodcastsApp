//
//  Object.m
//  PadcastsApp
//
//  Created by Dzmitry Tarelkin on 7/23/18.
//  Copyright © 2018 Dzmitry Tarelkin. All rights reserved.
//

#import "Object.h"

@implementation Object

- (NSString *)description {
    return [NSString stringWithFormat:@"\n ID - %@\n title - %@\n author - %@\n description - %@\n content - %@\n image - %@\n duration - %@\n publicationDate - %@\n sourceType - %@",
            self.guiD, self.title,
            self.author, self.descrip,
            [self.content description], [self.image description],
            self.duration, self.publicationDate,
            self.sourceType == 0 ? @"MP3":@"TED"];
}


@end
