//
//  Content.m
//  PadcastsApp
//
//  Created by Dzmitry Tarelkin on 7/23/18.
//  Copyright © 2018 Dzmitry Tarelkin. All rights reserved.
//

#import "Content.h"

@implementation Content
- (NSString *)description
{
    return [NSString stringWithFormat:@"Local lin - %@, webLink - %@", self.localLink, self.webLink];
}
@end
